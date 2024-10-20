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
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('../../images/cabinet3.avif'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align content at the top */
            min-height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
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
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }

        .btn-reserver:hover {
            background-color: #218838;
        }

        .btn-reserver i {
            margin-right: 8px;
        }

        /* Icons styling */
        .fas {
            margin-right: 6px;
            font-size: 16px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            th, td {
                font-size: 12px;
            }
            .btn-reserver {
                padding: 6px 10px;
                font-size: 12px;
            }
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
                    <th>Action</th> <!-- Action column -->
                </tr>
            </thead>
            <tbody>
                <?php foreach ($results as $result): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($result['cabinet_name']); ?></td>
                        <td><?php echo htmlspecialchars($result['specialite']); ?></td>
                        <td><?php echo htmlspecialchars($result['docteur_name']); ?></td>
                        <td>
                            <!-- Button to reserve with an icon -->
                            <a href="reserver_rdv.php" class="btn-reserver">
                                <i class="fas fa-calendar-alt"></i> Réserver
                            </a>
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
