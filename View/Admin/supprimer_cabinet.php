<?php
require_once '../../config/database.php'; // Assurez-vous que ce chemin est correct

$conn = connectDB();

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    // Préparer la requête de suppression
    $query = "DELETE FROM cabinets WHERE id = :id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);

    // Exécuter la requête de suppression
    if ($stmt->execute()) {
        // Rediriger vers la page de liste des cabinets avec un message de succès
        header("Location: voir_cabinets.php?success=Cabinet supprimé avec succès.");
        exit();
    } else {
        echo "Erreur lors de la suppression du cabinet.";
    }
} else {
    echo "ID du cabinet non fourni.";
}
