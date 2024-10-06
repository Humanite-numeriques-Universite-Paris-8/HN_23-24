<?php
session_start();  // Démarre la session

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
                    <a href="../../Controller/index_app.php?action=logout">Déconnexion</a>
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
    <h2>Consulter les questionnaires depuis google forms</h2>
    <p>Consultez la liste des questionnaires remplis par les patients depuis Google Forms.</p>
    <a href="data.html" class="btn btn-primary">Voir les questionnaires</a>
</div>



        </div>

      
    </div>

</body>
</html>
