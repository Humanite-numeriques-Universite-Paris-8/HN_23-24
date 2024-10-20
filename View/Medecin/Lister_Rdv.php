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
    
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Include jsPDF and jsPDF-AutoTable for PDF generation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.20/jspdf.plugin.autotable.min.js"></script>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('../../images/images1.jpg'); /* Adjust the path to your background image */
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
            background: rgba(0, 0, 0, 0.6); /* Dark overlay for readability */
            z-index: -1;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 90%;
            margin-bottom:350px;
            max-width: 1200px;
            z-index: 1;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
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
            background-color: #f1f1f1;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .action-buttons a, .action-buttons button {
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            display: inline-block;
        }

        .validate-btn {
            background-color: #17a2b8;
        }

        .validate-btn:hover {
            background-color: #138496;
        }

        .cancel-btn {
            background-color: #dc3545;
        }

        .cancel-btn:hover {
            background-color: #c82333;
        }

        .btn-fermer {
            background-color: #ffc107;
        }

        .btn-fermer:hover {
            background-color: #e0a800;
        }

        .btn-back, .btn-pdf {
            padding: 10px 20px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            font-size: 14px;
        }

        .btn-back {
            background-color: #28a745;
        }

        .btn-back:hover {
            background-color: #218838;
        }

        .btn-pdf {
            background-color: #007bff;
        }

        .btn-pdf:hover {
            background-color: #0069d9;
        }

        .success {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="overlay"></div> <!-- Overlay to darken the background image -->

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
                                <span style="color: green;"><i class="fas fa-check-circle"></i> Validé</span>
                            <?php else: ?>
                                <a href="valider_rdv.php?id=<?php echo $appointment['id']; ?>" class="validate-btn"><i class="fas fa-check-circle"></i> Valider</a>
                            <?php endif; ?>
                            <a href="cancel.php?id=<?php echo $appointment['id']; ?>" class="cancel-btn"><i class="fas fa-times-circle"></i> Annuler</a>
                            <button class="btn-fermer" onclick="closeAppointment(<?php echo $appointment['id']; ?>)"><i class="fas fa-window-close"></i> Fermer</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>

    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>

    <a href="medecin_dashboard.php" class="btn-back"><i class="fas fa-arrow-left"></i> Retour au Tableau de Bord</a>
    <a id="download-pdf" class="btn-pdf" style="cursor:pointer"><i class="fas fa-file-pdf"></i> Télécharger en PDF</a>
</div>

<script>
    // Function to close the appointment and hide it from the table
    function closeAppointment(appointmentId) {
        let closedAppointments = JSON.parse(localStorage.getItem('closedAppointmentsDoctor')) || [];
        closedAppointments.push(appointmentId);
        localStorage.setItem('closedAppointmentsDoctor', JSON.stringify(closedAppointments));
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

        const tableData = [];

        <?php foreach ($appointments as $appointment): ?>
        var isClosed = localStorage.getItem('closedAppointmentsDoctor') && JSON.parse(localStorage.getItem('closedAppointmentsDoctor')).includes(<?php echo $appointment['id']; ?>);
        if (!isClosed) {
            tableData.push([
                "<?php echo htmlspecialchars($appointment['patient_name']); ?>",
                "<?php echo htmlspecialchars($appointment['cabinet_name']); ?>",
                "<?php echo htmlspecialchars($appointment['appointment_date']); ?>",
                "<?php echo htmlspecialchars($appointment['securite_sociale']); ?>",
                "<?php echo htmlspecialchars($appointment['patient_phone']); ?>",
                "<?php echo htmlspecialchars($appointment['patient_email']); ?>"
            ]);
        }
        <?php endforeach; ?>

        // Generate the table
        doc.autoTable({
            head: [['Patient', 'Cabinet', 'Date du Rendez-vous', 'Sécurité Sociale', 'Téléphone', 'Email']],
            body: tableData,
            startY: 20, 
        });

        // Save the PDF file
        doc.save("rendez-vous_patients.pdf");
    });
</script>

</body>
</html>
