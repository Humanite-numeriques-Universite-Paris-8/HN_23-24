<?php
session_start();
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

// Vérifiez si l'utilisateur est bien connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Vérifier si un ID de rendez-vous est passé dans l'URL
if (isset($_GET['id'])) {
    $appointment_id = $_GET['id'];

    // Mettre à jour le rendez-vous pour le marquer comme validé
    $query = "UPDATE appointments SET is_validated = 1 WHERE id = :appointment_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':appointment_id', $appointment_id);

    if ($stmt->execute()) {
        // Redirection avec un message de succès
        header("Location: Lister_Rdv.php?success=Le rendez-vous a été validé avec succès.");
        exit();
    } else {
        echo "Erreur lors de la validation du rendez-vous.";
    }
} else {
    echo "Aucun ID de rendez-vous fourni.";
}
?>
