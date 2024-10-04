<?php
session_start();
require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

// Vérifie si l'utilisateur est bien connecté, sinon rediriger vers la page de connexion
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Récupère l'ID du docteur connecté
$docteur_id = $_SESSION['user_id'];

// Récupérer les rendez-vous associés au docteur
$query = "SELECT appointments.id, appointments.appointment_date, appointments.status, 
                 patients.username AS patient_name, cabinets.nom AS cabinet_name 
          FROM appointments
          JOIN users AS patients ON appointments.patient_id = patients.id
          JOIN cabinets ON appointments.cabinet_id = cabinets.id
          WHERE appointments.docteur_id = :docteur_id
          ORDER BY appointments.appointment_date DESC";

$stmt = $conn->prepare($query);
$stmt->bindParam(':docteur_id', $docteur_id);
$stmt->execute();

$appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Rendez-vous</title>
    <link rel="stylesheet" href="../css/lister_rdvpatient.css"> <!-- Assurez-vous que ce fichier existe -->
</head>
<body>

<div class="container">
    <h2>Liste des Rendez-vous</h2>

    <?php if (isset($_GET['success'])): ?>
        <p class="success"><?php echo htmlspecialchars($_GET['success']); ?></p>
    <?php endif; ?>

    <table>
        <thead>
            <tr>
                <th>Patient</th>
                <th>Cabinet</th>
                <th>Date du Rendez-vous</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($appointments)): ?>
                <?php foreach ($appointments as $appointment): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($appointment['patient_name']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['cabinet_name']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['status']); ?></td>
                  
                        <td class="action-buttons">
    <a href="approve.php?id=<?php echo $appointment['id']; ?>" class="approve-btn">Approuver</a>
    <a href="reject.php?id=<?php echo $appointment['id']; ?>" class="reject-btn">Rejeter</a>
</td>

                     
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="5">Aucun rendez-vous trouvé.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <a href="medecin_dashboard.php" class="btn-back">Retour au Tableau de Bord</a>
</div>

</body>
</html>
