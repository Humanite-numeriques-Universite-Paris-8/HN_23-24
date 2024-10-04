<?php
require_once '../../config/database.php'; // Ensure this path is correct

$conn = connectDB();

// Adjusted query to ensure it retrieves all cabinets without filtering out any
$query = "SELECT cabinets.id, cabinets.nom AS cabinet_nom, cabinets.adresse, users.username AS docteur_nom
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
    <link rel="stylesheet" href="../css/lister_cabinet.css"> <!-- Link to your CSS file -->
</head>
<body>

<?php
if ($result->rowCount() > 0) {
    echo "<table class='cabinet-table'>";
    echo "<tr><th>Nom du Cabinet</th><th>Adresse</th><th>Docteur</th><th>Actions</th></tr>";
    
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['cabinet_nom']) . "</td>";
        echo "<td>" . htmlspecialchars($row['adresse']) . "</td>";
        echo "<td>" . htmlspecialchars($row['docteur_nom']) . "</td>";
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
