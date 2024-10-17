<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Requête SQL pour récupérer la liste des patients avec la spécialité du docteur
$query = "SELECT patients.id AS patient_id, 
                 patients.username AS patient_name, 
                 patients.email AS patient_email, 
                 patients.phone AS patient_phone, 
                 appointments.securite_sociale, 
                 docteur.username AS docteur_name, 
                 cabinets.nom AS cabinet_name,
                 cabinets.specialite AS specialite
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

        .btn-modifier {
            display: inline-block;
            padding: 8px 12px;
            background-color: #28a745; /* Green background for Modifier */
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-modifier:hover {
            background-color: #218838; /* Darker green on hover */
        }

        .btn-supprimer {
            display: inline-block;
            padding: 8px 12px;
            background-color: #dc3545; /* Red background for Supprimer */
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-supprimer:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <h1>Liste des Patients</h1>
    <?php if (count($patients) > 0): ?>
        <table>
            <tr>
                <th>Nom du Patient</th>
                <th>Email</th>
                <th>Numéro Sécurité Sociale</th>
                <th>Nom du Docteur</th>
                <th>Spécialité du Docteur</th>
                <th>Cabinet</th>
                <th>Numéro de Téléphone</th>
                <th>Actions</th>
            </tr>
            <?php foreach ($patients as $patient): ?>
                <tr>
                    <td><?php echo htmlspecialchars($patient['patient_name']); ?></td>
                    <td><?php echo htmlspecialchars($patient['patient_email']); ?></td>
                    <td><?php echo htmlspecialchars($patient['securite_sociale'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['docteur_name'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['specialite'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['cabinet_name'] ?? 'Non défini'); ?></td>
                    <td><?php echo htmlspecialchars($patient['patient_phone'] ?? 'Non renseigné'); ?></td>
                    <td>
                        <a href="modifier_patient.php?id=<?php echo $patient['patient_id']; ?>" class="btn-modifier">Modifier</a>
                        <a href="supprimer_patient.php?id=<?php echo $patient['patient_id']; ?>" class="btn-supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient ?');">Supprimer</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php else: ?>
        <p>Aucun patient trouvé.</p>
    <?php endif; ?>
</body>
</html>
