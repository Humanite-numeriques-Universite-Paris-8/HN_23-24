<?php
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

$query = "SELECT cabinets.nom AS cabinet_nom, cabinets.adresse, users.username AS docteur_nom
          FROM cabinets
          JOIN users ON cabinets.docteur_id = users.id
          WHERE users.role = 2";  // 2 étant le rôle médecin
          
$result = $conn->query($query);

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Cabinets</title>
    <link rel="stylesheet" href="../Patient/css/patient-listercabinet.css"> <!-- Lien vers le fichier CSS -->
</head>
<body>
    <h1>Liste des Cabinets</h1>

    <?php
    if ($result->rowCount() > 0) {
        echo "<table>";
        echo "<tr><th>Nom du Cabinet</th><th>Adresse</th></tr>";
        
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['cabinet_nom']) . "</td>"; // Utilise l'alias cabinet_nom
            echo "<td>" . htmlspecialchars($row['adresse']) . "</td>";
            echo "</tr>";
        }
        
        echo "</table>";
    } else {
        echo "<p>Aucun cabinet trouvé.</p>";
    }
    ?>
</body>
</html>
