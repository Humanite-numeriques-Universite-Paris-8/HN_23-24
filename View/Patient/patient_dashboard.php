<?php
session_start();  // Démarre la session

// Connexion à la base de données
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct
$conn = connectDB();

// Récupère les informations de l'admin (son numéro de téléphone)
$query_admin_phone = "SELECT phone FROM users WHERE role = 'admin' LIMIT 1";
$stmt_admin_phone = $conn->prepare($query_admin_phone);
$stmt_admin_phone->execute();
$admin = $stmt_admin_phone->fetch(PDO::FETCH_ASSOC);

$admin_phone = $admin ? $admin['phone'] : 'Non disponible';

// Vérifie si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: ../Auth/login.php");
    exit();
}

$username = $_SESSION['username'];
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Patient</title>
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        /* Navbar Styling */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            padding: 10px;
            color: white;
        }

        .navbar-left h1 {
            margin: 0;
        }

        .navbar-right {
            display: flex;
            align-items: center;
        }

        .search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

.search-container input[type="text"] {
    width: 300px;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.search-container button {
    padding: 10px;
    font-size: 16px;
    background-color: white;
    color: #007bff;
    border: 1px solid #007bff;
    border-radius: 5px;
    margin-left: 10px;
    cursor: pointer;
}

#suggestions-box {
    position: absolute;
    background-color: #f9f9f9; /* Couleur de fond claire */
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;  /* Adapter à la largeur du champ de recherche */
    max-height: 200px;
    overflow-y: auto;
    z-index: 1000;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);  /* Ajout d'une ombre douce */
    visibility: hidden;
}

#suggestions-box div {
    padding: 12px 15px;  /* Plus d'espace autour du texte */
    font-size: 16px;  /* Taille de texte légèrement plus grande */
    color: #333;  /* Texte en gris foncé pour une meilleure lisibilité */
    background-color: #fff;  /* Fond blanc */
    transition: background-color 0.3s ease;
}

#suggestions-box div:hover {
    background-color: #007bff;  /* Fond bleu au survol */
    color: #fff;  /* Texte blanc au survol */
    cursor: pointer;
}

#search_term {
    border: 1px solid #007bff;  /* Bordure bleue du champ de recherche */
    border-radius: 5px;
    padding: 10px;
    font-size: 16px;
    width: 300px;
}

#search_term:focus {
    outline: none;
    box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5); /* Effet de surbrillance au focus */
}

.search-container input:focus + #suggestions-box {
    visibility: visible; /* Rend visible quand le champ de recherche est focus */
}

        /* Footer Styling */
        .footer {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 20px 0;
            position: absolute;
            bottom: 0;
            width: 100%;
            font-size: 14px;
        }

        .footer a {
            color: #ffc107;
            text-decoration: none;
        }

        .footer a:hover {
            color: #fff;
            text-decoration: underline;
        }

        .footer .footer-contact {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
            gap: 30px;
        }

        .footer .footer-contact div {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer .footer-contact div i {
            font-size: 18px;
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>DoctoCabinet Patient</h1>
        </div>

        <!-- Search container centered -->
        <div class="search-container">
            <form action="recherche_cabinets.php" method="GET" id="search-form">
                <input type="text" id="search_term" name="search_term" placeholder="Rechercher par spécialité ou nom de docteur..." onkeyup="showSuggestions(this.value)" autocomplete="off" required>
                <button type="submit">Rechercher</button>
                <div id="suggestions-box"></div> <!-- Boîte pour afficher les suggestions -->
            </form>
        </div>

        <div class="navbar-right">
            <div class="dropdown">
                <button class="dropbtn"><?php echo htmlspecialchars($username); ?> ▼</button>
                <div class="dropdown-content">
                    <a href="../../Controller-Auth/index_app.php?action=logout">Déconnexion</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Fin Navbar -->

    <!-- Tableau de bord -->
    <div class="dashboard-container">
        <h1>Bienvenue sur le Tableau de Bord Patient</h1>
        <p class="welcome-msg">Vous êtes connecté avec succès !</p>

        <div class="card-container">
            <div class="card">
                <h2>Réserver un Rendez-vous</h2>
                <p>Réservez un rendez-vous avec un docteur dans un cabinet disponible.</p>
                <a href="reserver_rdv.php" class="btn btn-primary">Réserver un Rdv</a>
            </div>
   
            <div class="card">
                <h2>Voir la liste des Cabinets</h2>
                <p>Consultez la liste des cabinets disponibles.</p>
                <a href="lister_ContactMedecin.php" class="btn btn-primary">Voir les Cabinets</a>
            </div>
   
            <div class="card">
                <h2>Voir mes Rendez-vous</h2>
                <p>Consultez la liste de vos rendez-vous.</p>
                <a href="patient_lister_rdv.php" class="btn btn-primary">Voir mes Rendez-vous</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Contacter l'assistance M. Anas Hefied en cas d'urgence.</p>
        <div class="footer-contact">
            <div><i class="fas fa-map-marker-alt"></i> 10, Allée Gagarie, Ivry-sur-Seine, France</div>
            <div><i class="fas fa-envelope"></i> anas.hefied@gmail.com</div>
            <div><i class="fas fa-phone"></i> <?php echo htmlspecialchars($admin_phone); ?></div>
        </div>
    </div>


<script>
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
                suggestionsBox.style.visibility = "visible"; // Rend visible les suggestions uniquement si des résultats sont trouvés
            } else {
                suggestionsBox.style.visibility = "hidden"; // Cache la boîte si aucune suggestion n'est trouvée
            }
        }
    };

    xhr.open("GET", "suggestions_cabinets.php?search_term=" + encodeURIComponent(searchTerm), true);
    xhr.send();
}

function selectSuggestion(value) {
    document.getElementById("search_term").value = value;
    document.getElementById("suggestions-box").innerHTML = ""; // Efface les suggestions
    document.getElementById("suggestions-box").style.visibility = "hidden"; // Cache la boîte après sélection
    document.getElementById("search-form").submit(); // Soumettre après sélection
}

</script>


</body>
</html>
