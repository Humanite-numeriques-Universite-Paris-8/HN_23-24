<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

$search_term = isset($_GET['search_term']) ? $_GET['search_term'] : '';

if (!empty($search_term)) {
    // Vérifier si le terme de recherche contient à la fois la spécialité et le nom du docteur
    if (strpos($search_term, ' - ') !== false) {
        // Séparer le terme de recherche en spécialité et nom de docteur
        list($specialite, $docteur_name) = explode(' - ', $search_term);

        // Requête pour rechercher par spécialité et nom de docteur
        $query = "SELECT m.id AS medecin_id, m.username AS medecin_name, m.email AS medecin_email, 
                         m.phone AS medecin_phone, c.specialite, c.nom AS cabinet_name
                  FROM users m
                  LEFT JOIN cabinets c ON m.id = c.docteur_id
                  WHERE m.role = 'medecin' AND c.specialite LIKE :specialite AND m.username LIKE :docteur_name";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':specialite', $specialite);
        $stmt->bindParam(':docteur_name', $docteur_name);
    } else {
        // Requête pour rechercher soit par spécialité, soit par nom de docteur
        $query = "SELECT m.id AS medecin_id, m.username AS medecin_name, m.email AS medecin_email, 
                         m.phone AS medecin_phone, c.specialite, c.nom AS cabinet_name
                  FROM users m
                  LEFT JOIN cabinets c ON m.id = c.docteur_id
                  WHERE m.role = 'medecin' AND (c.specialite LIKE :search_term OR m.username LIKE :search_term)";
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
    <title>Liste des Médecins</title>
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
        .btn-modifier {
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-modifier:hover {
            background-color: #0056b3;
        }
        .btn-supprimer {
            background-color: #dc3545;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-supprimer:hover {
            background-color: #c82333;
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
                    <th>Nom du Médecin</th>
                    <th>Email</th>
                    <th>Téléphone</th>
                    <th>Spécialité</th>
                    <th>Cabinet Associé</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($results as $result): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($result['medecin_name']); ?></td>
                        <td><?php echo htmlspecialchars($result['medecin_email']); ?></td>
                        <td><?php echo htmlspecialchars($result['medecin_phone'] ?? 'Non renseigné'); ?></td>
                        <td><?php echo htmlspecialchars($result['specialite']); ?></td>
                        <td><?php echo htmlspecialchars($result['cabinet_name'] ?? 'Non renseigné'); ?></td>
                        <td>
                            <a href="modifier_medecin.php?id=<?php echo $result['medecin_id']; ?>" class="btn-modifier">Modifier</a>
                            <form action="supprimer_medecin.php" method="POST" style="display:inline;">
                                <input type="hidden" name="medecin_id" value="<?php echo $result['medecin_id']; ?>">
                                <button type="submit" class="btn-supprimer">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Aucun médecin trouvé pour ce terme de recherche.</p>
    <?php endif; ?>
</div>

</body>
</html>
