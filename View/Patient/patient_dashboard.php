<?php
session_start(); // Assure que la session est démarrée pour obtenir les informations de l'utilisateur
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Patient</title>
    <link rel="stylesheet" href="../css/admin_dashboard.css"> <!-- Assurez-vous que ce chemin est correct -->
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
            <a href="../../Controller/index_app.php?action=logout">Déconnexion</a>
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
                <a href="voir_cabinets.php" class="btn btn-primary">Voir les Cabinets</a>
            </div>
            <div class="card">
                <h2>Voir mes Rendez-vous</h2>
                <p>Consultez la liste de vos rendez-vous.</p>
                <a href="Lister_Rdv.php" class="btn btn-primary">Voir mes Rendez-vous</a>
            </div>
        </div>
    </div>

</body>
</html>
