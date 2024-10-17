<?php
// Démarrer la session
session_start(); 

// Vérifie si l'utilisateur est bien connecté, sinon rediriger vers la page de connexion
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

// Initialisation des variables
$cabinet_id = $appointment_date = $cin = $securite_sociale = "";

// Message d'erreur initialisé vide
$error_message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cabinet_id = $_POST['cabinet_id'];
    $appointment_date = $_POST['appointment_date'];
    $cin = $_POST['cin'];
    $securite_sociale = $_POST['securite_sociale'];
    $patient_id = $_SESSION['user_id'];  // Récupérer l'ID du patient depuis la session

    // Validation du CIN
    if (!preg_match('/^CD\d{6}$/', $cin)) {
        $error_message = "Le CIN doit commencer par 'CD' suivi de 6 chiffres.";
    } else {
        // Vérifier si le CIN existe déjà dans les rendez-vous
        $check_cin_query = "SELECT COUNT(*) FROM appointments WHERE cin = :cin";
        $check_cin_stmt = $conn->prepare($check_cin_query);
        $check_cin_stmt->bindParam(':cin', $cin);
        $check_cin_stmt->execute();
        $cin_exists = $check_cin_stmt->fetchColumn();

        if ($cin_exists > 0) {
            $error_message = "Erreur : Ce CIN n'est pas le vôtre.";
        } else {
            // Requête pour récupérer le docteur associé au cabinet
            $query = "SELECT docteur_id FROM cabinets WHERE id = :cabinet_id";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':cabinet_id', $cabinet_id);
            $stmt->execute();
            $docteur = $stmt->fetch(PDO::FETCH_ASSOC);

            // Vérifier si un docteur est associé au cabinet
            if ($docteur && isset($docteur['docteur_id'])) {
                $docteur_id = $docteur['docteur_id'];

                // Vérifier si un rendez-vous existe déjà pour cette date et cette heure
                $check_query = "SELECT COUNT(*) FROM appointments WHERE cabinet_id = :cabinet_id AND appointment_date = :appointment_date";
                $check_stmt = $conn->prepare($check_query);
                $check_stmt->bindParam(':cabinet_id', $cabinet_id);
                $check_stmt->bindParam(':appointment_date', $appointment_date);
                $check_stmt->execute();
                $appointment_exists = $check_stmt->fetchColumn();

                if ($appointment_exists > 0) {
                    $error_message = "Erreur : Un rendez-vous est déjà pris pour cette date et cette heure.";
                } else {
                    // Insérer le rendez-vous dans la base de données
                    $insert_query = "INSERT INTO appointments (patient_id, cabinet_id, docteur_id, appointment_date, cin, securite_sociale)
                                     VALUES (:patient_id, :cabinet_id, :docteur_id, :appointment_date, :cin, :securite_sociale)";
                    $stmt = $conn->prepare($insert_query);
                    $stmt->bindParam(':patient_id', $patient_id);
                    $stmt->bindParam(':cabinet_id', $cabinet_id);
                    $stmt->bindParam(':docteur_id', $docteur_id);
                    $stmt->bindParam(':appointment_date', $appointment_date);
                    $stmt->bindParam(':cin', $cin);
                    $stmt->bindParam(':securite_sociale', $securite_sociale);

                    if ($stmt->execute()) {
                        header("Location: patient_lister_rdv.php?success=1");
                        exit();
                    } else {
                        $error_message = "Erreur lors de la réservation du rendez-vous.";
                    }
                }
            } else {
                $error_message = "Erreur : aucun docteur trouvé pour ce cabinet.";
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un Rendez-vous</title>
    <link rel="stylesheet" href="../Patient/css/reserver_rdv.css"> <!-- Assurez-vous que ce chemin est correct -->
</head>
<body>

<div class="container">
    <h2>Réserver un Rendez-vous</h2>

    <?php if (!empty($error_message)): ?>
        <div class="error">
            <?php echo $error_message; ?>
        </div>
    <?php endif; ?>

    <form action="reserver_rdv.php" method="POST">
        <label for="cabinet">Cabinet:</label>
        <select name="cabinet_id" id="cabinet" required>
            <option value="">Sélectionner un cabinet</option>
            <?php
            $stmt = $conn->query("SELECT id, nom FROM cabinets");
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $selected = ($row['id'] == $cabinet_id) ? 'selected' : '';
                echo "<option value='" . $row['id'] . "' $selected>" . htmlspecialchars($row['nom']) . "</option>";
            }
            ?>
        </select>

        <label for="appointment_date">Date et Heure du Rendez-vous:</label>
        <input type="datetime-local" id="appointment_date" name="appointment_date" value="<?php echo htmlspecialchars($appointment_date); ?>" required>

        <label for="cin">CIN:</label>
        <input type="text" id="cin" name="cin" pattern="^CD\d{6}$" required value="<?php echo htmlspecialchars($cin); ?>">

        <label for="securite_sociale">Sécurité Sociale:</label>
        <input type="text" id="securite_sociale" name="securite_sociale" value="<?php echo htmlspecialchars($securite_sociale); ?>" required>

        <button type="submit" class="btn">Réserver</button>
    </form>
</div>

</body>
</html>
