<?php
// Démarrer la session en haut du fichier
session_start(); 

// Vérifie si l'utilisateur est bien connecté, sinon rediriger vers la page de connexion
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

$conn = connectDB();

$cabinet_id = "";
$appointment_date = "";
$cin = "";
$securite_sociale = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cabinet_id = $_POST['cabinet_id'];
    $appointment_date = $_POST['appointment_date'];
    $cin = $_POST['cin'];
    $securite_sociale = $_POST['securite_sociale'];
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

        // Vérifier si un rendez-vous existe déjà pour cette date et cette heure
        $check_query = "SELECT COUNT(*) FROM appointments WHERE cabinet_id = :cabinet_id AND appointment_date = :appointment_date";
        $check_stmt = $conn->prepare($check_query);
        $check_stmt->bindParam(':cabinet_id', $cabinet_id);
        $check_stmt->bindParam(':appointment_date', $appointment_date);
        $check_stmt->execute();
        $appointment_exists = $check_stmt->fetchColumn();

        if ($appointment_exists > 0) {
            // Afficher un message d'erreur si un rendez-vous est déjà pris pour cette date et cette heure
            $error_message = "Erreur : Un rendez-vous est déjà pris pour cette date et cette heure.";
        } else {
            // Insérer le rendez-vous dans la base de données
            $insert_query = "INSERT INTO appointments (patient_id, cabinet_id, docteur_id, appointment_date, cin, securite_sociale, status)
                             VALUES (:patient_id, :cabinet_id, :docteur_id, :appointment_date, :cin, :securite_sociale, 'pending')";
            $stmt = $conn->prepare($insert_query);
            $stmt->bindParam(':patient_id', $patient_id);
            $stmt->bindParam(':cabinet_id', $cabinet_id);
            $stmt->bindParam(':docteur_id', $docteur_id);
            $stmt->bindParam(':appointment_date', $appointment_date);
            $stmt->bindParam(':cin', $cin);
            $stmt->bindParam(':securite_sociale', $securite_sociale);

            if ($stmt->execute()) {
                // Rediriger vers la page Lister_Rdv.php après succès avec le message de succès
                header("Location: Lister_Rdv.php?success=1");
                exit();
            } else {
                echo "<p class='error'>Erreur lors de la réservation du rendez-vous.</p>";
            }
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
    <link rel="stylesheet" href="../Patient/css/reserver_rdv.css"> <!-- Assurez-vous que ce chemin est correct -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 50px;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        select, input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #218838;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
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
        <select name="cabinet_id" id="cabinet">
            <!-- Générer dynamiquement la liste des cabinets -->
            <?php
            $stmt = $conn->query("SELECT id, nom FROM cabinets");
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $selected = ($row['id'] == $cabinet_id) ? 'selected' : '';
                echo "<option value='" . $row['id'] . "' $selected>" . $row['nom'] . "</option>";
            }
            ?>
        </select>

        <label for="appointment_date">Date et Heure du Rendez-vous:</label>
        <input type="datetime-local" id="appointment_date" name="appointment_date" value="<?php echo htmlspecialchars($appointment_date); ?>" required>

        <label for="cin">CIN:</label>
        <input type="text" name="cin" value="<?php echo htmlspecialchars($cin); ?>" required>

        <label for="securite_sociale">Sécurité Sociale:</label>
        <input type="text" name="securite_sociale" value="<?php echo htmlspecialchars($securite_sociale); ?>" required>

        <button type="submit" class="btn">Réserver</button>
    </form>
</div>

</body>
</html>
