<?php
session_start();
require_once '../../config/database.php'; // Ensure the correct path

// Check if the doctor is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

$conn = connectDB();
$user_id = $_SESSION['user_id'];
$error_message = "";
$success_message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $phone = $_POST['phone'];

    try {
        $conn->beginTransaction();

        // Vérification de l'unicité du numéro de téléphone uniquement via PHP
        $query_check_phone = "SELECT id FROM users WHERE phone = :phone AND id != :user_id";
        $stmt_check_phone = $conn->prepare($query_check_phone);
        $stmt_check_phone->bindParam(':phone', $phone);
        $stmt_check_phone->bindParam(':user_id', $user_id);  // S'assurer de ne pas vérifier pour l'utilisateur lui-même
        $stmt_check_phone->execute();

        if ($stmt_check_phone->rowCount() > 0) {
            $error_message = "Erreur : Le numéro de téléphone est déjà utilisé par un autre médecin.";
        } else {
            // Mettre à jour le numéro de téléphone du médecin si unique
            $query_users = "UPDATE users SET phone = :phone WHERE id = :user_id";
            $stmt_users = $conn->prepare($query_users);
            $stmt_users->bindParam(':phone', $phone);
            $stmt_users->bindParam(':user_id', $user_id);
            $stmt_users->execute();

            if ($stmt_users->rowCount() > 0) {
                $success_message = "Votre profil a été mis à jour avec succès.";
            } else {
                $error_message = "Erreur lors de la mise à jour du profil : aucun changement détecté.";
            }
        }

        $conn->commit();
    } catch (Exception $e) {
        $conn->rollBack();
        $error_message = "Erreur lors de la mise à jour du profil : " . $e->getMessage();
    }
}


// Retrieve the doctor's current profile information
$query = "SELECT username, email, phone FROM users WHERE id = :user_id";
$stmt = $conn->prepare($query);
$stmt->bindParam(':user_id', $user_id);
$stmt->execute();
$doctor = $stmt->fetch(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mettre à Jour Mon Profil</title>
    <style>
        /* Background and container styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('../../images/images1.jpg'); /* Change this path as needed */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 500px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
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

        input[type="tel"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
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
            border-radius: 8px;
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
            border-radius: 8px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #c3e6cb;
            border-radius: 8px;
        }

        a.btn {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            width: 100%;
        }

        a.btn:hover {
            background-color: #218838;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Mettre à Jour Mon Profil</h2>

        <?php if (!empty($error_message)): ?>
            <div class="error"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <?php if (!empty($success_message)): ?>
            <div class="success"><?php echo $success_message; ?></div>
        <?php endif; ?>

        <form action="update_profile.php" method="POST">
            <label for="phone">Numéro de Téléphone:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required value="<?php echo htmlspecialchars($doctor['phone']); ?>">

            <button style="width:80%" type="submit" class="btn">Mettre à Jour</button>
        </form>

        <a style="width:70%" href="medecin_dashboard.php" class="btn">Retour au Tableau de Bord</a>
    </div>
</body>

</html>
