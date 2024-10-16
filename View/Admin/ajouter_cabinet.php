<?php
require_once '../../config/database.php';

$conn = connectDB();
$error_message = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nom = $_POST['nom'];
    $adresse = $_POST['adresse'];
    $docteur_id = $_POST['docteur_id'];
    $specialite = $_POST['specialite'];

    if (empty($nom) || empty($adresse) || empty($docteur_id) || empty($specialite)) {
        $error_message = "Tous les champs doivent être remplis.";
    } else {
        $query_specialite = "SELECT DISTINCT specialite FROM cabinets WHERE docteur_id = :docteur_id LIMIT 1";
        $stmt_specialite = $conn->prepare($query_specialite);
        $stmt_specialite->bindParam(':docteur_id', $docteur_id);
        $stmt_specialite->execute();
        $existing_specialite = $stmt_specialite->fetch(PDO::FETCH_ASSOC);

        if ($existing_specialite && $existing_specialite['specialite'] !== $specialite) {
            $error_message = "Erreur : Le médecin a déjà une spécialité définie (" . htmlspecialchars($existing_specialite['specialite']) . "). Impossible d'ajouter une autre spécialité.";
        } elseif ($existing_specialite && $existing_specialite['specialite'] === $specialite) {
            $query = "INSERT INTO cabinets (nom, adresse, docteur_id, specialite) VALUES (:nom, :adresse, :docteur_id, :specialite)";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':nom', $nom);
            $stmt->bindParam(':adresse', $adresse);
            $stmt->bindParam(':docteur_id', $docteur_id);
            $stmt->bindParam(':specialite', $specialite);

            if ($stmt->execute()) {
                header("Location: voir_cabinets.php?success=Cabinet ajouté avec succès.");
                exit();
            } else {
                $error_message = "Erreur lors de l'ajout du cabinet.";
            }
        } else {
            $query = "INSERT INTO cabinets (nom, adresse, docteur_id, specialite) VALUES (:nom, :adresse, :docteur_id, :specialite)";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':nom', $nom);
            $stmt->bindParam(':adresse', $adresse);
            $stmt->bindParam(':docteur_id', $docteur_id);
            $stmt->bindParam(':specialite', $specialite);

            if ($stmt->execute()) {
                header("Location: voir_cabinets.php?success=Cabinet ajouté avec succès.");
                exit();
            } else {
                $error_message = "Erreur lors de l'ajout du cabinet.";
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
    <title>Ajouter un Cabinet</title>
    <!-- <link rel="stylesheet" href="../../View/Admin/css/ajouter_cabinet.css"> -->
     <style>
        body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f2f2f2;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}

.form-container {
    max-width: 400px;
    background-color: #fff;
    padding: 40px;
    padding-right: 60px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
}

input[type="text"],
select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

button[type="submit"] {
    background-color: #28a745;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    width: 100%;
}

button[type="submit"]:hover {
    background-color: #218838;
}

/* Styles du message d'erreur pour qu'il soit bien espacé du haut */
.error-message {
    color: red;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
    border: 1px solid red;
    padding: 10px;
    background-color: #ffe6e6;
    border-radius: 5px;
    max-width: 100%; /* Ajuste le message d'erreur à la largeur du conteneur */
    box-sizing: border-box;
}

/* To avoid shifting the content when there's an error message */
.error-message + form {
    margin-top: 20px;  /* Add space below the error message */
}

     </style>
</head>
<body>

    <div class="form-container">
        <h1>Ajouter un Cabinet</h1>

        <!-- Afficher le message d'erreur -->
        <?php if (!empty($error_message)): ?>
            <div class="error-message">
                <?php echo $error_message; ?>
            </div>
        <?php endif; ?>

        <form action="ajouter_cabinet.php" method="POST">
            <label for="nom">Nom du Cabinet:</label>
            <input type="text" name="nom" id="nom" value="<?php echo isset($nom) ? htmlspecialchars($nom) : ''; ?>" required>

            <label for="adresse">Adresse du Cabinet:</label>
            <input type="text" name="adresse" id="adresse" value="<?php echo isset($adresse) ? htmlspecialchars($adresse) : ''; ?>" required>

            <label for="docteur_id">Docteur (ID):</label>
            <select name="docteur_id" id="docteur_id" required>
    <?php
    $stmt = $conn->query("SELECT id, username FROM users WHERE role = 'medecin'");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<option value='" . $row['id'] . "'>" . htmlspecialchars($row['username']) . "</option>";
    }
    ?>
</select>


            <label for="specialite">Spécialité:</label>
            <select name="specialite" id="specialite" required>
                <option value="Cardiologie" <?php echo isset($specialite) && $specialite == 'Cardiologie' ? 'selected' : ''; ?>>Cardiologie</option>
                <option value="Dermatologie" <?php echo isset($specialite) && $specialite == 'Dermatologie' ? 'selected' : ''; ?>>Dermatologie</option>
                <option value="Gynécologie" <?php echo isset($specialite) && $specialite == 'Gynécologie' ? 'selected' : ''; ?>>Gynécologie</option>
                <option value="ORL" <?php echo isset($specialite) && $specialite == 'ORL' ? 'selected' : ''; ?>>ORL</option>
                <option value="Pédiatrie" <?php echo isset($specialite) && $specialite == 'Pédiatrie' ? 'selected' : ''; ?>>Pédiatrie</option>
            </select>

            <button type="submit">Ajouter le Cabinet</button>
        </form>
    </div>

</body>
</html>
