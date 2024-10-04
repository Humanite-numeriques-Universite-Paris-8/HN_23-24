<?php
require_once '../../config/database.php'; // Ensure this path is correct

$conn = connectDB();

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    // Prepare the delete query
    $query = "DELETE FROM cabinets WHERE id = :id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);

    // Execute the delete query
    if ($stmt->execute()) {
        // Redirect to the view cabinets page with a success message
        header("Location: voir_cabinets.php?success=Cabinet supprimé avec succès.");
        exit();
    } else {
        echo "Erreur lors de la suppression du cabinet.";
    }
} else {
    echo "ID du cabinet non fourni.";
}
