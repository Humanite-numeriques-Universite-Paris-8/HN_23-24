<?php
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

if (isset($_GET['id'])) {
    $appointment_id = $_GET['id'];

    // Mettre à jour le statut du rendez-vous à "approved"
    $query = "UPDATE appointments SET status = 'approved' WHERE id = :appointment_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':appointment_id', $appointment_id);

    if ($stmt->execute()) {
        header("Location: Lister_Rdv.php?success=Le rendez-vous a été approuvé.");
        exit();
    } else {
        echo "Erreur lors de l'approbation du rendez-vous.";
    }
} else {
    echo "ID de rendez-vous non fourni.";
}
