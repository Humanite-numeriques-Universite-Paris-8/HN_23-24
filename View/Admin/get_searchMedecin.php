<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

$search_term = isset($_GET['search_term']) ? $_GET['search_term'] : '';

if (!empty($search_term)) {
    // Vérifier si le terme de recherche contient à la fois la spécialité et le nom du docteur
    if (strpos($search_term, ' - ') !== false) {
        // Séparer le terme de recherche en spécialité et nom de docteur
        list($specialite, $docteur_name) = explode(' - ', $search_term);

        // Ajouter les wildcards pour la recherche partielle
        $specialite = "%" . trim($specialite) . "%";
        $docteur_name = "%" . trim($docteur_name) . "%";

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
        // Ajouter les wildcards pour la recherche partielle
        $search_term_wildcard = "%" . trim($search_term) . "%";

        // Requête pour rechercher soit par spécialité, soit par nom de docteur
        $query = "SELECT m.id AS medecin_id, m.username AS medecin_name, m.email AS medecin_email, 
                         m.phone AS medecin_phone, c.specialite, c.nom AS cabinet_name
                  FROM users m
                  LEFT JOIN cabinets c ON m.id = c.docteur_id
                  WHERE m.role = 'medecin' AND (c.specialite LIKE :search_term OR m.username LIKE :search_term)";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':search_term', $search_term_wildcard);
    }

    // Exécuter la requête
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
    <!-- Link to Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
body {
    font-family: Arial, sans-serif;
    background-image: url('../../images/cabinet.jpg'); /* Replace with your background image path */
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
    margin-top: 50px; /* Reduced margin to move the table higher */
}

h2 {
    text-align: center;
    color: #007bff;
    margin-bottom: 20px;
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

.btn-modifier, .btn-supprimer {
    display: inline-block;
    padding: 8px 12px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

.btn-modifier {
    background-color: #007bff;
}

.btn-modifier:hover {
    background-color: #0056b3;
}

.btn-supprimer {
    background-color: #dc3545;
}

.btn-supprimer:hover {
    background-color: #c82333;
}

form {
    display: inline-block;
}

.btn i {
    margin-right: 6px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    th, td {
        font-size: 12px;
    }
    .btn-modifier, .btn-supprimer {
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
                                <a href="modifier_medecin.php?id=<?php echo $result['medecin_id']; ?>" class="btn-modifier">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <form action="supprimer_medecin.php" method="POST" style="display:inline;">
                                    <input type="hidden" name="medecin_id" value="<?php echo $result['medecin_id']; ?>">
                                    <button type="submit" class="btn-supprimer">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </button>
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
