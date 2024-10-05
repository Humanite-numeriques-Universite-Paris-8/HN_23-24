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

        // Vérifier si un rendez-vous existe déjà pour cette date et cette heure
        $check_query = "SELECT COUNT(*) FROM appointments WHERE cabinet_id = :cabinet_id AND appointment_date = :new_date AND id != :rdv_id";
        $check_stmt = $conn->prepare($check_query);
        $check_stmt->bindParam(':cabinet_id', $cabinet_id);
        $check_stmt->bindParam(':new_date', $new_date);
        $check_stmt->bindParam(':rdv_id', $rdv_id);
        $check_stmt->execute();
        $appointment_exists = $check_stmt->fetchColumn();

        if ($appointment_exists > 0) {
            // Afficher un message d'erreur si un rendez-vous est déjà pris pour cette date et cette heure
            $error_message = "Erreur : Un rendez-vous est déjà pris pour cette date et cette heure.";
        } else {
            // Préparer la requête SQL pour mettre à jour la date du rendez-vous
            $update_query = "UPDATE appointments SET appointment_date = :new_date WHERE id = :rdv_id";
            $stmt = $conn->prepare($update_query);
            $stmt->bindParam(':new_date', $new_date);
            $stmt->bindParam(':rdv_id', $rdv_id);

            // Exécuter la requête et vérifier si la mise à jour a été réussie
            if ($stmt->execute()) {
                // Rediriger avec un message de succès
                header("Location: lister_rdv.php?success=Le rendez-vous a été déplacé avec succès.");
                exit();
            } else {
                $error_message = "Erreur lors de la mise à jour du rendez-vous.";
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
    <link rel="stylesheet" href="../css/deplacer.css"> <!-- Lien vers le fichier CSS -->
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

        input[type="datetime-local"] {
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

            <label for="new_date">Nouvelle date:</label>
            <input type="datetime-local" name="appointment_date" value="<?php echo isset($appointment['appointment_date']) ? date('Y-m-d\TH:i', strtotime($appointment['appointment_date'])) : ''; ?>" required>

            <button type="submit" class="btn">Déplacer</button>
        </form>
    </div>
</body>
</html>
