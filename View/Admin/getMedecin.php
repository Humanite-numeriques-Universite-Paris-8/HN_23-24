<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Récupérer la liste des médecins, leur spécialité, leur email, et leur numéro de téléphone depuis la table cabinets
$query = "
    SELECT m.id AS medecin_id, m.username AS medecin_name, m.email AS medecin_email, m.phone AS medecin_phone, c.specialite, c.nom AS cabinet_name
    FROM users m
    LEFT JOIN cabinets c ON m.id = c.docteur_id
    WHERE m.role =  'medecin'"; // Le rôle 2 est attribué aux médecins

$stmt = $conn->prepare($query);
$stmt->execute();
$medecins = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Médecins</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-danger {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <h1>Liste des Médecins</h1>
    <?php if (count($medecins) > 0): ?>
        <table>
            <tr>
                <th>Nom du Médecin</th>
                <th>Email du Médecin</th>
                <th>Numéro de Téléphone</th>
                <th>Spécialité</th>
                <th>Cabinet Associé</th>
                <th>Actions</th>
            </tr>
            <?php foreach ($medecins as $medecin): ?>
                <tr>
                    <td><?php echo htmlspecialchars($medecin['medecin_name']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['medecin_email']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['medecin_phone'] ?? 'Non renseigné'); ?></td>
                    <td><?php echo htmlspecialchars($medecin['specialite'] ?? 'Non définie'); ?></td>
                    <td><?php echo htmlspecialchars($medecin['cabinet_name'] ?? 'Aucun cabinet associé'); ?></td>
                    <td>
                        <a href="modifier_medecin.php?id=<?php echo $medecin['medecin_id']; ?>" class="btn">Modifier</a>
                        <form action="supprimer_medecin.php" method="POST" style="display:inline;">
                            <input type="hidden" name="medecin_id" value="<?php echo $medecin['medecin_id']; ?>">
                            <button type="submit" class="btn btn-danger">Supprimer</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php else: ?>
        <p>Aucun médecin trouvé.</p>
    <?php endif; ?>
</body>
</html>
