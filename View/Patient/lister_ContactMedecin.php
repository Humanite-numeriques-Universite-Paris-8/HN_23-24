<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Requête SQL pour récupérer la liste des médecins avec leurs cabinets associés
$query = "
    SELECT c.nom AS cabinet_nom, c.adresse AS adresse_cabinet, c.specialite, 
           d.username AS docteur_nom, d.email AS docteur_email, d.phone AS docteur_phone
    FROM cabinets c
    LEFT JOIN users d ON c.docteur_id = d.id
    WHERE d.role = 2"; // Le rôle 2 est généralement attribué aux médecins

// Préparation et exécution de la requête
$stmt = $conn->prepare($query);
$stmt->execute();
$medecins = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Contacts des Médecins</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
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

        p {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>

    <h1>Liste des Contacts des Médecins</h1>
    
    <?php if (count($medecins) > 0): ?>
        <table>
            <tr>
                <th>Nom du Cabinet</th>
                <th>Adresse du Cabinet</th>
                <th>Nom du Docteur</th>
                <th>Email du Docteur</th>
                <th>Numéro de Téléphone</th>
                <th>Spécialité</th>
            </tr>
            <?php foreach ($medecins as $medecin): ?>
                <tr>
                    <td><?php echo htmlspecialchars($medecin['cabinet_nom']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['adresse_cabinet']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['docteur_nom']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['docteur_email']); ?></td>
                    <td><?php echo htmlspecialchars($medecin['docteur_phone'] ?? 'Non renseigné'); ?></td>
                    <td><?php echo htmlspecialchars($medecin['specialite']); ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php else: ?>
        <p>Aucun médecin trouvé.</p>
    <?php endif; ?>

</body>
</html>
