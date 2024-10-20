<?php
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

$search_term = isset($_GET['search_term']) ? $_GET['search_term'] : '';

if (!empty($search_term)) {
    // Check if the search term contains both specialty and doctor name
    if (strpos($search_term, ' - ') !== false) {
        // Split the search term into specialty and doctor name
        list($specialite, $docteur_name) = explode(' - ', $search_term);

        // Query to search by both specialty and doctor name
        $query = "SELECT c.nom AS cabinet_name, c.specialite, u.username AS docteur_name
                  FROM cabinets c
                  JOIN users u ON c.docteur_id = u.id
                  WHERE c.specialite LIKE :specialite AND u.username LIKE :docteur_name";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':specialite', $specialite);
        $stmt->bindParam(':docteur_name', $docteur_name);
    } else {
        // Query to search either by specialty or doctor name
        $query = "SELECT c.nom AS cabinet_name, c.specialite, u.username AS docteur_name
                  FROM cabinets c
                  JOIN users u ON c.docteur_id = u.id
                  WHERE c.specialite LIKE :search_term OR u.username LIKE :search_term";
        $stmt = $conn->prepare($query);
        $search_term_wildcard = "%" . $search_term . "%";
        $stmt->bindParam(':search_term', $search_term_wildcard);
    }

    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultats de recherche</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .btn-reserver {
            background-color: #28a745;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-reserver:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Résultats de recherche pour "<?php echo htmlspecialchars($search_term); ?>"</h2>

    <?php if (!empty($results)): ?>
        <table>
            <thead>
                <tr>
                    <th>Nom du Cabinet</th>
                    <th>Spécialité</th>
                    <th>Docteur</th>
                    <th>Action</th> <!-- New Action column -->
                </tr>
            </thead>
            <tbody>
                <?php foreach ($results as $result): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($result['cabinet_name']); ?></td>
                        <td><?php echo htmlspecialchars($result['specialite']); ?></td>
                        <td><?php echo htmlspecialchars($result['docteur_name']); ?></td>
                        <td>
                            <!-- Button to redirect to reserver_rdv.php -->
                            <a href="reserver_rdv.php" class="btn-reserver">Réserver</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Aucun cabinet trouvé pour ce terme de recherche.</p>
    <?php endif; ?>
</div>

</body>
</html>
