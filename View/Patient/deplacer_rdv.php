<?php
require_once '../../config/database.php';

$conn = connectDB();

// Récupération de l'ID du rendez-vous à partir de l'URL
$rdv_id = isset($_GET['id']) ? $_GET['id'] : null;

// Récupération de l'ancienne date du rendez-vous
$query = "SELECT appointment_date FROM appointments WHERE id = :rdv_id";
$stmt = $conn->prepare($query);
$stmt->bindParam(':rdv_id', $rdv_id);
$stmt->execute();
$appointment = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Vérification de la nouvelle date soumise par le formulaire
    if (isset($_POST['appointment_date']) && !empty($_POST['appointment_date'])) {
        $new_date = $_POST['appointment_date'];

        // Préparer la requête SQL pour mettre à jour la date du rendez-vous
        $query = "UPDATE appointments SET appointment_date = :new_date WHERE id = :rdv_id";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':new_date', $new_date);
        $stmt->bindParam(':rdv_id', $rdv_id);

        // Exécuter la requête et vérifier si la mise à jour a été réussie
        if ($stmt->execute()) {
            // Rediriger avec un message de succès
            header("Location: lister_rdv.php?success=Le rendez-vous a été déplacé avec succès.");
            exit();
        } else {
            echo "Erreur lors de la mise à jour du rendez-vous.";
        }
    } else {
        echo "Données invalides. La date ne peut pas être vide.";
    }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Déplacer votre rendez-vous</title>
    <link rel="stylesheet" href="../css/deplacer.css"> <!-- Lien vers le fichier CSS -->
</head>
<body>
    <div class="container">
        <h1>Déplacer votre rendez-vous</h1>
        <form action="deplacer_rdv.php?id=<?php echo $rdv_id; ?>" method="POST">

            <label for="new_date">Nouvelle date:</label>
            <input type="datetime-local" name="appointment_date" value="<?php echo isset($appointment['appointment_date']) ? date('Y-m-d\TH:i', strtotime($appointment['appointment_date'])) : ''; ?>" required>

            <button type="submit">Déplacer</button>
        </form>
    </div>
</body>
</html>
