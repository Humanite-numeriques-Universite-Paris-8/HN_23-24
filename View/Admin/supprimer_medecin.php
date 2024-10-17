<?php
require_once '../../config/database.php'; // Ensure the path is correct

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $medecin_id = $_POST['medecin_id'];

    $conn = connectDB();
    
    // Remove the doctor without deleting the cabinet
    $query = "UPDATE cabinets SET docteur_id = NULL WHERE docteur_id = :medecin_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':medecin_id', $medecin_id);

    // First, set docteur_id to NULL in the cabinets table
    if ($stmt->execute()) {
        // Now, delete the doctor from the users table
        $delete_query = "DELETE FROM users WHERE id = :medecin_id AND role = 'medecin'";
        $delete_stmt = $conn->prepare($delete_query);
        $delete_stmt->bindParam(':medecin_id', $medecin_id);
        
        if ($delete_stmt->execute()) {
            // Success message
            header("Location: getMedecin.php?success=1");
            exit();
        } else {
            echo "Erreur lors de la suppression du médecin.";
        }
    } else {
        echo "Erreur lors de la mise à jour du cabinet.";
    }
}
?>
