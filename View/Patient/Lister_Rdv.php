<?php
session_start(); // Démarre la session en haut de la page
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

// Vérifie si l'utilisateur est connecté en vérifiant `$_SESSION['user_id']`
if (isset($_SESSION['user_id'])) {
    $patient_id = $_SESSION['user_id'];

    // Requête pour récupérer les rendez-vous du patient
    $query = "SELECT appointments.appointment_date, cabinets.nom AS cabinet_nom 
              FROM appointments
              JOIN cabinets ON appointments.cabinet_id = cabinets.id
              WHERE appointments.patient_id = :patient_id
              ORDER BY appointments.appointment_date DESC";
              
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':patient_id', $patient_id);
    $stmt->execute();

    $appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    // Si l'utilisateur n'est pas connecté, redirige vers la page de connexion
    header("Location: ../../View/Auth/login.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous</title>
    <link rel="stylesheet" href="../css/lister_rdv.css"> <!-- Assure-toi que ce fichier existe -->
</head>
<body>

<div class="container">
    <h2>Mes Rendez-vous</h2>
    
    <?php if (count($appointments) > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>Cabinet</th>
                    <th>Date du Rendez-vous</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($appointments as $appointment): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($appointment['cabinet_nom']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>
    
    <a href="../Patient/patient_dashboard.php" class="btn">Retour au Tableau de Bord</a>
</div>

</body>
</html>
