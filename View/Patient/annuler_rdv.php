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
    try {
        // Désactiver temporairement les contraintes de clé étrangère si nécessaire
        $conn->exec("SET FOREIGN_KEY_CHECKS=0");

        // Supprimer le rendez-vous
        $query = "DELETE FROM appointments WHERE id = :appointment_id AND patient_id = :patient_id";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':appointment_id', $appointment_id, PDO::PARAM_INT);
        $stmt->bindParam(':patient_id', $_SESSION['user_id'], PDO::PARAM_INT);

        if ($stmt->execute()) {
            header("Location: patient_lister_rdv.php?success=1");
            exit();
        } else {
            echo "Erreur lors de l'annulation du rendez-vous.";
        }

        // Réactiver les contraintes de clé étrangère
        $conn->exec("SET FOREIGN_KEY_CHECKS=1");

    } catch (Exception $e) {
        // Réactiver les contraintes de clé étrangère en cas d'erreur
        $conn->exec("SET FOREIGN_KEY_CHECKS=1");
        echo "Erreur: " . $e->getMessage();
    }
} else {
    echo "ID du rendez-vous non fourni.";
}
?>
