<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Cabinets</title>
    <link rel="stylesheet" href="../../css/admin_dashboard.css">
</head>
<body>

    <h1>Liste des Cabinets</h1>

    <table>
        <tr>
            <th>Nom du Cabinet</th>
            <th>Adresse</th>
            <th>Nom du Docteur</th>
        </tr>
        
        <!-- PHP Code to Fetch Cabinets from Database -->
        <?php
        // Assuming the cabinets data is fetched from the database and stored in $cabinets
        foreach ($cabinets as $cabinet) {
            echo "<tr>";
            echo "<td>" . $cabinet['cabinet_name'] . "</td>";
            echo "<td>" . $cabinet['adresse'] . "</td>";
            echo "<td>" . $cabinet['doctor_name'] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>

</body>
</html>
