<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Récupérer les données du formulaire
    $nom = $_POST['nom'];
    $adresse = $_POST['adresse'];
    $docteur_id = $_POST['docteur_id'];
    $cabinet_id = $_POST['cabinet_id']; // ID du cabinet

    // Valider que tous les champs sont remplis
    if (empty($nom) || empty($adresse) || empty($docteur_id)) {
        echo "Tous les champs doivent être remplis.";
    } else {
        // Préparer la requête de mise à jour
        $query = "UPDATE cabinets SET nom = :nom, adresse = :adresse, docteur_id = :docteur_id WHERE id = :cabinet_id";
        $stmt = $conn->prepare($query);

        // Liaison des paramètres
        $stmt->bindParam(':nom', $nom);
        $stmt->bindParam(':adresse', $adresse);
        $stmt->bindParam(':docteur_id', $docteur_id);
        $stmt->bindParam(':cabinet_id', $cabinet_id);

        // Exécuter la requête
        if ($stmt->execute()) {
            // Rediriger vers la page de liste des cabinets avec un message de succès
            header("Location: voir_cabinets.php?success=Le cabinet a été modifié avec succès.");
            exit();
        } else {
            echo "Erreur lors de la modification du cabinet.";
        }
    }
}

// Récupération des données du cabinet à modifier
$cabinet_id = $_GET['id'];
$query = "SELECT * FROM cabinets WHERE id = :id";
$stmt = $conn->prepare($query);
$stmt->bindParam(':id', $cabinet_id);
$stmt->execute();
$cabinet = $stmt->fetch(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Cabinet</title>
    <link rel="stylesheet" href="../css/modifier_cabinet.css"> <!-- Assurez-vous que ce chemin est correct -->

</head>
<body>
    <h1>Modifier Cabinet</h1>
    <?php if (isset($_GET['success'])): ?>
        <p class="success"><?php echo htmlspecialchars($_GET['success']); ?></p>
    <?php endif; ?>
    <form action="modifier_cabinet.php" method="POST">
        <input type="hidden" name="cabinet_id" value="<?php echo $cabinet['id']; ?>"> <!-- Champ caché pour l'ID du cabinet -->
        <label for="nom">Nom du Cabinet:</label>
        <input type="text" name="nom" id="nom" value="<?php echo htmlspecialchars($cabinet['nom']); ?>" required>
        
        <label for="adresse">Adresse du Cabinet:</label>
        <input type="text" name="adresse" id="adresse" value="<?php echo htmlspecialchars($cabinet['adresse']); ?>" required>
        
        <label for="docteur_id">Docteur (ID):</label>
        <select name="docteur_id" id="docteur_id">
            <?php
            $stmt = $conn->query("SELECT id, username FROM users WHERE role = 2");
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $selected = ($row['id'] == $cabinet['docteur_id']) ? 'selected' : '';
                echo "<option value='" . $row['id'] . "' $selected>" . $row['username'] . " (ID: " . $row['id'] . ")</option>";
            }
            ?>
        </select>

        <button type="submit">Modifier le Cabinet</button>
    </form>
</body>
</html>
