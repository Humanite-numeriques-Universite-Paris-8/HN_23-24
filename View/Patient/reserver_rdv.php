<?php
session_start();
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Vérifie si l'utilisateur est bien connecté, sinon rediriger vers la page de connexion
if (!isset($_SESSION['user_id'])) {
    header("Location: ../../View/Auth/login.php");
    exit();
}

require_once '../../config/database.php'; // Connexion à la base de données
$conn = connectDB();

// Initialisation des variables
$cabinet_id = $appointment_date = $phone = $securite_sociale = "";
$error_message = "";

// Récupérer les informations actuelles de l'utilisateur connecté (pour afficher le téléphone)
$user_id = $_SESSION['user_id'];
$query_user = "SELECT phone FROM users WHERE id = :user_id";
$stmt_user = $conn->prepare($query_user);
$stmt_user->bindParam(':user_id', $user_id);
$stmt_user->execute();
$user = $stmt_user->fetch(PDO::FETCH_ASSOC);

// Vérifier si le patient a déjà un numéro de sécurité sociale dans les précédents rendez-vous
$query_ss = "SELECT securite_sociale FROM appointments WHERE patient_id = :user_id LIMIT 1";
$stmt_ss = $conn->prepare($query_ss);
$stmt_ss->bindParam(':user_id', $user_id);
$stmt_ss->execute();
$existing_ss = $stmt_ss->fetch(PDO::FETCH_ASSOC);

// Si la méthode de requête est POST, traiter la soumission du formulaire
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cabinet_id = $_POST['cabinet_id'];
    $appointment_date = $_POST['appointment_date'];
    $phone = $_POST['phone'];
    $input_securite_sociale = $_POST['securite_sociale']; 
    $patient_id = $_SESSION['user_id'];

    // Vérifier si le numéro de téléphone est utilisé par un autre patient
    $check_phone_query = "SELECT id FROM users WHERE phone = :phone AND id != :user_id";
    $check_phone_stmt = $conn->prepare($check_phone_query);
    $check_phone_stmt->bindParam(':phone', $phone);
    $check_phone_stmt->bindParam(':user_id', $user_id);
    $check_phone_stmt->execute();
    $phone_exists = $check_phone_stmt->fetch(PDO::FETCH_ASSOC);

    if ($phone_exists) {
        $error_message = "Erreur : Ce numéro de téléphone est déjà utilisé par un autre patient.";
    } else {
        // Si la sécurité sociale est déjà enregistrée pour ce patient, vérifier si elle correspond à la saisie
        if ($existing_ss && $existing_ss['securite_sociale'] !== $input_securite_sociale) {
            $error_message = "Erreur : Ce n'est pas votre numéro de sécurité sociale.";
        } else {
            // Vérifier si un autre patient utilise déjà ce numéro de sécurité sociale
            $check_ss_query = "SELECT id FROM appointments WHERE securite_sociale = :securite_sociale AND patient_id != :user_id";
            $check_ss_stmt = $conn->prepare($check_ss_query);
            $check_ss_stmt->bindParam(':securite_sociale', $input_securite_sociale);
            $check_ss_stmt->bindParam(':user_id', $user_id);
            $check_ss_stmt->execute();
            $ss_exists = $check_ss_stmt->fetch(PDO::FETCH_ASSOC);

            if ($ss_exists) {
                $error_message = "Erreur : Ce numéro de sécurité sociale est déjà utilisé.";
            } else {
                try {
                    $conn->beginTransaction();

                    // Vérifier si un rendez-vous existe déjà pour cette date et heure
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

                        // Récupérer le docteur associé au cabinet
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
                            $stmt->bindParam(':securite_sociale', $input_securite_sociale);
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
                            $error_message = "Erreur : Aucun docteur trouvé pour ce cabinet.";
                        }
                    }
                } catch (Exception $e) {
                    $conn->rollBack();
                    $error_message = "Erreur lors de la réservation : " . $e->getMessage();
                }
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
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
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
        }

        h2 {
            text-align: center;
            color: #28a745;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        button.btn {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
        }

        button.btn:hover {
            background-color: #218838;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #f5c6cb;
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
                echo "<option value='" . $row['id'] . "'>" . htmlspecialchars($row['nom']) . "</option>";
            }
            ?>
        </select>

        <label for="appointment_date">Date et Heure du Rendez-vous:</label>
        <input type="datetime-local" id="appointment_date" name="appointment_date" value="<?php echo htmlspecialchars($appointment_date); ?>" required>

        <label for="securite_sociale">Sécurité Sociale:</label>
        <input type="text" id="securite_sociale" name="securite_sociale" maxlength="21" pattern="^(\d{1}\s\d{2}\s\d{2}\s\d{2}\s\d{3}\s\d{3}\s\d{2})$" value="<?php echo htmlspecialchars($securite_sociale); ?>" required>

        <label for="phone">Numéro de Téléphone:</label>
        <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required value="<?php echo htmlspecialchars($user['phone']); ?>">

        <button type="submit" class="btn">Réserver</button>
    </form>
</div>

<script>
    document.getElementById('securite_sociale').addEventListener('input', function (e) {
        let value = e.target.value.replace(/\D/g, ''); // Supprime tout sauf les chiffres
        let formattedValue = '';

        // Ajoute des espaces après les groupes spécifiques
        if (value.length > 0) { formattedValue += value.substring(0, 1) + ' '; }
        if (value.length > 1) { formattedValue += value.substring(1, 3) + ' '; }
        if (value.length > 3) { formattedValue += value.substring(3, 5) + ' '; }
        if (value.length > 5) { formattedValue += value.substring(5, 7) + ' '; }
        if (value.length > 7) { formattedValue += value.substring(7, 10) + ' '; }
        if (value.length > 10) { formattedValue += value.substring(10, 13)+ ' '; }
        if (value.length > 13) { formattedValue += value.substring(13, 15) }

        e.target.value = formattedValue.trim(); // Met à jour l'input avec le format appliqué
    });
</script>
</body>
</html>
