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
appointments.appointment_date,  appointments.securite_sociale, 
patients.username AS patient_nom, patients.phone AS patient_phone, patients.email AS patient_email
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
    <link rel="stylesheet" href="../Patient/css/patient_lister_rdv.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.20/jspdf.plugin.autotable.min.js"></script>
</head>
<body>
<div class="container">
    <h2>Mes Rendez-vous</h2>
    <?php if (!empty($appointments)): ?>
    <table>
        <thead>
            <tr>
                <th>Cabinet</th>
                <th>Nom du Docteur</th>
                <th>Mon Nom</th>
                <th>Ma Sécurité Sociale</th>
                <th>La date du Rendez-vous</th>
                <th>Mon Numéro de Téléphone</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($appointments as $appointment): ?>
            <tr>
                <td><?php echo htmlspecialchars($appointment['cabinet_nom']); ?></td>
                <td><?php echo htmlspecialchars($appointment['docteur_nom']); ?></td>
<td><?php echo htmlspecialchars($appointment['patient_nom']); ?></td>

                <td><?php echo htmlspecialchars($appointment['securite_sociale']); ?></td>
                <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                <td><?php echo htmlspecialchars($appointment['patient_phone']); ?></td>

                <td>
                    <a href="deplacer_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn-deplacer">Déplacer</a> |
                    <a href="annuler_rdv.php?id=<?php echo $appointment['id']; ?>" class="btn-annuler">Annuler</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <?php else: ?>
        <p>Aucun rendez-vous trouvé.</p>
    <?php endif; ?>
    <br><br>
    <a id="download-pdf" class="btn" style="cursor:pointer">Télécharger en PDF</a>
    <a href="../Patient/patient_dashboard.php" class="btn">Retour au Tableau de Bord</a>
</div>

<script>
document.getElementById('download-pdf').addEventListener('click', function () {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.setFontSize(18);
    doc.text("Récapitulatif de Rendez-vous", 10, 10);

    const patientName = "<?php echo htmlspecialchars($_SESSION['username'] ?? 'Inconnu'); ?>";
    doc.setFontSize(14);
    doc.text(`Nom du Patient: ${patientName}`, 10, 20);

    const tableData = [];
    <?php foreach ($appointments as $appointment): ?>
        tableData.push([
            "<?php echo htmlspecialchars($appointment['cabinet_nom']); ?>",
            "<?php echo htmlspecialchars($appointment['docteur_nom']); ?>",
            "<?php echo htmlspecialchars($appointment['patient_nom']); ?>",
           
            "<?php echo htmlspecialchars($appointment['securite_sociale']); ?>",
            "<?php echo htmlspecialchars($appointment['appointment_date']); ?>",
            "<?php echo htmlspecialchars($appointment['patient_phone']); ?>"
        ]);
    <?php endforeach; ?>

    doc.autoTable({
        head: [['Cabinet', 'Docteur', 'Patient', 'Sécurité Sociale', 'Date du Rendez-vous', 'Numéro de Téléphone']],
        body: tableData,
        startY: 30,
        theme: 'striped',
        headStyles: {
            fillColor: [22, 160, 133],
            textColor: [255, 255, 255],
            fontSize: 8
        },
        styles: {
            fontSize: 10,
            cellPadding: 5
        }
    });

    doc.save(`Rendez-vous_de_${patientName}.pdf`);
});
</script>

</body>
</html>
