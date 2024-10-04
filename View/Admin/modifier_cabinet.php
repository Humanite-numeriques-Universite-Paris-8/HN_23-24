<?php
require_once '../../config/database.php'; // Ensure this path is correct

$conn = connectDB();

// Check if the ID is set in the URL
if (isset($_GET['id'])) {
    $cabinet_id = $_GET['id'];

    // Fetch the cabinet details from the database
    $query = "SELECT * FROM cabinets WHERE id = :id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':id', $cabinet_id);
    $stmt->execute();
    $cabinet = $stmt->fetch(PDO::FETCH_ASSOC);

    // If the cabinet is found, display its details in the form
    if ($cabinet) {
        $successMessage = '';  // Variable to store the success message
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Get the updated values from the form
            $nom = $_POST['nom'];
            $adresse = $_POST['adresse'];
            $docteur_id = $_POST['docteur_id'];

            // Update the cabinet in the database
            $updateQuery = "UPDATE cabinets SET nom = :nom, adresse = :adresse, docteur_id = :docteur_id WHERE id = :id";
            $updateStmt = $conn->prepare($updateQuery);
            $updateStmt->bindParam(':nom', $nom);
            $updateStmt->bindParam(':adresse', $adresse);
            $updateStmt->bindParam(':docteur_id', $docteur_id);
            $updateStmt->bindParam(':id', $cabinet_id);

            if ($updateStmt->execute()) {
                // Set the success message
                $successMessage = "Le cabinet a été modifié avec succès.";
            } else {
                echo "Erreur lors de la modification du cabinet.";
            }
        }
    } else {
        echo "Cabinet non trouvé.";
    }
} else {
    echo "ID du cabinet manquant.";
}
?>

<!-- Formulaire pour modifier le cabinet -->
<div class="container">
    <?php if (!empty($successMessage)): ?>
        <div class="alert success">
            <?php echo htmlspecialchars($successMessage); ?>
        </div>
    <?php endif; ?>
    
    <form action="modifier_cabinet.php?id=<?php echo htmlspecialchars($cabinet_id); ?>" method="POST">
        <label for="nom">Nom du Cabinet:</label>
        <input type="text" name="nom" id="nom" value="<?php echo htmlspecialchars($cabinet['nom']); ?>" required>

        <label for="adresse">Adresse du Cabinet:</label>
        <input type="text" name="adresse" id="adresse" value="<?php echo htmlspecialchars($cabinet['adresse']); ?>" required>

        <label for="docteur_id">Docteur (ID):</label>
        <select name="docteur_id" id="docteur_id">
            <?php
            $stmt = $conn->query("SELECT id, username FROM users WHERE role = 2");  // 2 corresponds to the 'doctor' role
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $selected = ($row['id'] == $cabinet['docteur_id']) ? "selected" : "";
                echo "<option value='" . $row['id'] . "' $selected>" . $row['username'] . " (ID: " . $row['id'] . ")</option>";
            }
            ?>
        </select>

        <button type="submit">Modifier le Cabinet</button>
    </form>
</div>

<!-- Add your CSS below -->
<style>
/* Container styling */
.container {
    max-width: 600px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

/* Form styling */
form label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
}

form input[type="text"],
form select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

form button[type="submit"] {
    background-color: #28a745;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    width: 100%;
}

form button[type="submit"]:hover {
    background-color: #218838;
}

/* Success alert styling */
.alert.success {
    background-color: #d4edda;
    color: #155724;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #c3e6cb;
    border-radius: 5px;
    font-size: 16px;
}
</style>
