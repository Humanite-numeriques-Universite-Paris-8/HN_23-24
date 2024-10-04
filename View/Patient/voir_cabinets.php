<?php
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

$query = "SELECT cabinets.nom AS cabinet_nom, cabinets.adresse, users.username AS docteur_nom
          FROM cabinets
          JOIN users ON cabinets.docteur_id = users.id
          WHERE users.role = 2";  // 2 étant le rôle médecin
          
$result = $conn->query($query);

if ($result->rowCount() > 0) {
    echo "<table border='1' cellpadding='10'>";
    echo "<tr><th>Nom du Cabinet</th><th>Adresse</th></tr>";
    
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . $row['cabinet_nom'] . "</td>"; // Utilise l'alias cabinet_nom
        echo "<td>" . $row['adresse'] . "</td>";
        echo "</tr>";
    }
    
    echo "</table>";
} else {
    echo "Aucun cabinet trouvé.";
}
?>
