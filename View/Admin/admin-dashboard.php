<?php
session_start();  // Ensure session is started

// Check if the user is logged in
if (isset($_SESSION['username'])) {
    $username = $_SESSION['username'];  // Get username from session
} else {
    // Redirect to login if not logged in
    header("Location: ../../View/Auth/login.html");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet"> <!-- Google Font -->
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> <!-- Ensure the CSS path is correct -->
    <style>
        /* Global styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('../../images/medecin-GPS-Sante.jpg') no-repeat center center;
            background-size: cover;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Navbar styling */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            padding: 15px 30px;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar-left h1 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .navbar-center {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .navbar-right .dropbtn {
            background-color: transparent;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .navbar-right .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .navbar-right .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease;
        }

        .navbar-right .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .navbar-right .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Search bar improvements */
      /* Search bar improvements */
.search-container {
    display: flex;
    align-items: center;
    position: relative;
    margin-right: 20px;
    border: 1px solid #fff;
    border-radius: 30px;
    padding: 5px 15px;
    background-color: white;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.search-container input[type="text"] {
    border: none;
    padding: 8px 35px 8px 15px; /* Adjust padding for icon */
    font-size: 14px;
    outline: none;
    border-radius: 30px;
    width: 300px; /* Adjust width as necessary */
    color: #333;
    background-image: url('search-icon.png'); /* Replace with your search icon */
    background-position: 10px center;
    background-repeat: no-repeat;
    background-size: 18px; /* Adjust icon size */
}

.search-container button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    cursor: pointer;
    border-radius: 30px;
    font-size: 14px;
    transition: background-color 0.3s ease;
}

.search-container button:hover {
    background-color: #0056b3;
}

#suggestions-box {
    position: absolute;
    top: 50px; /* Adjust depending on the height of your input field */
    left: 0;
    width: 100%; /* Match the width of the entire search container */
    background-color: white; 
    border: 1px solid #ccc;
    max-height: 300px;
    overflow-y: auto;
    z-index: 1000;
    border-radius: 0px 0px 8px 8px; /* Rounded bottom corners */
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
    visibility: hidden;
    opacity: 0;
    transition: visibility 0.3s ease, opacity 0.3s ease;
}

#suggestions-box.visible {
    visibility: visible;
    opacity: 1;
}

#suggestions-box div {
    padding: 12px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
    border-bottom: 1px solid #f0f0f0;
    display: flex;
    align-items: center;
}

#suggestions-box div:last-child {
    border-bottom: none;
}

#suggestions-box div:hover {
    background-color: #007bff;
    color: white;
}

#suggestions-box img {
    width: 30px;
    height: 30px;
    margin-right: 10px;
    border-radius: 50%;
}

#suggestions-box div {
    padding: 12px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
    border-bottom: 1px solid #f0f0f0; 
}

#suggestions-box div:last-child {
    border-bottom: none;
}

#suggestions-box div:hover {
    background-color: #007bff; 
    color: white; 
}

        /* Dashboard styling */
        .dashboard-container {
            text-align: center;
            margin: 40px;
            background-color: rgba(255, 255, 255, 0.9); /* Add light transparency background */
            padding: 20px;
            border-radius: 10px;
            width: 90%;
            margin: 40px auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .dashboard-container h1 {
            font-size: 32px;
            margin-bottom: 20px;
            color: #007bff;
        }

        .dashboard-container p.welcome-msg {
            font-size: 18px;
            margin-bottom: 30px;
            color: #333;
        }

        .card-container {
            display: flex;
            justify-content: space-evenly;
            flex-wrap: wrap;
        }

        .card {
            background-color: #fff;
            border: none;
            border-radius: 12px;
            padding: 20px;
            width: 240px;
            margin: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .card h2 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #007bff;
        }

        .card p {
            font-size: 14px;
            margin-bottom: 20px;
            color: #555;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 30px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
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
            <!-- Improved Search Bar -->
            <div class="search-container">
                <form action="get_searchMedecin.php" method="GET" id="search-form">
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

    <!-- Admin dashboard content -->
    <div class="dashboard-container">
        <h1>Bienvenue sur le Tableau de Bord Admin</h1>
        <p class="welcome-msg">Vous êtes connecté avec succès !</p>

        <div class="card-container">
            <div class="card">
                <h2>Ajouter un Cabinet</h2>
                <p>Ajoutez un nouveau cabinet avec les informations du docteur.</p>
                <a href="ajouter_cabinet.php" class="btn">Ajouter un Cabinet</a>
            </div>
            <div class="card">
                <h2>Voir la liste des Cabinets</h2>
                <p>Consultez et gérez la liste des cabinets disponibles.</p>
                <a href="voir_cabinets.php" class="btn">Voir les Cabinets</a>
            </div>
            <div class="card">
                <h2>Voir les médecins</h2>
                <p>Consultez la liste des médecins.</p>
                <a href="getMedecin.php" class="btn">Voir les Médecins</a>
            </div>
            <div class="card">
                <h2>Voir les Patients</h2>
                <p>Consultez la liste des patients ayant réservé des rendez-vous.</p>
                <a href="getPatient.php" class="btn">Voir les Patients</a>
            </div>

            <div class="card">
                <h2>Mon contact</h2>
                <p>Mise à jour en cas de changement de mon numéro de téléphone.</p>
                <a class="btn" href="../Admin/update_profile.php">Mise à jour Mon Num de Tél</a>
            </div>
            <div class="card">
                <h2>Cabinet</h2>
                <p>GET API MAPS</p>
                <a class="btn" href="../Admin/getCabinetMap.html">Maps</a>
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
            document.getElementById("suggestions-box").innerHTML = ""; // Clear suggestions
            document.getElementById("suggestions-box").style.visibility = "hidden"; // Hide suggestions box after selection
            document.getElementById("search-form").submit(); // Submit the form after selection
        }
function showSuggestions(searchTerm) {
    const suggestionsBox = document.getElementById("suggestions-box");

    if (searchTerm.length === 0) {
        suggestionsBox.innerHTML = "";
        suggestionsBox.classList.remove("visible");
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            const responseText = this.responseText.trim();
            if (responseText !== "") {
                suggestionsBox.innerHTML = responseText;
                suggestionsBox.classList.add("visible");
            } else {
                suggestionsBox.classList.remove("visible");
            }
        }
    };

    xhr.open("GET", "suggestions_medecins.php?search_term=" + encodeURIComponent(searchTerm), true);
    xhr.send();
}

        // function showSuggestions(searchTerm) {
        //     const suggestionsBox = document.getElementById("suggestions-box");

        //     if (searchTerm.length === 0) {
        //         suggestionsBox.innerHTML = "";
        //         suggestionsBox.style.visibility = "hidden";
        //         return;
        //     }

        //     const xhr = new XMLHttpRequest();
        //     xhr.onreadystatechange = function() {
        //         if (this.readyState === 4 && this.status === 200) {
        //             const responseText = this.responseText.trim();
        //             if (responseText !== "") {
        //                 suggestionsBox.innerHTML = responseText;
        //                 suggestionsBox.style.visibility = "visible";
        //             } else {
        //                 suggestionsBox.style.visibility = "hidden";
        //             }
        //         }
        //     };

        //     xhr.open("GET", "suggestions_medecins.php?search_term=" + encodeURIComponent(searchTerm), true);
        //     xhr.send();
        // }
        function selectSuggestion(value) {
    document.getElementById("search_term").value = value;
    document.getElementById("suggestions-box").innerHTML = ""; // Efface les suggestions
    document.getElementById("suggestions-box").style.visibility = "hidden"; // Cache la boîte après sélection
    document.getElementById("search-form").submit(); // Soumettre après sélection
}
    </script>
</body>
</html>
