<?php
session_start();

// Vérifie si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Connexion à la base de données
require_once '../../config/database.php';
$conn = connectDB();

// Requête pour récupérer les informations du patient et des rendez-vous
$query = "
SELECT appointments.id, cabinets.nom AS cabinet_nom, docteurs.username AS docteur_nom, docteurs.email AS docteur_email,
appointments.appointment_date, appointments.securite_sociale, patients.username AS patient_nom,
patients.phone AS patient_phone
FROM appointments
JOIN cabinets ON appointments.cabinet_id = cabinets.id
JOIN users AS docteurs ON cabinets.docteur_id = docteurs.id
JOIN users AS patients ON appointments.patient_id = patients.id
WHERE appointments.patient_id = :patient_id

";

$stmt = $conn->prepare($query);
$stmt->bindParam(':patient_id', $_SESSION['user_id']);
$stmt->execute();
$appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            width: 90%;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
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

        a.btn {
            display: inline-block;
            padding: 10px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            margin-top: 20px;
        }

        a.btn:hover {
            background-color: #218838;
        }

        .btn-fermer {
            background-color: #ffc107;
            color: white;
        }

        .btn-fermer:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Mes Rendez-vous</h2>

    <?php if (!empty($appointments)): ?>
        <table id="appointmentsTable">
            <thead>
            <tr>
                <th>Cabinet</th>
                <th>Nom du Docteur</th>
                <th>Mon Nom</th>
                <th>Ma Sécurité Sociale</th>
                <th>Date du Rendez-vous</th>
                <th>Mon Numéro de Téléphone</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($appointments as $appointment): ?>
                <tr id="appointment-<?php echo $appointment['id']; ?>">
                    <td><?php echo htmlspecialchars($appointment['cabinet_nom']); ?></td>
                    <td><?php echo htmlspecialchars($appointment['docteur_nom']); ?></td>
                    <td><?php echo htmlspecialchars($appointment['patient_nom']); ?></td>
                    <td><?php echo htmlspecialchars($appointment['securite_sociale']); ?></td>
                    <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                    <td><?php echo htmlspecialchars($appointment['patient_phone']); ?></td>
                    <td>
                        <a href="deplacer_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn">Déplacer</a>
                        <a href="annuler_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn">Annuler</a>
                        <button class="btn btn-fermer" onclick="closeAppointment(<?php echo $appointment['id']; ?>)">Fermer</button>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>
</div>

<script>
    // Function to close the appointment and hide it from the table
    function closeAppointment(appointmentId) {
        // Store the closed appointment ID in localStorage
        let closedAppointments = JSON.parse(localStorage.getItem('closedAppointments')) || [];
        closedAppointments.push(appointmentId);
        localStorage.setItem('closedAppointments', JSON.stringify(closedAppointments));

        // Hide the appointment row
        document.getElementById('appointment-' + appointmentId).style.display = 'none';
    }

    // On page load, check if any appointments were closed and hide them
    document.addEventListener('DOMContentLoaded', function () {
        let closedAppointments = JSON.parse(localStorage.getItem('closedAppointments')) || [];
        closedAppointments.forEach(function (appointmentId) {
            let appointmentRow = document.getElementById('appointment-' + appointmentId);
            if (appointmentRow) {
                appointmentRow.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>
