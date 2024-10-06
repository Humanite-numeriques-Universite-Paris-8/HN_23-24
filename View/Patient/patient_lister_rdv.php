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
SELECT appointments.id, cabinets.nom AS cabinet_nom, docteurs.username AS docteur_nom, 
appointments.appointment_date, appointments.cin, appointments.securite_sociale, 
patients.username AS patient_nom
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

// Vérifie si des rendez-vous existent avant de continuer
if (!empty($appointments)) {
    // On prend le premier rendez-vous pour récupérer les infos patient (vu qu'il semble y avoir un patient unique)
    $appointment = $appointments[0];
}

// Récupération des informations du patient
$patient_info_query = "SELECT username FROM users WHERE id = :patient_id";
$patient_stmt = $conn->prepare($patient_info_query);
$patient_stmt->bindParam(':patient_id', $_SESSION['user_id']);
$patient_stmt->execute();
$patient = $patient_stmt->fetch(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.20/jspdf.plugin.autotable.min.js"></script>

    <link rel="stylesheet" href="../Patient/css/patient_lister_rdv.css">


</head>
<body>
<div class="container">
    <h2>Mes Rendez-vous</h2>

    <!-- Vérifie s'il y a des rendez-vous pour afficher les informations du patient -->
    <?php if (!empty($appointments)): ?>
        <!-- Affichage des rendez-vous -->
        <table>
            <thead>
                <tr>
                    <th>Cabinet</th>
                    <th>Nom du Docteur</th>
                    <th>Nom du Patient</th>
                    <th>CIN</th>
                    <th>Sécurité Sociale</th>
                    <th>Date du Rendez-vous</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($appointments as $appointment): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($appointment['cabinet_nom']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['docteur_nom']); ?></td>
                        <td><?php echo htmlspecialchars($appointment['patient_nom']); ?></td>
                        <td><?php echo !empty($appointment['cin']) ? htmlspecialchars($appointment['cin']) : 'Non renseigné'; ?></td>
                        <td><?php echo !empty($appointment['securite_sociale']) ? htmlspecialchars($appointment['securite_sociale']) : 'Non renseigné'; ?></td>
                        <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                        <td class="s" style="margin:0;display:flex;"> 
                            <a href="deplacer_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn-deplacer">Déplacer</a> |    
                            <a style="margin-left:10px" href="annuler_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn-annuler">Annuler</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>

    <br><br>
    
    <!-- Bouton pour télécharger en PDF -->
    <a id="download-pdf" class="btn" style="cursor:pointer">Télécharger en PDF</a>

    <!-- Bouton pour retourner au tableau de bord -->
    <a href="../Patient/patient_dashboard.php" class="btn">Retour au Tableau de Bord</a>
</div>

<script>
   document.getElementById('download-pdf').addEventListener('click', function () {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    // Add title to the PDF
    doc.setFontSize(18);
    doc.text("Récapitulatif de Rendez-vous", 10, 10);

    // Add patient's name
    const patientName = "<?php echo htmlspecialchars($patient['username']); ?>";
    doc.setFontSize(14);
    doc.text(`Nom du Patient: ${patientName}`, 10, 20); // Display patient's name below the title

    // Prepare the data for the table
    const tableData = [];

    <?php foreach ($appointments as $appointment): ?>
        tableData.push([
            "<?php echo htmlspecialchars($appointment['cabinet_nom']); ?>",
            "<?php echo htmlspecialchars($appointment['docteur_nom']); ?>",
            "<?php echo htmlspecialchars($appointment['patient_nom']); ?>", // Include patient's name in the table data
            "<?php echo htmlspecialchars($appointment['cin']); ?>",
            "<?php echo htmlspecialchars($appointment['securite_sociale']); ?>",
            "<?php echo htmlspecialchars($appointment['appointment_date']); ?>"
        ]);
    <?php endforeach; ?>

    // Add the table to the PDF
    doc.autoTable({
        head: [['Cabinet', 'Docteur', 'Patient', 'CIN', 'Sécurité Sociale', 'Date du Rendez-vous']],
        body: tableData,
        startY: 30, // Adjust position to make space for patient's name
        theme: 'striped', // Table theme
        headStyles: {
            fillColor: [22, 160, 133], // Header background color (teal)
            textColor: [255, 255, 255], // Header text color (white)
            fontSize: 12 // Header font size
        },
        styles: {
            fontSize: 10, // Font size for the table body
            cellPadding: 5 // Cell padding
        }
    });

    // Save the PDF
    const fileName = `rendez-vous_de_${patientName}.pdf`;
    doc.save(fileName);
});


</script>


</body>
</html>
