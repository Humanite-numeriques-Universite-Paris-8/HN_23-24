<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Initialize variables
$patient_id = $patient_name = $patient_email = $patient_phone = $securite_sociale = "";
$error_message = "";

// Check if the patient ID is passed as a parameter
if (isset($_GET['id'])) {
    $patient_id = $_GET['id'];

    // Retrieve patient information from `users` table
    $query_user = "SELECT username, email, phone FROM users WHERE id = :patient_id AND role = 'patient'";
    $stmt_user = $conn->prepare($query_user);
    $stmt_user->bindParam(':patient_id', $patient_id);
    $stmt_user->execute();
    $patient = $stmt_user->fetch(PDO::FETCH_ASSOC);

    if ($patient) {
        $patient_name = $patient['username'];
        $patient_email = $patient['email'];
        $patient_phone = $patient['phone'];
    } else {
        echo "Patient introuvable.";
        exit();
    }

    // Retrieve `securite_sociale` from `appointments` table
    $query_appointment = "SELECT securite_sociale FROM appointments WHERE patient_id = :patient_id";
    $stmt_appointment = $conn->prepare($query_appointment);
    $stmt_appointment->bindParam(':patient_id', $patient_id);
    $stmt_appointment->execute();
    $appointment = $stmt_appointment->fetch(PDO::FETCH_ASSOC);

    if ($appointment) {
        $securite_sociale = $appointment['securite_sociale'];
    } else {
        $securite_sociale = ''; // Par défaut s'il n'y a pas de RDV associé
    }
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $patient_id = $_POST['patient_id']; // ID du patient
    $patient_name = $_POST['patient_name']; // Nom du patient
    $patient_email = $_POST['patient_email']; // Email du patient
    $patient_phone = $_POST['patient_phone']; // Téléphone du patient
    $securite_sociale = $_POST['securite_sociale']; // Sécurité sociale du patient

    // Check if the phone number is used by another patient
    $check_phone_query = "SELECT id FROM users WHERE phone = :phone AND id != :patient_id";
    $check_phone_stmt = $conn->prepare($check_phone_query);
    $check_phone_stmt->bindParam(':phone', $patient_phone);
    $check_phone_stmt->bindParam(':patient_id', $patient_id);
    $check_phone_stmt->execute();
    $phone_exists = $check_phone_stmt->fetch(PDO::FETCH_ASSOC);

    if ($phone_exists) {
        $error_message = "Erreur : Ce numéro de téléphone est déjà utilisé par un autre patient.";
    } else {
        // Check if the social security number is used by another patient
        $check_ss_query = "SELECT patient_id FROM appointments WHERE securite_sociale = :securite_sociale AND patient_id != :patient_id";
        $check_ss_stmt = $conn->prepare($check_ss_query);
        $check_ss_stmt->bindParam(':securite_sociale', $securite_sociale);
        $check_ss_stmt->bindParam(':patient_id', $patient_id);
        $check_ss_stmt->execute();
        $ss_exists = $check_ss_stmt->fetch(PDO::FETCH_ASSOC);

        if ($ss_exists) {
            $error_message = "Erreur : Ce numéro de sécurité sociale est déjà utilisé.";
        } else {
            // Mettre à jour les informations du patient dans `users`
            $update_user_query = "UPDATE users SET username = :patient_name, email = :patient_email, phone = :patient_phone WHERE id = :patient_id AND role = 'patient'";
            $update_user_stmt = $conn->prepare($update_user_query);
            $update_user_stmt->bindParam(':patient_name', $patient_name);
            $update_user_stmt->bindParam(':patient_email', $patient_email);
            $update_user_stmt->bindParam(':patient_phone', $patient_phone);
            $update_user_stmt->bindParam(':patient_id', $patient_id);

            // Mettre à jour les informations de la sécurité sociale dans `appointments`
            $update_appointment_query = "UPDATE appointments SET securite_sociale = :securite_sociale WHERE patient_id = :patient_id";
            $update_appointment_stmt = $conn->prepare($update_appointment_query);
            $update_appointment_stmt->bindParam(':securite_sociale', $securite_sociale);
            $update_appointment_stmt->bindParam(':patient_id', $patient_id);

            // Exécution des deux requêtes
            if ($update_user_stmt->execute() && $update_appointment_stmt->execute()) {
                header("Location: getPatient.php?success=1");
                exit();
            } else {
                $error_message = "Erreur lors de la mise à jour des informations.";
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Patient</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 16px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Modifier Patient</h2>

        <?php if (!empty($error_message)): ?>
            <div class="error"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <form action="modifier_patient.php?id=<?php echo $patient_id; ?>" method="POST">
            <input type="hidden" name="patient_id" value="<?php echo $patient_id; ?>">

            <label for="patient_name">Nom:</label>
            <input type="text" id="patient_name" name="patient_name" value="<?php echo htmlspecialchars($patient_name); ?>" required>

            <label for="patient_email">Email:</label>
            <input type="email" id="patient_email" name="patient_email" value="<?php echo htmlspecialchars($patient_email); ?>" required>

            <label for="patient_phone">Numéro de Téléphone:</label>
            <input type="text" id="patient_phone" name="patient_phone" value="<?php echo htmlspecialchars($patient_phone); ?>" required>

            <label for="securite_sociale">Sécurité Sociale:</label>
            <input type="text" id="securite_sociale" name="securite_sociale" maxlength="21" pattern="^(\d{1}\s\d{2}\s\d{2}\s\d{2}\s\d{3}\s\d{3}\s\d{2})$" value="<?php echo htmlspecialchars($securite_sociale); ?>" required>

            <button type="submit">Mettre à Jour</button>
        </form>

        <a href="getPatient.php">Retour à la Liste des Patients</a>
    </div>

    <script>
    document.getElementById('securite_sociale').addEventListener('input', function (e) {
        let value = e.target.value.replace(/\D/g, ''); // Supprime tout sauf les chiffres
        let formattedValue = '';

        // Ajoute des espaces après les groupes spécifiques
        if (value.length > 0) { formattedValue += value.substring(0, 1) + ' '; }
        if (value.length > 1) { formattedValue += value.substring(1, 3) + ' '; }
        if (value.length > 3) { formattedValue += value.substring(3, 5) + ' '; }
        if (value.length > 5) { formattedValue += value.substring(5, 7) + ' '; }
        if (value.length > 7) { formattedValue += value.substring(7, 10) + ' '; }
        if (value.length > 10) { formattedValue += value.substring(10, 13) + ' '; }
        if (value.length > 13) { formattedValue += value.substring(13, 15); }

        e.target.value = formattedValue.trim(); // Met à jour l'input avec le format appliqué
    });
    </script>
</body>
</html>
