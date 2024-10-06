<?php
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

// Requête modifiée pour récupérer le nom du cabinet, l'adresse, le nom du docteur et la spécialité
$query = "SELECT cabinets.nom AS cabinet_nom, cabinets.adresse, users.username AS docteur_nom, cabinets.specialite
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
        echo "<tr><th>Nom du Cabinet</th><th>Adresse</th><th>Docteur</th><th>Spécialité</th></tr>"; // Ajout des colonnes Docteur et Spécialité
        
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['cabinet_nom']) . "</td>"; // Nom du cabinet
            echo "<td>" . htmlspecialchars($row['adresse']) . "</td>";     // Adresse du cabinet
            echo "<td>" . htmlspecialchars($row['docteur_nom']) . "</td>"; // Nom du docteur
            echo "<td>" . htmlspecialchars($row['specialite']) . "</td>";  // Spécialité du cabinet
            echo "</tr>";
        }
        
        echo "</table>";
    } else {
        echo "<p>Aucun cabinet trouvé.</p>";
    }
    ?>
</body>
</html>
