<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Vérifiez si l'utilisateur est connecté et est un admin
session_start();
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Connexion à la base de données
$conn = connectDB();

// Initialiser les variables
$medecin_id = $medecin_name = $medecin_email = $medecin_phone = $specialite = $cabinet_id = "";

// Récupérer la liste des médecins
$query_medecins = "SELECT id, username, email, phone FROM users WHERE role = 'medecin'";
$stmt_medecins = $conn->prepare($query_medecins);
$stmt_medecins->execute();
$medecins = $stmt_medecins->fetchAll(PDO::FETCH_ASSOC);

// Récupérer la liste des cabinets
$query_cabinets = "SELECT id, nom, specialite FROM cabinets";
$stmt_cabinets = $conn->prepare($query_cabinets);
$stmt_cabinets->execute();
$cabinets = $stmt_cabinets->fetchAll(PDO::FETCH_ASSOC);

// Vérifier si l'ID du médecin est passé en paramètre
if (isset($_GET['id'])) {
    $medecin_id = $_GET['id'];

    // Récupérer les informations du médecin à modifier
    $query = "SELECT username, email, phone FROM users WHERE id = :medecin_id AND role = 'medecin'";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':medecin_id', $medecin_id);
    $stmt->execute();
    $medecin = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($medecin) {
        $medecin_name = $medecin['username'];
        $medecin_email = $medecin['email'];
        $medecin_phone = $medecin['phone'];
    } else {
        echo "Médecin introuvable.";
        exit();
    }
}

// Si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $medecin_id = $_POST['medecin_id']; // ID du médecin sélectionné
    $medecin_phone = $_POST['medecin_phone'];
    $cabinet_id = $_POST['cabinet_id'];
    $specialite = $_POST['specialite']; // Spécialité mise à jour

    // Mettre à jour la spécialité du cabinet sélectionné
    $update_specialite_query = "UPDATE cabinets SET specialite = :specialite WHERE id = :cabinet_id";
    $update_specialite_stmt = $conn->prepare($update_specialite_query);
    $update_specialite_stmt->bindParam(':specialite', $specialite);
    $update_specialite_stmt->bindParam(':cabinet_id', $cabinet_id);
    $update_specialite_stmt->execute();

    // Mettre à jour les informations du médecin
    $update_query = "UPDATE users SET username = :medecin_name, email = :medecin_email, phone = :medecin_phone WHERE id = :medecin_id AND role = 'medecin'";
    $update_stmt = $conn->prepare($update_query);
    $update_stmt->bindParam(':medecin_name', $medecin_name);
    $update_stmt->bindParam(':medecin_email', $medecin_email);
    $update_stmt->bindParam(':medecin_phone', $medecin_phone);
    $update_stmt->bindParam(':medecin_id', $medecin_id);

    if ($update_stmt->execute()) {
        header("Location: getMedecin.php?success=1");
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
    <title>Modifier Médecin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-size: 24px;
            color: #007bff;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #333;
            text-align: left;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 16px;
            box-sizing: border-box;
        }

        button.btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button.btn:hover {
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

        a.btn {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        a.btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Modifier Médecin</h2>

        <?php if (!empty($error_message)): ?>
            <div class="error"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <form action="modifier_medecin.php?id=<?php echo $medecin_id; ?>" method="POST">
            <label for="medecin_id">Sélectionnez le Médecin:</label>
            <select name="medecin_id" id="medecin_id" required>
                <option value="">Sélectionner un médecin</option>
                <?php foreach ($medecins as $medecin): ?>
                    <option value="<?php echo htmlspecialchars($medecin['id']); ?>" <?php echo $medecin['id'] == $medecin_id ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($medecin['username']); ?> (<?php echo htmlspecialchars($medecin['email']); ?>)
                    </option>
                <?php endforeach; ?>
            </select>

            <label for="medecin_phone">Numéro de Téléphone:</label>
            <input type="text" id="medecin_phone" name="medecin_phone" required value="<?php echo htmlspecialchars($medecin_phone); ?>">

            <!-- Afficher la spécialité du cabinet sélectionné -->
         
            </select>

            <button type="submit" class="btn">Mettre à Jour</button>
        </form>

        <a href="getMedecin.php" class="btn">Retour à la Liste des Médecins</a>
    </div>
</body>
</html>
