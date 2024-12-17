<?php
require_once '../../config/database.php'; // Ensure the path is correct
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Connexion à la base de données
$conn = connectDB();

// Requête SQL pour récupérer la liste des patients uniquement à partir de la table users
$query = "
SELECT id AS patient_id, 
       username AS patient_name, 
       email AS patient_email, 
       phone AS patient_phone
FROM users
WHERE role = 'patient'
ORDER BY id ASC
";

// Préparation et exécution de la requête
$stmt = $conn->prepare($query);
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
    
    <!-- Link to Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
      body {
    font-family: 'Roboto', sans-serif;
    background-image: url('../../images/images1.jpg'); /* Path to your image */
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: flex-start; /* Align the container at the top with space to the bottom */
    min-height: 100vh; /* Make sure the body takes the full height of the viewport */
}

.container { 
    width: 100%;
    max-width: 2000px;
    margin:  50px auto; /* Add margin to push the container down and away from the top */
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    position: relative;
    min-height: 30vh; /* Ensures the container has space at the bottom */
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
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
    text-transform: uppercase;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f1f1;
}

.btn-modifier, .btn-supprimer {
    padding: 8px 12px;
    border-radius: 4px;
    color: white;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    font-size: 14px;
}

.btn-modifier {
    background-color: #28a745;
    margin-right: 8px;
}

.btn-supprimer {
    background-color: #dc3545;
}

.btn-modifier:hover {
    background-color: #218838;
}

.btn-supprimer:hover {
    background-color: #c82333;
}

.btn-modifier i, .btn-supprimer i {
    margin-right: 6px;
}

.btn {
    transition: background-color 0.3s ease;
}
    </style>
</head>
<body>
    <div class="container">
        <h1>Liste des Patients</h1>
        <?php if (count($patients) > 0): ?>
            <table>
                <tr>
                    <th>Nom du Patient</th>
                    <th>Email</th>
                    <th>Numéro de Téléphone</th>
                    <th>Actions</th>
                </tr>
                <?php foreach ($patients as $patient): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($patient['patient_name']); ?></td>
                        <td><?php echo htmlspecialchars($patient['patient_email']); ?></td>
                        <td><?php echo htmlspecialchars($patient['patient_phone'] ?? 'Non renseigné'); ?></td>
                        <td>
                            <a href="modifier_patient.php?id=<?php echo $patient['patient_id']; ?>" class="btn-modifier btn">
                                <i class="fas fa-edit"></i>Modifier
                            </a>
                            <a href="supprimer_patient.php?id=<?php echo $patient['patient_id']; ?>" class="btn-supprimer btn" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient ?');">
                                <i class="fas fa-trash-alt"></i>Supprimer
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </table>
        <?php else: ?>
            <p>Aucun patient trouvé.</p>
        <?php endif; ?>
    </div>
</body>
</html>
