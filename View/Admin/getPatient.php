<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Requête SQL pour récupérer la liste des patients avec leurs informations, docteur associé, et cabinet
$query = "SELECT patients.id AS patient_id, patients.username AS patient_name, patients.email AS patient_email, 
                 appointments.cin, appointments.securite_sociale, 
                 docteur.username AS docteur_name, cabinets.nom AS cabinet_name
          FROM users AS patients
          LEFT JOIN appointments ON appointments.patient_id = patients.id
          LEFT JOIN users AS docteur ON appointments.docteur_id = docteur.id
          LEFT JOIN cabinets ON appointments.cabinet_id = cabinets.id
          WHERE patients.role = 'patient'
          ORDER BY patients.id ASC";

// Préparation de la requête
$stmt = $conn->prepare($query);

// Exécution de la requête
$stmt->execute();

// Récupération des résultats
$patients = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Patients</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin-left: 50px;
            padding: 0;
        }

        .container {
            max-width: 85%;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            font-size: 24px;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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
            font-size: 16px;
            color: #ff0000;
        }
    </style>
</head>
<body>
    <h1>Liste des Patients</h1>
    <?php if (count($patients) > 0): ?>
        <table>
            <tr>
                <th>ID du Patient</th>
                <th>Nom du Patient</th>
                <th>Email</th>
                <th>CIN</th>
                <th>Numéro Sécurité Sociale</th>
                <th>Nom du Docteur</th>
                <th>Cabinet</th>
            </tr>
            <?php foreach ($patients as $patient): ?>
                <tr>
                    <td><?php echo htmlspecialchars($patient['patient_id']); ?></td>
                    <td><?php echo htmlspecialchars($patient['patient_name']); ?></td>
                    <td><?php echo htmlspecialchars($patient['patient_email']); ?></td>
                    <td><?php echo htmlspecialchars($patient['cin'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['securite_sociale'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['docteur_name'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['cabinet_name'] ?? 'Non défini'); ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php else: ?>
        <p>Aucun patient trouvé.</p>
    <?php endif; ?>
</body>
</html>
