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

    // Delete the appointment from the database
    $query = "DELETE FROM appointments WHERE id = :appointment_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':appointment_id', $appointment_id);

    if ($stmt->execute()) {
        // Redirect after successful deletion
        header("Location: Lister_Rdv.php?success=Le rendez-vous a été annulé avec succès.");
        exit();
    } else {
        echo "Erreur lors de l'annulation du rendez-vous.";
    }
} else {
    echo "Aucun ID de rendez-vous fourni.";
}
