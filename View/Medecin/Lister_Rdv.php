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
$query = "SELECT appointments.id, appointments.appointment_date, appointments.cin, appointments.securite_sociale, 
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
    <link rel="stylesheet" href="../css/lister_rdv.css"> <!-- Assurez-vous que ce fichier existe -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
    </style>
</head>
<body>

<div class="container">
    <h2>Liste des Rendez-vous de mes patients</h2>

    <!-- Vérification si des rendez-vous existent -->
    <?php if (!empty($appointments)): ?>
        <table>
    <thead>
        <tr>
            <th>Patient</th>
            <th>Cabinet</th>
            <th>Date du Rendez-vous</th>
            <th>CIN</th>
            <th>Sécurité Sociale</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($appointments as $appointment): ?>
            <tr>
                <td><?php echo htmlspecialchars($appointment['patient_name']); ?></td>
                <td><?php echo htmlspecialchars($appointment['cabinet_name']); ?></td>
                <td><?php echo htmlspecialchars($appointment['appointment_date']); ?></td>
                <td><?php echo htmlspecialchars($appointment['cin']); ?></td>
                <td><?php echo htmlspecialchars($appointment['securite_sociale']); ?></td>
                <td class="action-buttons">
                    <a href="valider_rdv.php?id=<?php echo $appointment['id']; ?>" class="validate-btn">Valider</a>
                    <a href="cancel.php?id=<?php echo $appointment['id']; ?>" class="cancel-btn"><i class="fas fa-times-circle"></i></a>
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
    document.getElementById('download-pdf').addEventListener('click', function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Ajout du titre au PDF
        doc.setFontSize(18);
        doc.text("Liste des Rendez-vous de mes patients", 10, 10);

        // Créer un tableau avec les données des rendez-vous
        const tableData = [];

        <?php foreach ($appointments as $appointment): ?>
            tableData.push([
                "<?php echo htmlspecialchars($appointment['patient_name']); ?>",
                "<?php echo htmlspecialchars($appointment['cabinet_name']); ?>",
                "<?php echo htmlspecialchars($appointment['appointment_date']); ?>",
                "<?php echo htmlspecialchars($appointment['cin']); ?>",
                "<?php echo htmlspecialchars($appointment['securite_sociale']); ?>"
            ]);
        <?php endforeach; ?>

        // Générer le tableau
        doc.autoTable({
            head: [['Patient', 'Cabinet', 'Date du Rendez-vous', 'CIN', 'Sécurité Sociale']],
            body: tableData,
            startY: 20, // Positionner le tableau un peu plus bas
        });

        // Sauvegarder le fichier PDF
        doc.save("rendez-vous_patients.pdf");
    });
</script>


</body>
</html>
