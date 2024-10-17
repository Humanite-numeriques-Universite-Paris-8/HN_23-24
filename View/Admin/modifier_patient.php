<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Initialize variables
$patient_id = $patient_name = $patient_email = $patient_phone = "";

// Retrieve the list of patients
$query = "SELECT id, username, email, phone FROM users WHERE role = 'patient'";
$stmt = $conn->prepare($query);
$stmt->execute();
$patients = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Check if the patient ID is passed as a parameter
if (isset($_GET['id'])) {
    $patient_id = $_GET['id'];

    // Retrieve patient information
    $query = "SELECT username, email, phone FROM users WHERE id = :patient_id AND role = 'patient'";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':patient_id', $patient_id);
    $stmt->execute();
    $patient = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($patient) {
        $patient_name = $patient['username'];
        $patient_email = $patient['email'];
        $patient_phone = $patient['phone'];
    } else {
        echo "Patient introuvable.";
        exit();
    }
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $patient_id = $_POST['patient_id']; // ID of the selected patient
    $patient_name = $_POST['patient_name'];
    $patient_email = $_POST['patient_email'];

    // Update patient information without modifying the phone
    $update_query = "UPDATE users SET username = :patient_name, email = :patient_email WHERE id = :patient_id AND role = 'patient'";
    $update_stmt = $conn->prepare($update_query);
    $update_stmt->bindParam(':patient_name', $patient_name);
    $update_stmt->bindParam(':patient_email', $patient_email);
    $update_stmt->bindParam(':patient_id', $patient_id);

    if ($update_stmt->execute()) {
        header("Location: getPatient.php?success=1");
        exit();
    } else {
        $error_message = "Erreur lors de la mise à jour des informations.";
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

        select,
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
            <label for="patient_id">Sélectionnez le Patient:</label>
            <select name="patient_id" id="patient_id" required>
                <option value="">Sélectionner un patient</option>
                <?php foreach ($patients as $patient): ?>
                    <option value="<?php echo htmlspecialchars($patient['id']); ?>" <?php echo $patient['id'] == $patient_id ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($patient['username']); ?> (<?php echo htmlspecialchars($patient['email']); ?>)
                    </option>
                <?php endforeach; ?>
            </select>


            <label for="patient_phone">Numéro de Téléphone:</label>
            <input type="text" id="patient_phone" name="patient_phone" disabled value="<?php echo htmlspecialchars($patient_phone); ?>">

            <button type="submit">Mettre à Jour</button>
        </form>

        <a href="getPatient.php">Retour à la Liste des Patients</a>
    </div>
</body>
</html>
