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
/* Global Styles */
body {
    font-family: 'Poppins', sans-serif;
    background: url('../../images/medecin-GPS-Sante.jpg') no-repeat center center;
    background-size: cover;
    background-attachment: fixed;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Navbar Styling */
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

/* Search Bar Styling */
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
    padding: 8px 35px 8px 15px;
    font-size: 14px;
    outline: none;
    border-radius: 30px;
    width: 300px;
    color: #333;
    background-image: url('search-icon.png'); /* Replace with your search icon */
    background-position: 10px center;
    background-repeat: no-repeat;
    background-size: 18px;
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

/* Suggestions Box */
#suggestions-box {
    position: absolute;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
    max-height: 200px;
    overflow-y: auto;
    z-index: 1000;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    visibility: hidden;
}

#suggestions-box div {
    padding: 12px 15px;
    font-size: 16px;
    color: #333;
    background-color: #fff;
    transition: background-color 0.3s ease;
}

#suggestions-box div:hover {
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
}

#search_term:focus + #suggestions-box {
    visibility: visible;
}

/* Dashboard Container */
.dashboard-container {
    text-align: center;
    margin: 40px;
    background-color: rgba(255, 255, 255, 0.9);
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
                <h2>Voir la liste des Cabinets</h2>
                <p>Consultez la liste des cabinets disponibles.</p>
                <a href="lister_ContactMedecin.php" class="btn btn-primary">Voir les Cabinets</a>
            </div>

            <div class="card">
                <h2>Réserver un Rendez-vous</h2>
                <p>Réservez un rendez-vous avec un docteur dans un cabinet disponible.</p>
                <a href="reserver_rdv.php" class="btn btn-primary">Réserver un Rdv</a>
            </div>
   
            <div class="card">
                <h2>Voir mes Rendez-vous</h2>
                <p>Consultez la liste de vos rendez-vous.</p>
                <a href="patient_lister_rdv.php" class="btn btn-primary">Voir mes Rendez-vous</a>
            </div>
            <div class="card">
                <h2>Consulter les questionnaires depuis google forms</h2>
                <p>Consultez la liste des questionnaires remplis par les patients depuis Google Forms.</p>
                <a href="../../data.html" class="btn btn-primary">Voir le formulaire à remplir</a>
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
