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
    <link rel="stylesheet" href="../css/lister_rdv.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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

        // Ajout du titre au PDF
        doc.setFontSize(18);
        doc.text("Récapitulatif de Rendez-vous", 10, 10);

        // Ajout des informations du patient
        const patientName = "<?php echo htmlspecialchars($patient['username']); ?>";
        const appointmentDate = "<?php echo htmlspecialchars($appointments[0]['appointment_date']); ?>";
     

        doc.setFontSize(12);
    

        // Position verticale réduite pour organiser les informations
        let yPos = 30;

        // Ajout des informations des rendez-vous
        <?php foreach ($appointments as $index => $appointment): ?>
            doc.text(`Cabinet: <?php echo htmlspecialchars($appointment['cabinet_nom']); ?>`, 10, yPos);
            doc.text(`Docteur: <?php echo htmlspecialchars($appointment['docteur_nom']); ?>`, 10, yPos + 5);
            doc.text(`Date du Rendez-vous: <?php echo htmlspecialchars($appointment['appointment_date']); ?>`, 10, yPos + 10);
            yPos += 20; // Espacement vertical
        <?php endforeach; ?>

        const fileName = `rendez-vous_de_${patientName}.pdf`;
        // Télécharger le fichier PDF
        doc.save(fileName);
    });
</script>

</body>
</html>
