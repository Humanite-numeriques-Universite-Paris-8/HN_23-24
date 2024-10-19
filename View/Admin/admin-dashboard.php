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
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>DoctoCabinet Admin</h1>
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
                <h2>mon contact</h2>
                <p>mise à jour en cas de changement de mon num de tel</p>
                <a class="btn btn-primary" href="../Admin/update_profile.php">Mise à jour Mon Num de Tél</a>
            </div>
   
            
        </div>
    </div>

</body>
</html>
