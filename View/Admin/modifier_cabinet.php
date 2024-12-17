<?php
require_once '../../config/database.php'; // Assurez-vous que ce chemin est correct

$conn = connectDB();
$error_message = '';

// Si l'ID du cabinet est passé dans l'URL, récupérez-le
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

    if (empty($nom) || empty($adresse) || empty($docteur_id) || empty($specialite)) {
        $error_message = "Tous les champs doivent être remplis.";
    } else {
        // Vérifiez si un cabinet avec le même nom existe déjà, à l'exclusion du cabinet en cours de modification
        $query_check = "SELECT id FROM cabinets WHERE nom = :nom AND id != :cabinet_id";
        $stmt_check = $conn->prepare($query_check);
        $stmt_check->bindParam(':nom', $nom);
        $stmt_check->bindParam(':cabinet_id', $cabinet_id);
        $stmt_check->execute();
        $cabinet_exists = $stmt_check->fetch(PDO::FETCH_ASSOC);

        if ($cabinet_exists) {
            $error_message = "Erreur : Un autre cabinet avec ce nom existe déjà.";
        } else {
            // Vérifier si le médecin a déjà une spécialité définie différente
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
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Cabinet</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            display: flex; 
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: url('../../images/cabinet4.avif');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            font-family: 'Poppins', sans-serif;
        }
        .form-container {
            width: 40%;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            position: relative;
        }
        h1 {
            text-align: center;
            color: #007bff;
            font-size: 24px;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #218838;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        .autocomplete-suggestions {
            border: 1px solid #ddd;
            background-color: #fff;
            max-height: 150px;
            overflow-y: auto;
            border-radius: 5px;
            position: absolute;
            z-index: 9999;
            width: calc(100% - 22px);
        }
        .autocomplete-suggestions div {
            padding: 10px;
            cursor: pointer;
        }
        .autocomplete-suggestions div:hover {
            background-color: #e9e9e9;
        }
    </style>
</head>
<body>

    <div class="form-container">
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
            <input type="text" name="adresse" id="adresse" value="<?php echo htmlspecialchars($cabinet['adresse']); ?>" placeholder="Tapez pour voir les suggestions" autocomplete="off" required>
            <div id="autocomplete-list" class="autocomplete-suggestions"></div>

            <label for="specialite">Spécialité:</label>
            <select name="specialite" id="specialite" required>
                <option value="Cardiologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Cardiologie' ? 'selected' : ''; ?>>Cardiologie</option>
                <option value="Dermatologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Dermatologie' ? 'selected' : ''; ?>>Dermatologie</option>
                <option value="Gynécologie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Gynécologie' ? 'selected' : ''; ?>>Gynécologie</option>
                <option value="ORL" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'ORL' ? 'selected' : ''; ?>>ORL</option>
                <option value="Pédiatrie" <?php echo isset($cabinet['specialite']) && $cabinet['specialite'] == 'Pédiatrie' ? 'selected' : ''; ?>>Pédiatrie</option>
                <option value="chirurgien" <?php echo isset($specialite) && $specialite == 'chirurgien' ? 'selected' : ''; ?>>Chirurgien</option>
            </select>
            
            <label for="docteur_id">Docteur (ID):</label>
            <select name="docteur_id" id="docteur_id" required>
                <?php
                // Récupérer tous les médecins
                $stmt_docteurs = $conn->query("SELECT id, username FROM users WHERE role = 'medecin'");

                while ($row = $stmt_docteurs->fetch(PDO::FETCH_ASSOC)) {
                    $selected = ($row['id'] == $cabinet['docteur_id']) ? 'selected' : '';
                    echo "<option value='" . $row['id'] . "' $selected>" . htmlspecialchars($row['username']) . " (ID: " . $row['id'] . ")</option>";
                }
                ?>
            </select>

            <button type="submit">Modifier le Cabinet</button>
        </form>
        <?php endif; ?>
    </div>

    <script>
        // Fonction pour afficher les suggestions d'adresses
        function showSuggestions(input, suggestions) {
            const suggestionBox = document.getElementById("autocomplete-list");
            suggestionBox.innerHTML = "";

            if (!input) return;

            suggestions.forEach((address) => {
                const suggestionItem = document.createElement("div");
                suggestionItem.textContent = address;
                suggestionItem.onclick = function() {
                    document.getElementById("adresse").value = address;
                    suggestionBox.innerHTML = "";
                };
                suggestionBox.appendChild(suggestionItem);
            });
        }

        // Récupérer les adresses via AJAX
        document.getElementById("adresse").addEventListener("input", function() {
            const query = this.value;
            if (query.length < 3) return; // Limite la requête aux entrées de 3 caractères ou plus

            fetch('getCabinetMaps.php?query=' + query)
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        console.error("Erreur : ", data.error);
                        return;
                    }
                    showSuggestions(query, data);  // Afficher les suggestions
                })
                .catch(error => console.error("Erreur lors de la récupération des adresses:", error));
        });

        // Fermer la liste de suggestions en cliquant ailleurs
        document.addEventListener("click", function(e) {
            const suggestionBox = document.getElementById("autocomplete-list");
            if (e.target.id !== "adresse") {
                suggestionBox.innerHTML = "";
            }
        });
    </script>

</body>
</html>
