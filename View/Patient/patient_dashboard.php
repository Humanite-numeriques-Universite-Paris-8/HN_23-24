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
    <title>Tableau de Bord Patient</title>
    <link rel="stylesheet" href="../Admin/css/admin_dashboard.css"> 
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
            <h1>DoctoCabinet Patient</h1>
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
            <div><i class="fas fa-phone"></i> <?php echo htmlspecialchars($admin_phone); ?></div> <!-- Le numéro de téléphone de l'admin -->
        </div>
    </div>

</body>
</html>
