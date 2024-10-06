<?php
session_start();
require_once '../../config/database.php';

$conn = connectDB();

// Ensure the user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php"); // Redirect to login if user is not logged in
    exit();
}

// Récupérer l'ID du rendez-vous à annuler
$appointment_id = isset($_GET['id']) ? $_GET['id'] : null;

if ($appointment_id) {
    // Supprimer le rendez-vous
    $query = "DELETE FROM appointments WHERE id = :appointment_id AND patient_id = :patient_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':appointment_id', $appointment_id, PDO::PARAM_INT);
    $stmt->bindParam(':patient_id', $_SESSION['user_id'], PDO::PARAM_INT);

    // Vérifier si la suppression est réussie
    if ($stmt->execute()) {
        header("Location: patient_lister_rdv.php?success=1");
        exit();
    } else {
        echo "Erreur lors de l'annulation du rendez-vous.";
    }
} else {
    echo "ID du rendez-vous non fourni.";
}
?>
