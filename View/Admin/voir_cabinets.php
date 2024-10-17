<?php
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

// Handle cabinet deletion requests
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];
    
    // Delete the cabinet only (without affecting doctors)
    $delete_query = "DELETE FROM cabinets WHERE id = :cabinet_id";
    $delete_stmt = $conn->prepare($delete_query);
    $delete_stmt->bindParam(':cabinet_id', $delete_id);

    if ($delete_stmt->execute()) {
        header("Location: voir_cabinets.php?success=Cabinet supprimé avec succès.");
        exit();
    } else {
        header("Location: voir_cabinets.php?error=Erreur lors de la suppression du cabinet.");
        exit();
    }
}

// Query to get all cabinets with their associated doctor info
$query = "SELECT cabinets.id, cabinets.nom AS cabinet_nom, cabinets.adresse, cabinets.specialite, users.username AS docteur_nom
          FROM cabinets
          LEFT JOIN users ON cabinets.docteur_id = users.id"; // LEFT JOIN ensures no issues when a doctor is missing

$result = $conn->query($query);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Cabinets</title>
    <link rel="stylesheet" href="../Admin/css/lister_cabinet.css"> <!-- Link to your CSS file -->
</head>
<body>

<?php
// Display success or error messages
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
        echo "<td>" . (!is_null($row['specialite']) ? htmlspecialchars($row['specialite']) : 'Non spécifié') . "</td>";
        echo "<td>" . htmlspecialchars($row['docteur_nom'] ?? 'Non défini') . "</td>";
        echo "<td>
              <a href='../Admin/modifier_cabinet.php?id=" . $row['id'] . "' class='action-link modify'>Modifier</a>
              |
              <a href='?delete_id=" . $row['id'] . "' class='action-link delete' onclick=\"return confirm('Êtes-vous sûr de vouloir supprimer ce cabinet?');\">Supprimer</a>
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
