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
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Cabinet avec Autocomplétion d'Adresse</title>
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
            width: 25%;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 40px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            border-radius: 28px;
            text-align: center;
        }
        h1 {
            margin-bottom: 30px;
            font-size: 24px;
            color: #333;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            text-align: left;
        }
        input[type="text"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border 0.3s;
        }
        input[type="text"]:focus, select:focus {
            border-color: #007bff;
            outline: none;
        }
        button[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
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
            border-radius: 6px;
        }
        @media (max-width: 768px) {
            .form-container {
                max-width: 90%;
                padding: 20px;
            }
        }
        .form-container {
            width: 40%;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            position: relative;
        }
        input[type="text"], select, input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
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
    <h2>Ajouter un Cabinet</h2>
    <form id="cabinetForm" action="ajouter_cabinet.php" method="POST">
        <label for="nom">Nom du Cabinet:</label>
        <input type="text" name="nom" id="nom" placeholder="Nom du cabinet" required>

        <label for="adresse">Adresse du Cabinet:</label>
        <input type="text" name="adresse" id="adresse" placeholder="Tapez pour voir les suggestions" required>
        <div id="autocomplete-list" class="autocomplete-suggestions"></div>

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

        fetch('getCabinetMaps.php')
            .then(response => response.json())
            .then(data => {
                const filteredSuggestions = data.filter(address => address.toLowerCase().includes(query.toLowerCase()));
                showSuggestions(query, filteredSuggestions);
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
