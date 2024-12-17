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
    WHERE d.role = 'medecin'"; // Le rôle 2 est généralement attribué aux médecins

// Préparation et exécution de la requête
$stmt = $conn->prepare($query);
$stmt->execute();
$medecins = $stmt->fetchAll(PDO::FETCH_ASSOC);
?><!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Contacts des Médecins</title>

    <!-- Adding Google Fonts for better typography -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-image: url('../../images/images1.jpg'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Dark overlay for better readability */
            z-index: -1; /* Make sure the overlay is behind the content */
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Light transparency for readability */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
            width: 100%;
            z-index: 1; /* Ensure the content is above the overlay */
        }

        h1 {
            text-align: center;
            color: #333;
            font-size: 32px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: 600;
        }

        td {
            color: #333;
            font-size: 14px;
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

        /* Additional styling for mobile responsiveness */
        @media (max-width: 768px) {
            th, td {
                font-size: 12px;
                padding: 10px;
            }
            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

    <div class="overlay"></div> <!-- Dark overlay for contrast with background -->

    <div class="container">
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
    </div>

</body>

</html>
