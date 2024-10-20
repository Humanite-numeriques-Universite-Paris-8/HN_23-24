<?php
require_once '../../config/database.php';

$conn = connectDB();

// Récupération de l'ID du rendez-vous à partir de l'URL
$rdv_id = isset($_GET['id']) ? $_GET['id'] : null;

// Récupération de l'ancienne date du rendez-vous
$query = "SELECT appointment_date, cabinet_id FROM appointments WHERE id = :rdv_id";
$stmt = $conn->prepare($query);
$stmt->bindParam(':rdv_id', $rdv_id);
$stmt->execute();
$appointment = $stmt->fetch(PDO::FETCH_ASSOC);

$error_message = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Vérification de la nouvelle date soumise par le formulaire
    if (isset($_POST['appointment_date']) && !empty($_POST['appointment_date'])) {
        $new_date = $_POST['appointment_date'];
        $cabinet_id = $appointment['cabinet_id'];  // Récupérer l'ID du cabinet

        // Convertir la date et l'heure en objet DateTime pour validation
        $date = new DateTime($new_date);
        $dayOfWeek = $date->format('N'); // 1 (Lundi) à 7 (Dimanche)
        $hour = (int) $date->format('H');
        $minutes = (int) $date->format('i');

        // Validation des heures et des jours ouvrés
        if ($dayOfWeek >= 6) {
            $error_message = "Erreur : Les rendez-vous ne sont pas disponibles le week-end.";
        } elseif ($hour < 9 || ($hour >= 13 && $hour < 14) || $hour >= 17 || ($hour === 16 && $minutes > 40)) {
            $error_message = "Erreur : Les rendez-vous ne sont disponibles que de 9h à 13h et de 14h à 16h40.";
        } else {
            // Vérifier si un rendez-vous existe déjà pour cette date et cette heure
            $check_query = "SELECT COUNT(*) FROM appointments WHERE cabinet_id = :cabinet_id AND appointment_date = :new_date AND id != :rdv_id";
            $check_stmt = $conn->prepare($check_query);
            $check_stmt->bindParam(':cabinet_id', $cabinet_id);
            $check_stmt->bindParam(':new_date', $new_date);
            $check_stmt->bindParam(':rdv_id', $rdv_id);
            $check_stmt->execute();
            $appointment_exists = $check_stmt->fetchColumn();

            if ($appointment_exists > 0) {
                $error_message = "Erreur : Un rendez-vous est déjà pris pour cette date et cette heure.";
            } else {
                // Mise à jour du rendez-vous
                $update_query = "UPDATE appointments SET appointment_date = :new_date WHERE id = :rdv_id";
                $stmt = $conn->prepare($update_query);
                $stmt->bindParam(':new_date', $new_date);
                $stmt->bindParam(':rdv_id', $rdv_id);

                if ($stmt->execute()) {
                    header("Location: patient_lister_rdv.php?success=1");
                    exit();
                } else {
                    $error_message = "Erreur lors de la mise à jour du rendez-vous.";
                }
            }
        }
    } else {
        $error_message = "Données invalides. La date ne peut pas être vide.";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Déplacer votre rendez-vous</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #218838;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Déplacer votre rendez-vous</h1>
        
        <?php if (!empty($error_message)): ?>
            <div class="error">
                <?php echo $error_message; ?>
            </div>
        <?php endif; ?>

        <form action="deplacer_rdv.php?id=<?php echo $rdv_id; ?>" method="POST">

            <label for="appointment_date">Nouvelle date et heure:</label>
            <input type="text" id="appointment_date" name="appointment_date" 
                   value="<?php echo isset($appointment['appointment_date']) ? date('Y-m-d\TH:i', strtotime($appointment['appointment_date'])) : ''; ?>" 
                   required>

            <button type="submit" class="btn">Déplacer</button>
        </form>
    </div>

    <!-- Include Flatpickr -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        flatpickr("#appointment_date", {
            enableTime: true,
            dateFormat: "Y-m-d H:i",
            minDate: "today",
            time_24hr: true,
            // Disable weekends (Saturday and Sunday) and time slots before 9:00, between 13:00-14:00, and after 16:40
            disable: [
                function(date) {
                    // Disable weekends
                    return (date.getDay() === 0 || date.getDay() === 6);
                }
            ],
            onChange: function(selectedDates, dateStr, instance) {
                // Disable time ranges for the selected date
                let selectedDate = selectedDates[0];
                let currentHour = selectedDate.getHours();
                let currentMinutes = selectedDate.getMinutes();

                if (currentHour < 9 || (currentHour >= 13 && currentHour < 14) || currentHour >= 17 || (currentHour === 16 && currentMinutes > 40)) {
                    instance.clear(); // Clear the invalid selection
                    alert('Les rendez-vous ne sont disponibles que de 9h à 13h et de 14h à 16h40.');
                }
            }
        });
    </script>
</body>
</html>
