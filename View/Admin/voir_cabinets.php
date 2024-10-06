<?php
require_once '../../config/database.php'; // Assurez-vous que ce chemin est correct

$conn = connectDB();

// Requête pour récupérer tous les cabinets avec les informations des docteurs et des spécialités
$query = "SELECT cabinets.id, cabinets.nom AS cabinet_nom, cabinets.adresse, cabinets.specialite, users.username AS docteur_nom
          FROM cabinets
          JOIN users ON cabinets.docteur_id = users.id";

$result = $conn->query($query);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Cabinets</title>
    <link rel="stylesheet" href="../Admin/css/lister_cabinet.css"> <!-- Lien vers votre fichier CSS -->
</head>
<body>

<?php
// Affichage des messages de succès ou d'erreur
if (isset($_GET['success'])) {
    echo "<p class='success'>" . htmlspecialchars($_GET['success']) . "</p>";
} elseif (isset($_GET['error'])) {
    echo "<p class='error'>" . htmlspecialchars($_GET['error']) . "</p>";
}

if ($result->rowCount() > 0) {
    echo "<table class='cabinet-table'>";
    echo "<tr><th>Nom du Cabinet</th><th>Adresse</th><th>Spécialité</th><th>Docteur</th><th>Actions</th></tr>";
    
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['cabinet_nom']) . "</td>";
        echo "<td>" . htmlspecialchars($row['adresse']) . "</td>";
        echo "<td>" . (!is_null($row['specialite']) ? htmlspecialchars($row['specialite']) : 'Non spécifié') . "</td>"; // Correction ici pour éviter l'erreur
        echo "<td>" . htmlspecialchars($row['docteur_nom']) . "</td>"; // Assurez-vous d'afficher le nom du docteur ici
        echo "<td>
              <a href='../Admin/modifier_cabinet.php?id=" . $row['id'] . "' class='action-link modify'>Modifier</a>
              |
              <a href='supprimer_cabinet.php?id=" . $row['id'] . "' class='action-link delete' onclick=\"return confirm('Êtes-vous sûr de vouloir supprimer ce cabinet?');\">Supprimer</a>
              </td>";
        echo "</tr>";
    }
    
    echo "</table>";
} else {
    echo "<p>Aucun cabinet trouvé.</p>";
}
?>

</body>
</html>
