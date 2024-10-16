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

// If the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $phone = $_POST['phone'];

    // Update the doctor's phone number
    $query = "UPDATE users SET phone = :phone WHERE id = :user_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':phone', $phone);
    $stmt->bindParam(':user_id', $user_id);

    if ($stmt->execute()) {
        $success_message = "Votre profil a été mis à jour avec succès.";
    } else {
        $error_message = "Erreur lors de la mise à jour du profil.";
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
    <link rel="stylesheet" href="../Medecin/css/medecin_dashboard.css"> <!-- Adjust path if needed -->
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

            <button type="submit" class="btn">Mettre à Jour</button>
        </form>

        <a href="medecin_dashboard.php" class="btn">Retour au Tableau de Bord</a>
    </div>
</body>
</html>
