<?php
// Démarrer la session en haut du fichier
session_start(); 

// Vérifie si l'utilisateur est bien connecté, sinon rediriger vers la page de connexion
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

require_once '../../config/database.php'; // Assure-toi que le chemin est correct

$conn = connectDB();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cabinet_id = $_POST['cabinet_id'];
    $appointment_date = $_POST['appointment_date'];
    $patient_id = $_SESSION['user_id'];  // Récupère l'ID du patient depuis la session

    // Requête pour récupérer le docteur associé au cabinet
    $query = "SELECT docteur_id FROM cabinets WHERE id = :cabinet_id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':cabinet_id', $cabinet_id);
    $stmt->execute();
    $docteur = $stmt->fetch(PDO::FETCH_ASSOC);

    // Vérifier si un docteur est associé au cabinet
    if ($docteur && isset($docteur['docteur_id'])) {
        $docteur_id = $docteur['docteur_id'];

        // Insérer le rendez-vous dans la base de données
        $insert_query = "INSERT INTO appointments (patient_id, cabinet_id, docteur_id, appointment_date, status)
                         VALUES (:patient_id, :cabinet_id, :docteur_id, :appointment_date, 'pending')";
        $stmt = $conn->prepare($insert_query);
        $stmt->bindParam(':patient_id', $patient_id);
        $stmt->bindParam(':cabinet_id', $cabinet_id);
        $stmt->bindParam(':docteur_id', $docteur_id);
        $stmt->bindParam(':appointment_date', $appointment_date);

        if ($stmt->execute()) {
            echo "<p class='success'>Rendez-vous réservé avec succès !</p>";
        } else {
            echo "<p class='error'>Erreur lors de la réservation du rendez-vous.</p>";
        }
    } else {
        echo "<p class='error'>Erreur : aucun docteur trouvé pour ce cabinet.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un Rendez-vous</title>
    <link rel="stylesheet" href="../css/reserver_rdv.css"> <!-- Assurez-vous que ce chemin est correct -->
</head>
<body>

<div class="container">
    <h2>Réserver un Rendez-vous</h2>
    <form action="reserver_rdv.php" method="POST">
        <label for="cabinet">Cabinet:</label>
        <select name="cabinet_id" id="cabinet">
            <!-- Générer dynamiquement la liste des cabinets -->
            <?php
            $stmt = $conn->query("SELECT id, nom FROM cabinets");
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "<option value='" . $row['id'] . "'>" . $row['nom'] . "</option>";
            }
            ?>
        </select>
        
        <label for="date">Date de rendez-vous:</label>
        <input type="datetime-local" name="appointment_date" required>
        
        <button type="submit">Réserver</button>
    </form>
</div>

</body>
</html>
