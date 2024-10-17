<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $medecin_id = $_POST['medecin_id'];

    $conn = connectDB();
    
    // Supprimer le médecin de la table users
    $query = "DELETE FROM users WHERE id = :medecin_id AND role = 'medecin'";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':medecin_id', $medecin_id);

    if ($stmt->execute()) {
        // Redirection ou message de succès
        header("Location: getMedecin.php?success=1");
        exit();
    } else {
        // Gérer l'erreur
        echo "Erreur lors de la suppression du médecin.";
    }
}
?>
