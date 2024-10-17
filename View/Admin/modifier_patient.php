<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Initialize variables
$patient_id = $patient_name = $patient_email = $patient_phone = $cabinet_id = $specialite = "";

// Retrieve the list of patients
$query = "SELECT id, username, email, phone FROM users WHERE role = 'patient'";
$stmt = $conn->prepare($query);
$stmt->execute();
$patients = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Retrieve the list of cabinets
$query_cabinets = "SELECT id, nom, specialite FROM cabinets";
$stmt_cabinets = $conn->prepare($query_cabinets);
$stmt_cabinets->execute();
$cabinets = $stmt_cabinets->fetchAll(PDO::FETCH_ASSOC);

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
    $cabinet_id = $_POST['cabinet_id']; // ID du cabinet sélectionné
    $specialite = $_POST['specialite']; // Spécialité du cabinet sélectionné
    $patient_phone = $_POST['patient_phone']; // Récupérer le téléphone du formulaire

    // Mettre à jour les informations du patient
    $update_query = "UPDATE users SET phone = :patient_phone WHERE id = :patient_id AND role = 'patient'";
    $update_stmt = $conn->prepare($update_query);
    $update_stmt->bindParam(':patient_phone', $patient_phone);
    $update_stmt->bindParam(':patient_id', $patient_id);

    // Mettre à jour les informations du cabinet dans les rendez-vous
    $update_cabinet_query = "UPDATE appointments SET cabinet_id = :cabinet_id WHERE patient_id = :patient_id";
    $update_cabinet_stmt = $conn->prepare($update_cabinet_query);
    $update_cabinet_stmt->bindParam(':cabinet_id', $cabinet_id);
    $update_cabinet_stmt->bindParam(':patient_id', $patient_id);

    // Exécution des deux requêtes
    if ($update_stmt->execute() && $update_cabinet_stmt->execute()) {
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
            <input type="text" id="patient_phone" name="patient_phone"  value="<?php echo htmlspecialchars($patient_phone); ?>">

            <label for="cabinet_id">Cabinet:</label>
            <select name="cabinet_id" id="cabinet_id" required>
                <option value="">Sélectionner un cabinet</option>
                <?php foreach ($cabinets as $cabinet): ?>
                    <option value="<?php echo htmlspecialchars($cabinet['id']); ?>" <?php echo $cabinet['id'] == $cabinet_id ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($cabinet['nom']); ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <label for="specialite">Spécialité du Cabinet:</label>
            <select name="specialite" id="specialite" required>
                <?php foreach ($cabinets as $cabinet): ?>
                    <option value="<?php echo htmlspecialchars($cabinet['specialite']); ?>" <?php echo $cabinet['id'] == $cabinet_id ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($cabinet['specialite']); ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <button type="submit">Mettre à Jour</button>
        </form>

        <a href="getPatient.php">Retour à la Liste des Patients</a>
    </div>
</body>
</html>
