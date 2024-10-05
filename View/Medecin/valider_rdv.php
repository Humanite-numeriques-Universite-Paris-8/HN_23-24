<?php
session_start();
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Check if an appointment ID was provided
if (isset($_GET['id'])) {
    $appointment_id = $_GET['id'];

    // Update the appointment status to validated
    $query = "UPDATE appointments SET is_validated = 1 WHERE id = :appointment_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':appointment_id', $appointment_id);

    if ($stmt->execute()) {
        // Redirect after successful validation
        header("Location: Lister_Rdv.php?success=Le rendez-vous a été validé avec succès.");
        exit();
    } else {
        echo "Erreur lors de la validation du rendez-vous.";
    }
} else {
    echo "Aucun ID de rendez-vous fourni.";
}
