<?php
session_start();
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

// Verify if the user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

// Get the logged-in doctor's ID
$docteur_id = $_SESSION['user_id'];

// Fetch appointments associated with the doctor, including patient information
$query = "SELECT appointments.id, appointments.appointment_date, appointments.securite_sociale, 
                 patients.phone AS patient_phone, patients.username AS patient_name, 
                 patients.email AS patient_email, cabinets.nom AS cabinet_name, appointments.is_validated
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
    <!-- Ensure that the CSS file exists or adjust the path accordingly -->
    <link rel="stylesheet" href="../Medecin/css/lister_rdv.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Include jsPDF and jsPDF-AutoTable for PDF generation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.20/jspdf.plugin.autotable.min.js"></script>

    <style>
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
        .cancel-btn { background-color: red; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; font-size: 14px; }
        .success {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .container {
            margin: 20px;
        }
        .btn-back, .btn-pdf {
            padding: 10px 20px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .btn-back {
            background-color: #28a745;
        }
        .btn-pdf {
            background-color: #007bff;
        }
        .fas.fa-check-circle {
            color: green;
            font-size: 18px;
            margin-right: 5px;
        }
        .btn-fermer {
            background-color: #ffc107;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }
        .btn-fermer:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Liste des Rendez-vous de mes patients</h2>

    <!-- Check if appointments exist -->
    <?php if (!empty($appointments)): ?>
        <table id="appointmentsTable">
            <thead>
                <tr>
                    <th>Patient</th>
                    <th>Cabinet</th>
                    <th>Date du Rendez-vous</th>
                    <th>Sécurité Sociale</th>
                    <th>Téléphone</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($appointments as $appointment): ?>
                    <tr id="appointment-<?php echo $appointment['id']; ?>">
                        <td><?php echo htmlspecialchars($appointment['patient_name']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['cabinet_name']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['securite_sociale']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['patient_phone']); ?></td> <!-- Patient's phone number -->
                        <td><?php echo htmlspecialchars($appointment['patient_email']); ?></td> <!-- Patient's email -->
                        <td class="action-buttons">
                            <?php if ($appointment['is_validated']): ?>
                                <!-- If the appointment is validated, display a check icon -->
                                <span style="color: green;"><i class="fas fa-check-circle"></i> Validé</span>
                            <?php else: ?>
                                <!-- Otherwise, display a validation button -->
                                <a href="valider_rdv.php?id=<?php echo $appointment['id']; ?>" class="validate-btn">Valider</a>
                            <?php endif; ?>
                            <a href="cancel.php?id=<?php echo $appointment['id']; ?>" class="cancel-btn"><i class="fas fa-times-circle"></i>Annuler</a>
                            <!-- Add the Fermer button -->
                            <button class="btn-fermer" onclick="closeAppointment(<?php echo $appointment['id']; ?>)">Fermer</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>

    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>

    <a href="medecin_dashboard.php" class="btn-back">Retour au Tableau de Bord</a>
    <a id="download-pdf" class="btn-pdf" style="cursor:pointer">Télécharger en PDF</a>
</div>

<script>
    // Function to close the appointment and hide it from the table
    function closeAppointment(appointmentId) {
        // Store the closed appointment ID in localStorage
        let closedAppointments = JSON.parse(localStorage.getItem('closedAppointmentsDoctor')) || [];
        closedAppointments.push(appointmentId);
        localStorage.setItem('closedAppointmentsDoctor', JSON.stringify(closedAppointments));

        // Hide the appointment row
        document.getElementById('appointment-' + appointmentId).style.display = 'none';
    }

    // On page load, check if any appointments were closed and hide them
    document.addEventListener('DOMContentLoaded', function () {
        let closedAppointments = JSON.parse(localStorage.getItem('closedAppointmentsDoctor')) || [];
        closedAppointments.forEach(function (appointmentId) {
            let appointmentRow = document.getElementById('appointment-' + appointmentId);
            if (appointmentRow) {
                appointmentRow.style.display = 'none';
            }
        });
    });

    // PDF generation script
    document.getElementById('download-pdf').addEventListener('click', function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Add title to the PDF
        doc.setFontSize(18);
        doc.text("Liste des Rendez-vous de mes patients", 10, 10);

        // Create a table with appointment data
        const tableData = [];

        <?php foreach ($appointments as $appointment): ?>
            // Check if the appointment is not closed before adding it to the PDF
            var isClosed = localStorage.getItem('closedAppointmentsDoctor') && JSON.parse(localStorage.getItem('closedAppointmentsDoctor')).includes(<?php echo $appointment['id']; ?>);
            if (!isClosed) {
                tableData.push([
                    "<?php echo htmlspecialchars($appointment['patient_name']); ?>",
                    "<?php echo htmlspecialchars($appointment['cabinet_name']); ?>",
                    "<?php echo htmlspecialchars($appointment['appointment_date']); ?>",
                    "<?php echo htmlspecialchars($appointment['securite_sociale']); ?>",
                    "<?php echo htmlspecialchars($appointment['patient_phone']); ?>",  // Patient's phone number
                    "<?php echo htmlspecialchars($appointment['patient_email']); ?>"   // Patient's email
                ]);
            }
        <?php endforeach; ?>

        // Generate the table
        doc.autoTable({
            head: [['Patient', 'Cabinet', 'Date du Rendez-vous', 'Sécurité Sociale', 'Téléphone', 'Email']],
            body: tableData,
            startY: 20, // Position the table a bit lower
        });

        // Save the PDF file
        doc.save("rendez-vous_patients.pdf");
    });
</script>

</body>
</html>
