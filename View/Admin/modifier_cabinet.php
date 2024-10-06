<?php
require_once '../../config/database.php'; // Assurez-vous que ce chemin est correct

$conn = connectDB();

// Initialisation de la variable pour les messages d'erreur
$error_message = '';

// Vérifiez si l'ID du cabinet est passé dans l'URL
if (isset($_GET['id'])) {
    $cabinet_id = $_GET['id'];

    // Récupérer les informations du cabinet
    $query = "SELECT * FROM cabinets WHERE id = :id";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':id', $cabinet_id);
    $stmt->execute();
    
    $cabinet = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // Si le cabinet n'est pas trouvé
    if (!$cabinet) {
        $error_message = "Cabinet non trouvé.";
    }
} else {
    $error_message = "ID du cabinet non fourni.";
}

// Si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Récupérer les données du formulaire
    $nom = $_POST['nom'];
    $adresse = $_POST['adresse'];
    $docteur_id = $_POST['docteur_id'];
    $specialite = $_POST['specialite'];
    $cabinet_id = $_POST['cabinet_id']; // ID du cabinet

    // Vérifier que tous les champs sont remplis
    if (empty($nom) || empty($adresse) || empty($docteur_id) || empty($specialite)) {
        $error_message = "Tous les champs doivent être remplis.";
    } else {
        // Vérifiez si le médecin a déjà une spécialité définie
        $query_specialite = "SELECT DISTINCT specialite FROM cabinets WHERE docteur_id = :docteur_id LIMIT 1";
        $stmt_specialite = $conn->prepare($query_specialite);
        $stmt_specialite->bindParam(':docteur_id', $docteur_id);
        $stmt_specialite->execute();
        $existing_specialite = $stmt_specialite->fetch(PDO::FETCH_ASSOC);

        if ($existing_specialite && $existing_specialite['specialite'] !== $specialite) {
            // Le médecin a déjà une spécialité différente
            $error_message = "Erreur : Le médecin a déjà une spécialité définie (" . htmlspecialchars($existing_specialite['specialite']) . "). Impossible de la modifier.";
        } else {
            // Mise à jour du cabinet
            $query = "UPDATE cabinets SET nom = :nom, adresse = :adresse, docteur_id = :docteur_id, specialite = :specialite WHERE id = :cabinet_id";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':nom', $nom);
            $stmt->bindParam(':adresse', $adresse);
            $stmt->bindParam(':docteur_id', $docteur_id);
            $stmt->bindParam(':specialite', $specialite);
            $stmt->bindParam(':cabinet_id', $cabinet_id);
            
            // Exécuter la requête
            if ($stmt->execute()) {
                // Rediriger vers la page de liste des cabinets avec un message de succès
                header("Location: voir_cabinets.php?success=Le cabinet a été modifié avec succès.");
                exit();
            } else {
                $error_message = "Erreur lors de la modification du cabinet.";
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
    <title>Modifier Cabinet</title>
   <style>
    /* Centrer le formulaire et appliquer un style à la bordure */
    form {
        max-width: 400px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* Ombre pour un effet de relief */
        border-radius: 8px;
        border: 2px solid #F9FCFFFF; /* Bordure bleue autour du formulaire */
    }

    /* Alignement et espacement des champs de formulaire */
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
        box-sizing: border-box; /* Ajouté pour éviter les mouvements */
    }

    input[type="text"]:focus,
    select:focus {
        outline: none;
        border-color: #FFFFFFFF; /* Couleur de surlignage */
    }

    /* Style du bouton de soumission */
    button[type="submit"] {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        width: 100%;
        box-sizing: border-box;
    }

    button[type="submit"]:hover {
        background-color: #218838;
    }

    button[type="submit"]:focus {
        outline: none;
        background-color: #1e7e34; /* Couleur lors du clic */
    }

    .error-message {
        color: red;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
    }

    /* Centrer le conteneur */
    .form-container {
        width: 50%; /* Ajustez selon vos besoins */
        margin: 0 auto;
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1); /* Ombre légère */
    }

    h1 {
        text-align: center;
        margin-bottom: 20px;
    }

   </style>
    
</head>
<body>
    <h1>Modifier Cabinet</h1>

    <!-- Affichage des messages d'erreur s'ils existent -->
    <?php if (!empty($error_message)): ?>
        <p class="error-message"><?php echo htmlspecialchars($error_message); ?></p>
    <?php endif; ?>

    <?php if (isset($cabinet)): ?>
    <!-- Formulaire de modification du cabinet -->
    <form action="modifier_cabinet.php?id=<?php echo $cabinet_id; ?>" method="POST">
        <input type="hidden" name="cabinet_id" value="<?php echo $cabinet['id']; ?>"> <!-- Champ caché pour l'ID du cabinet -->
        
        <label for="nom">Nom du Cabinet:</label>
        <input type="text" name="nom" id="nom" value="<?php echo htmlspecialchars($cabinet['nom']); ?>" required>
        
        <label for="adresse">Adresse du Cabinet:</label>
        <input type="text" name="adresse" id="adresse" value="<?php echo htmlspecialchars($cabinet['adresse']); ?>" required>
        
        <label for="specialite">Spécialité:</label>
        <select name="specialite" id="specialite" required>
            <option value="Cardiologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Cardiologie' ? 'selected' : ''; ?>>Cardiologie</option>
            <option value="Dermatologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Dermatologie' ? 'selected' : ''; ?>>Dermatologie</option>
            <option value="Gynécologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Gynécologie' ? 'selected' : ''; ?>>Gynécologie</option>
            <option value="ORL" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'ORL' ? 'selected' : ''; ?>>ORL</option>
            <option value="Pédiatrie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Pédiatrie' ? 'selected' : ''; ?>>Pédiatrie</option>
        </select>
        
        <label for="docteur_id">Docteur (ID):</label>
        <select name="docteur_id" id="docteur_id" required>
            <?php
            // Récupérer tous les médecins
            $stmt_docteurs = $conn->query("SELECT id, username FROM users WHERE role = 2");
            while ($row = $stmt_docteurs->fetch(PDO::FETCH_ASSOC)) {
                $selected = ($row['id'] == $cabinet['docteur_id']) ? 'selected' : '';
                echo "<option value='" . $row['id'] . "' $selected>" . htmlspecialchars($row['username']) . " (ID: " . $row['id'] . ")</option>";
            }
            ?>
        </select>

        <button type="submit">Modifier le Cabinet</button>
    </form>
    <?php endif; ?>
</body>
</html>
