<?php
// Uncomment the line below to display errors (useful during development)
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);

// Connect to the database
require_once $_SERVER['DOCUMENT_ROOT'] . '/Projet1_Thyp_Ahef/config/database.php';

// Function to fetch cabinets
function fetchCabinets($db) {
    $stmt = $db->prepare("SELECT * FROM cabinets");
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Connect to the database
$db = connectDB();
$cabinets = fetchCabinets($db);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Cabinets</title>
    <link rel="stylesheet" href="../../../css/admin_list.css">
</head>
<body>

<h1>Liste des Cabinets</h1>

<table>
    <tr>
        <th>Nom du Cabinet</th>
        <th>Adresse</th>
        <th>Nom du Docteur</th>
    </tr>

    <?php
    // Check if cabinets array is not empty
    if (!empty($cabinets)) {
        foreach ($cabinets as $cabinet) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($cabinet['cabinet_name']) . "</td>";
            echo "<td>" . htmlspecialchars($cabinet['adresse']) . "</td>";
            echo "<td>" . htmlspecialchars($cabinet['doctor_name']) . "</td>";
            echo "</tr>";
        }
    } else {
        echo "<tr><td colspan='3'>Aucun cabinet trouvé.</td></tr>";
    }
    ?>
</table>

</body>
</html>
