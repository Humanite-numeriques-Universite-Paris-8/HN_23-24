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
    // Si l'utilisateur n'est pas connecté, rediriger vers la page de connexion
    header("Location: ../Auth/login.php");
    exit();
}

// Récupère les informations de l'utilisateur connecté
$username = $_SESSION['username'];
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Médecin</title>
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> <!-- Assurez-vous que ce chemin est correct -->
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
            <h1>DoctoCabinet Médecin</h1>
        </div>
        <div class="navbar-right">
            <div class="dropdown">
                <button class="dropbtn"><?php echo htmlspecialchars($username); ?> ▼</button> <!-- Affiche le nom de l'utilisateur -->
                <div class="dropdown-content">
                    <a href="../../Controller-Auth/index_app.php?action=logout">Déconnexion</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Fin Navbar -->

    <!-- Tableau de bord -->
    <div class="dashboard-container">
        <h1>Bienvenue sur le Tableau de Bord Médecin</h1>
        <p class="welcome-msg">Vous êtes connecté avec succès en tant que médecin.</p>
        
        <div class="card-container">
            <div class="card">
                <h2>Voir les Rendez-vous</h2>
                <p>Consultez la liste des rendez-vous à venir.</p>
                <a href="../Medecin/Lister_Rdv" class="btn btn-primary">Voir les Rendez-vous</a>
            </div>
   
            <div class="card">
                <h2>mon contact</h2>
                <p>mise à jour en cas de changement de mon num de tel</p>
                <a class="btn btn-primary" href="../Medecin/update_profile.php">Mise à jour Mon Num de Tél</a>
            </div>
   
            <div class="card">
                <h2>Consulter les questionnaires depuis google forms</h2>
                <p>Consultez la liste des questionnaires remplis par les patients depuis Google Forms.</p>
                <a href="../../data.html" class="btn btn-primary">Voir les questionnaires</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Contacter l'assistance M. Anas Hefied en cas d'urgence.</p>
        <div class="footer-contact">
            <div><i class="fas fa-map-marker-alt"></i> 10, Allée Gagarie, Ivry-sur-Seine, France</div>
            <div><i class="fas fa-envelope"></i> anas.hefied@gmail.com</div>
            <div><i class="fas fa-phone"></i> <?php echo htmlspecialchars($admin_phone); ?></div> <!-- Le numéro de téléphone de l'admin -->
        </div>
    </div>

</body>
</html>
