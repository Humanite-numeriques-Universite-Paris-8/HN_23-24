<?php
session_start();  // Make sure the session is started at the beginning of the page

// Check if the user is logged in and if the username is set in the session
if (isset($_SESSION['username'])) {
    $username = $_SESSION['username'];  // Get the username from the session
} else {
    // If the user is not logged in, redirect them to the login page
    header("Location: ../../View/Auth/login.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> <!-- Make sure the CSS path is correct -->
    <style>
        /* Add style for the suggestion box */
        .search-container {
            display: flex;
            align-items: center;
            position: relative;
            margin-right: 20px; /* Adjust the spacing to suit the design */
        }

        .search-container input[type="text"] {
            width: 250px;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-container button {
            padding: 8px;
            font-size: 14px;
            background-color: white;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 5px;
            margin-left: 10px;
            cursor: pointer;
        }

        #suggestions-box {
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            width: 250px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            visibility: hidden;
        }

        #suggestions-box div {
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #suggestions-box div:hover {
            background-color: #007bff;
            color: white;
        }

        #search_term {
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 8px;
            font-size: 14px;
        }

        #search_term:focus {
            outline: none;
            box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
        }

        .search-container input:focus + #suggestions-box {
            visibility: visible;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>DoctoCabinet Admin</h1>
        </div>
        <div class="navbar-center">
            <!-- Search bar moved to navbar -->
            <div class="search-container">
                <form action="getMedecin.php" method="GET" id="search-form">
                    <input type="text" id="search_term" name="search_term" placeholder="Rechercher..." onkeyup="showSuggestions(this.value)" autocomplete="off" required>
                    <button type="submit">Rechercher</button>
                    <div id="suggestions-box"></div> <!-- Suggestions will be displayed here -->
                </form>
            </div>
        </div>
        <div class="navbar-right">
            <div class="dropdown">
                <button class="dropbtn"><?php echo htmlspecialchars($username); ?> ▼</button> <!-- Display the username -->
                <div class="dropdown-content">
                    <a href="../../Controller-Auth/index_app.php?action=logout">Déconnexion</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Rest of the admin dashboard content -->
    <div class="dashboard-container">
        <h1>Bienvenue sur le Tableau de Bord Admin</h1>
        <p class="welcome-msg">Vous êtes connecté avec succès !</p>

        <div class="card-container">
            <div class="card">
                <h2>Ajouter un Cabinet</h2>
                <p>Ajoutez un nouveau cabinet avec les informations du docteur.</p>
                <a href="ajouter_cabinet.php" class="btn btn-primary">Ajouter un Cabinet</a>
            </div>
            <div class="card">
                <h2>Voir la liste des Cabinets</h2>
                <p>Consultez et gérez la liste des cabinets disponibles.</p>
                <a href="voir_cabinets.php" class="btn btn-primary">Voir les Cabinets</a>
            </div>
            <div class="card">
                <h2>Voir les médecins</h2>
                <p>Consultez la liste des médecins.</p>
                <a href="getMedecin.php" class="btn btn-primary">Voir les Médecins</a>
            </div>
            <div class="card">
                <h2>Voir les Patients</h2>
                <p>Consultez la liste des patients ayant réservé des rendez-vous.</p>
                <a href="getPatient.php" class="btn btn-primary">Voir les Patients</a>
            </div>

            <div class="card">
                <h2>Mon contact</h2>
                <p>Mise à jour en cas de changement de mon numéro de téléphone.</p>
                <a class="btn btn-primary" href="../Admin/update_profile.php">Mise à jour Mon Num de Tél</a>
            </div>
        </div>
    </div>

    <script>
        function selectSuggestion(value) {
            let parts = value.split(" - ");
            if (parts.length === 2) {
                let search_term = parts[0].trim(); // Spécialité
                let docteur_name = parts[1].trim(); // Nom du docteur

                document.getElementById("search_term").value = search_term;

                let form = document.getElementById("search-form");
                let input = document.createElement("input");
                input.type = "hidden";
                input.name = "docteur_name";
                input.value = docteur_name;
                form.appendChild(input);
            }
            document.getElementById("suggestions-box").innerHTML = ""; // Effacer les suggestions
            document.getElementById("suggestions-box").style.visibility = "hidden"; // Cacher après sélection
            document.getElementById("search-form").submit(); // Soumettre après sélection
        }

        function showSuggestions(searchTerm) {
            const suggestionsBox = document.getElementById("suggestions-box");

            if (searchTerm.length === 0) {
                suggestionsBox.innerHTML = "";
                suggestionsBox.style.visibility = "hidden";
                return;
            }

            const xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                    const responseText = this.responseText.trim();
                    if (responseText !== "") {
                        suggestionsBox.innerHTML = responseText;
                        suggestionsBox.style.visibility = "visible"; // Show suggestions when results are found
                    } else {
                        suggestionsBox.style.visibility = "hidden"; // Hide suggestions box when no results
                    }
                }
            };

            xhr.open("GET", "suggestions_medecins.php?search_term=" + encodeURIComponent(searchTerm), true);
            xhr.send();
        }

        function selectSuggestion(value) {
            document.getElementById("search_term").value = value;
            document.getElementById("suggestions-box").innerHTML = ""; // Clear suggestions
            document.getElementById("suggestions-box").style.visibility = "hidden"; // Hide suggestions box after selection
            document.getElementById("search-form").submit(); // Submit the form after selection
        }
    </script>
</body>
</html>
