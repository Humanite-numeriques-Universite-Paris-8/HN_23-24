<?php
session_start();
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

// Vérifiez si l'utilisateur est bien connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Récupère l'ID du docteur connecté
$docteur_id = $_SESSION['user_id'];

// Récupérer les rendez-vous associés au docteur
$query = "SELECT appointments.id, appointments.appointment_date, appointments.status, 
                 patients.username AS patient_name, cabinets.nom AS cabinet_name, appointments.is_validated
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
    

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


    <style>
        /* Ajout d'un style pour les boutons et la validation */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .approve-btn, .reject-btn, .validate-btn {
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 14px;
        }

        .approve-btn { background-color: green; }
        .reject-btn { background-color: red; }
        .validate-btn { background-color: teal; }

        .success {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .container {
            margin: 20px;
        }

        .btn-back {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }

        .checkmark {
            color: green;
            font-size: 24px;
        }

        .hide {
            display: none;
        }

        .show-checkmark {
            display: inline-block;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Liste des Rendez-vous</h2>

    <?php // if (isset($_GET['success'])): ?>
    <?php // <p class="success"><?php // echo htmlspecialchars($_GET['success']); ?></p> 
<?php // endif; ?>


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
    <?php if ($appointment['is_validated'] == 1): ?>
        <!-- Afficher le checkmark uniquement si le rendez-vous est validé -->
        <span id="valid-icon-<?php echo $appointment['id']; ?>" class="checkmark show-checkmark">✔</span>
    <?php endif; ?>
    
    <?php if ($appointment['is_validated'] == 0 && $appointment['status'] == 'pending'): ?>
        <!-- Si le rendez-vous n'est pas encore validé, afficher les boutons Approuver, Rejeter et Valider -->
        <a href="approve.php?id=<?php echo $appointment['id']; ?>" class="approve-btn">Approuver</a>
        <a href="reject.php?id=<?php echo $appointment['id']; ?>" class="reject-btn">Rejeter</a>
        <a href="valider_rdv.php?id=<?php echo $appointment['id']; ?>" class="validate-btn">Valider</a>
    <?php endif; ?>

    <!-- Ajouter un bouton d'annulation à tous les rendez-vous -->
    <a href="cancel.php?id=<?php echo $appointment['id']; ?>" class="cancel-btn"><i class="fas fa-times-circle"></i></a>

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
