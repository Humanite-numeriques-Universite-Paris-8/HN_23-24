<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Récupérer les données du formulaire
    $nom = $_POST['nom'];
    $adresse = $_POST['adresse'];
    $docteur_id = $_POST['docteur_id'];

    // Valider que tous les champs sont remplis
    if (empty($nom) || empty($adresse) || empty($docteur_id)) {
        echo "Tous les champs doivent être remplis.";
    } else {
        // Préparer la requête d'insertion
        $query = "INSERT INTO cabinets (nom, adresse, docteur_id) VALUES (:nom, :adresse, :docteur_id)";
        $stmt = $conn->prepare($query);

        // Liaison des paramètres
        $stmt->bindParam(':nom', $nom);
        $stmt->bindParam(':adresse', $adresse);
        $stmt->bindParam(':docteur_id', $docteur_id);

        // Exécuter la requête
        if ($stmt->execute()) {
            echo "Cabinet ajouté avec succès.";
        } else {
            echo "Erreur lors de l'ajout du cabinet.";
            print_r($stmt->errorInfo()); // Afficher l'erreur pour le débogage
        }
    }
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Cabinet</title>
    <link rel="stylesheet" href="../css/ajouter_cabinet.css"> <!-- Assurez-vous que ce chemin est correct -->
</head>
<body>

<!-- Formulaire pour ajouter un cabinet -->
<form action="ajouter_cabinet.php" method="POST">
    <label for="nom">Nom du Cabinet:</label>
    <input type="text" name="nom" id="nom" required>
    
    <label for="adresse">Adresse du Cabinet:</label>
    <input type="text" name="adresse" id="adresse" required>
    
    <label for="docteur_id">Docteur (ID):</label>
    <select name="docteur_id" id="docteur_id">
        <?php
        $stmt = $conn->query("SELECT id, username FROM users WHERE role = 2");  // 2 correspond au rôle 'médecin'
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "<option value='" . $row['id'] . "'>" . $row['username'] . " (ID: " . $row['id'] . ")</option>";
        }
        ?>
    </select>

    <button type="submit">Ajouter le Cabinet</button>
</form>

</body>
</html>
