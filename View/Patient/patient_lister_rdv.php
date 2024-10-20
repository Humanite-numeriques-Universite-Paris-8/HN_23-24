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

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
       body {
    font-family: 'Poppins', sans-serif;
    background-image: url('../../images/images1.jpg'); /* Chemin vers l'image de fond */
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    display: flex;
    justify-content: center;
    align-items: flex-start; /* Adjusted from center to flex-start to move content higher */
    min-height: 100vh;
    margin: 0;
    padding-top: 20px; /* Added padding to create space at the top */
}

.container {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 1500px; /* Augmenté pour donner plus d'espace */
    margin-top: 0px; /* Adjust this if you need to move it even higher */
}

        h2 {
            text-align: center;
            color: #007bff;
            font-size: 28px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            table-layout: fixed; /* Assure une largeur fixe pour les colonnes */
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
            word-wrap: break-word; /* Permet à long texte de s'adapter */
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e9ecef;
        }

        /* Buttons styling */
        .actions {
            white-space: nowrap; /* Ensure buttons stay on one line */
        }

        .btn {
            display: inline-block; /* Ensure buttons stay inline */
            align-items: center;
            justify-content: center;
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 6px;
            margin-right: 8px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s;
            border: none;
        }

        .btn-deplacer {
            background-color: #28a745;
            color: white;
        }

        .btn-deplacer:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .btn-annuler {
            background-color: #dc3545;
            color: white;
        }

        .btn-annuler:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .btn-fermer {
            background-color: #ffc107;
            color: white;
        }

        .btn-fermer:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
        }

        .btn i {
            margin-right: 6px; /* Espace entre l'icône et le texte */
        }

        /* Align icons properly for a cleaner look */
        .btn i.fa {
            font-size: 16px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table, th, td {
                font-size: 12px;
            }

            .btn {
                padding: 6px 10px;
                font-size: 12px;
            }

            .actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; /* Empêche les boutons de sortir si l'espace est réduit */
            }

            .btn {
                display: inline-block;
                align-items: center;
                justify-content: center;
                padding: 8px 10px; /* Réduit la taille des boutons */
                font-size: 12px; /* Réduit la taille du texte */
                border-radius: 6px;
                margin-right: 5px;
                margin-bottom: 5px; /* Ajoute un espacement en bas pour éviter le chevauchement */
                text-align: center;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s;
                border: none;
            }

            .actions .btn-deplacer {
                background-color: #28a745;
                color: white;
            }

            .actions .btn-deplacer:hover {
                background-color: #218838;
            }

            .actions .btn-annuler {
                background-color: #dc3545;
                color: white;
            }

            .actions .btn-annuler:hover {
                background-color: #c82333;
            }

            .actions .btn-fermer {
                background-color: #ffc107;
                color: white;
            }

            .actions .btn-fermer:hover {
                background-color: #e0a800;
            }

            .actions .btn i {
                margin-right: 6px; /* Espace entre l'icône et le texte */
            }
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
                        <th style="width: 20%;">Cabinet</th>
                        <th style="width: 12%;">Nom du Docteur</th>
                        <th style="width: 10%;">Mon Nom</th>
                        <th style="width: 20%;">Ma Sécurité Sociale</th>
                        <th style="width: 15%;">Date du Rendez-vous</th>
                        <th style="width: 15%;">Mon Numéro de Téléphone</th>
                        <th style="width: 35%;">Actions</th>
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
                            <td class="actions">
                                <a href="deplacer_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn btn-deplacer"><i class="fas fa-sync-alt"></i> Déplacer</a>
                                <a href="annuler_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn btn-annuler"><i class="fas fa-times"></i> Annuler</a>
                                <button class="btn btn-fermer" onclick="closeAppointment(<?php echo $appointment['id']; ?>)"><i class="fas fa-window-close"></i> Fermer</button>
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
