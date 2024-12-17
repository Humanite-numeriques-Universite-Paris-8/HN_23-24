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
$medecin_id = $medecin_name = $medecin_email = $medecin_phone = "";
$error_message = "";

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
    $medecin_name = $_POST['medecin_name']; // Nom du médecin
    $medecin_email = $_POST['medecin_email']; // Email du médecin
    $medecin_phone = $_POST['medecin_phone']; // Téléphone du médecin

    // Vérification de l'unicité du numéro de téléphone
    $query_check_phone = "SELECT id FROM users WHERE phone = :medecin_phone AND id != :medecin_id";
    $stmt_check_phone = $conn->prepare($query_check_phone);
    $stmt_check_phone->bindParam(':medecin_phone', $medecin_phone);
    $stmt_check_phone->bindParam(':medecin_id', $medecin_id);
    $stmt_check_phone->execute();

    if ($stmt_check_phone->rowCount() > 0) {
        $error_message = "Erreur : Ce numéro de téléphone est déjà utilisé par un autre médecin.";
    } else {
        // Vérification de l'unicité de l'email
        $query_check_email = "SELECT id FROM users WHERE email = :medecin_email AND id != :medecin_id";
        $stmt_check_email = $conn->prepare($query_check_email);
        $stmt_check_email->bindParam(':medecin_email', $medecin_email);
        $stmt_check_email->bindParam(':medecin_id', $medecin_id);
        $stmt_check_email->execute();

        if ($stmt_check_email->rowCount() > 0) {
            $error_message = "Erreur : Cet email est déjà utilisé par un autre médecin.";
        } else {
            // Vérification de l'unicité du nom d'utilisateur
            $query_check_username = "SELECT id FROM users WHERE username = :medecin_name AND id != :medecin_id";
            $stmt_check_username = $conn->prepare($query_check_username);
            $stmt_check_username->bindParam(':medecin_name', $medecin_name);
            $stmt_check_username->bindParam(':medecin_id', $medecin_id);
            $stmt_check_username->execute();

            if ($stmt_check_username->rowCount() > 0) {
                $error_message = "Erreur : Ce nom d'utilisateur est déjà utilisé par un autre médecin.";
            } else {
                // Si tout est bon, mise à jour des informations du médecin
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
        }
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
            margin: 0;
            padding: 0;
            background-image: url('../../images/cabinet.jpg'); /* Update the path with the correct image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;margin-bottom: 60px; 
            max-width: 450px;
            background-color: rgba(255, 255, 255, 0.9); /* Light transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h2 {
            color: #007bff;
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 16px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 6px;
        }

        a {
            color: #007bff;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            font-size: 16px;
        }

        a:hover {
            text-decoration: underline;
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
            <input type="hidden" name="medecin_id" value="<?php echo $medecin_id; ?>">

            <label for="medecin_name">Nom du Médecin:</label>
            <input type="text" id="medecin_name" name="medecin_name" value="<?php echo htmlspecialchars($medecin_name); ?>" required>

            <label for="medecin_email">Email:</label>
            <input type="email" id="medecin_email" name="medecin_email" value="<?php echo htmlspecialchars($medecin_email); ?>" required>

            <label for="medecin_phone">Numéro de Téléphone:</label>
            <input type="text" id="medecin_phone" name="medecin_phone" value="<?php echo htmlspecialchars($medecin_phone); ?>" required>

            <button type="submit">Mettre à Jour</button>
        </form>

        <a href="getMedecin.php">Retour à la Liste des Médecins</a>
    </div>

</body>
</html>
