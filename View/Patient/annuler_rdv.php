<?php
session_start();
require_once '../../config/database.php';

$conn = connectDB();

// Récupérer l'ID du rendez-vous
$appointment_id = $_GET['id'];

// Supprimer le rendez-vous
$query = "DELETE FROM appointments WHERE id = :appointment_id AND patient_id = :patient_id";
$stmt = $conn->prepare($query);
$stmt->bindParam(':appointment_id', $appointment_id);
$stmt->bindParam(':patient_id', $_SESSION['user_id']);

if ($stmt->execute()) {
    header("Location: Lister_Rdv.php?success=1");
    exit();
} else {
    echo "Erreur lors de l'annulation du rendez-vous.";
}
?>
