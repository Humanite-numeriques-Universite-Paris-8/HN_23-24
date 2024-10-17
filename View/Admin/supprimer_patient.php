<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Vérifiez si l'utilisateur est connecté et est un admin
session_start();
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Vérifiez si l'ID du patient est passé en paramètre
if (isset($_GET['id'])) {
    $patient_id = $_GET['id'];

    // Suppression du patient
    $delete_query = "DELETE FROM users WHERE id = :patient_id AND role = 'patient'";
    $delete_stmt = $conn->prepare($delete_query);
    $delete_stmt->bindParam(':patient_id', $patient_id);

    if ($delete_stmt->execute()) {
        header("Location: getPatient.php?success=1");
        exit();
    } else {
        echo "Erreur lors de la suppression du patient.";
    }
} else {
    echo "ID du patient non fourni.";
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supprimer Patient</title>
</head>
<body>
    <h2>Supprimer Patient</h2>

    <?php if (!empty($error_message)): ?>
        <div class="error"><?php echo $error_message; ?></div>
    <?php endif; ?>

    <p>Êtes-vous sûr de vouloir supprimer ce patient ?</p>
    <a href="getPatient.php">Annuler</a>
</body>
</html>
