<?php
session_start(); // Assure que la session est démarrée pour obtenir les informations de l'utilisateur
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Patient</title>
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> 
   
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

    <!-- Navbar starts here -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>DoctoCabinet Patient</h1> <!-- Remplacez par le nom de votre site -->
        </div>
        <div class="navbar-right">
            <div class="dropdown">
                <button class="dropbtn">
                    <?php echo isset($_SESSION['username']) ? htmlspecialchars($_SESSION['username']) : 'Utilisateur'; ?> ▼
                </button> <!-- Nom de l'utilisateur connecté -->
                <div class="dropdown-content">
                    <a href="../../Controller-Auth/index_app.php?action=logout">Déconnexion</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Navbar ends here -->

    <!-- Patient Dashboard Cards -->
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

            <div class="card">
                <h2>Mon contact</h2>
                <p>mise à jour en cas de changement de mon num de tel</p>
                <a class="btn btn-primary" href="../Patient/update_profile.php">Mise à jour Mon Num de Tél</a>
            </div>


        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>contacter l'assistance M. Anas Hefied en cas d'urgence.</p>
        <div class="footer-contact">
            <div><i class="fas fa-map-marker-alt"></i> 10, Allée Gagarie, Ivry-sur-Seine, France</div>
            <div><i class="fas fa-envelope"></i> anas.hefied@gmail.com</div>
            <div><i class="fas fa-phone"></i> (+33) 0670622027</div>
        </div>
    </div>
</body>
</html>
