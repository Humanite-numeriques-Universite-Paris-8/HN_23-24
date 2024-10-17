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
$cabinet_id = $appointment_date = $securite_sociale = $phone = "";
$error_message = "";

// Récupérer les informations actuelles de l'utilisateur connecté (pour afficher le téléphone)
$user_id = $_SESSION['user_id'];
$query_user = "SELECT phone FROM users WHERE id = :user_id";
$stmt_user = $conn->prepare($query_user);
$stmt_user->bindParam(':user_id', $user_id);
$stmt_user->execute();
$user = $stmt_user->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cabinet_id = $_POST['cabinet_id'];
    $appointment_date = $_POST['appointment_date'];
    $securite_sociale = $_POST['securite_sociale'];
    $phone = $_POST['phone'];
    $patient_id = $_SESSION['user_id'];  // Récupérer l'ID du patient depuis la session

    try {
        $conn->beginTransaction();

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
            // Mettre à jour le téléphone dans la table `users`
            $update_phone_query = "UPDATE users SET phone = :phone WHERE id = :user_id";
            $update_phone_stmt = $conn->prepare($update_phone_query);
            $update_phone_stmt->bindParam(':phone', $phone);
            $update_phone_stmt->bindParam(':user_id', $user_id);
            $update_phone_stmt->execute();

            // Requête pour récupérer le docteur associé au cabinet
            $query = "SELECT docteur_id FROM cabinets WHERE id = :cabinet_id";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':cabinet_id', $cabinet_id);
            $stmt->execute();
            $docteur = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($docteur && isset($docteur['docteur_id'])) {
                $docteur_id = $docteur['docteur_id'];

                // Insérer le rendez-vous dans la base de données
                $insert_query = "INSERT INTO appointments (patient_id, cabinet_id, docteur_id, appointment_date, securite_sociale, phone)
                                 VALUES (:patient_id, :cabinet_id, :docteur_id, :appointment_date, :securite_sociale, :phone)";
                $stmt = $conn->prepare($insert_query);
                $stmt->bindParam(':patient_id', $patient_id);
                $stmt->bindParam(':cabinet_id', $cabinet_id);
                $stmt->bindParam(':docteur_id', $docteur_id);
                $stmt->bindParam(':appointment_date', $appointment_date);
                $stmt->bindParam(':securite_sociale', $securite_sociale);
                $stmt->bindParam(':phone', $phone);

                if ($stmt->execute()) {
                    $conn->commit();
                    header("Location: patient_lister_rdv.php?success=1");
                    exit();
                } else {
                    $conn->rollBack();
                    $error_message = "Erreur lors de la réservation du rendez-vous.";
                }
            } else {
                $error_message = "Erreur : aucun docteur trouvé pour ce cabinet.";
            }
        }
    } catch (Exception $e) {
        $conn->rollBack();
        $error_message = "Erreur lors de la réservation : " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un Rendez-vous</title>
    <style>
        /* General Body and Container Settings */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            color: #28a745;
            margin-bottom: 20px;
            font-size: 1.8rem;
        }

        /* Form Label Styling */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        /* Input fields and select boxes */
        input[type="text"],
        input[type="tel"],
        input[type="datetime-local"],
        select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
        }

        /* Button Styling */
        button.btn {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 1rem;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button.btn:hover {
            background-color: #218838;
        }

        /* Styling for error or success messages */
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #c3e6cb;
            border-radius: 8px;
        }

        /* Responsive styling for mobile view */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }

            h2 {
                font-size: 1.5rem;
            }

            button.btn {
                font-size: 0.9rem;
                padding: 12px;
            }

            input[type="text"],
            input[type="tel"],
            input[type="datetime-local"],
            select {
                font-size: 0.9rem;
                padding: 10px;
            }
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

        <label for="securite_sociale">Sécurité Sociale:</label>
        <input type="text" id="securite_sociale" name="securite_sociale" value="<?php echo htmlspecialchars($securite_sociale); ?>" required>

        <label for="phone">Numéro de Téléphone:</label>
        <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required value="<?php echo htmlspecialchars($user['phone']); ?>">

        <button type="submit" class="btn">Réserver</button>
    </form>
</div>

</body>
</html>
