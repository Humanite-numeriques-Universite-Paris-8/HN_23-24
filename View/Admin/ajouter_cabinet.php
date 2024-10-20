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
        // Récupérer le nom du docteur
        $stmt_docteur = $conn->prepare("SELECT username FROM users WHERE id = :docteur_id");
        $stmt_docteur->bindParam(':docteur_id', $docteur_id);
        $stmt_docteur->execute();
        $docteur = $stmt_docteur->fetch(PDO::FETCH_ASSOC);

        // Générer le format attendu
        $nom_attendu = "Cabinet chez Dr " . $docteur['username'];

        // Comparer le nom saisi avec le format attendu, insensible à la casse
        if (strcasecmp($nom, $nom_attendu) !== 0) {
            $error_message = "Erreur : Le nom du cabinet doit respecter la structure : $nom_attendu";
        } else {
            // Vérifier si un cabinet avec le même nom existe déjà (insensible à la casse)
            $query_check = "SELECT id FROM cabinets WHERE LOWER(nom) = LOWER(:nom)";
            $stmt_check = $conn->prepare($query_check);
            $stmt_check->bindParam(':nom', $nom);
            $stmt_check->execute();
            $cabinet_exists = $stmt_check->fetch(PDO::FETCH_ASSOC);

            if ($cabinet_exists) {
                $error_message = "Erreur : Ce cabinet existe déjà.";
            } else {
                // Insérer le cabinet si aucun doublon n'est trouvé
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
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Cabinet</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f2f2f2;
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
        input[type="text"], select {
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
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid red;
            padding: 10px;
            background-color: #ffe6e6;
            border-radius: 5px;
            max-width: 100%;
            box-sizing: border-box;
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
            <input type="text" name="nom" id="nom" 
                   placeholder="Cabinet chez Dr [Nom du docteur]" 
                   value="<?php echo isset($nom) ? htmlspecialchars($nom) : ''; ?>" required>

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
                <option value="chirurgien" <?php echo isset($specialite) && $specialite == 'chirurgien' ? 'selected' : ''; ?>>Chirurgien</option>
            </select>

            <button type="submit">Ajouter le Cabinet</button>
        </form>
    </div>

</body>
</html>
