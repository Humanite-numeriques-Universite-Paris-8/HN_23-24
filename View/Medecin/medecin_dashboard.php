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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        /* Footer Styling */
        .footer {
            background-color:#007bff;
            
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
                <h2>Profil</h2>
                <p>Consultez la liste des rendez-vous à venir.</p>
                <a href="../Medecin/update_profile.php">Mettre à Jour Mon Profil</a>
            </div>
   
            <div class="card">
                <h2>Contact patient</h2>
                <p>Consultez la liste des contacts des patients</p>
                <a  class="btn btn-primary">voir contacts des patients</a>
            </div>
           

        
            <div class="card">
    <h2>Consulter les questionnaires depuis google forms</h2>
    <p>Consultez la liste des questionnaires remplis par les patients depuis Google Forms.</p>
    <a href="../../data.html" class="btn btn-primary">Voir les questionnaires</a>
</div>


<div class="footer">
        <p>contacter l'assistance M. Anas Hefied en cas d'urgence.</p>
        <div class="footer-contact">
            <div><i class="fas fa-map-marker-alt"></i> 10, Allée Gagarie, Ivry-sur-Seine, France</div>
            <div><i class="fas fa-envelope"></i> anas.hefied@gmail.com</div>
            <div><i class="fas fa-phone"></i> (+33) 0670622027</div>
        </div>
    </div>


        </div>

      
    </div>

</body>
</html>
