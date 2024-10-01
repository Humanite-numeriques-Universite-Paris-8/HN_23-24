<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord</title>
    <link rel="stylesheet" href="../css/appointment.css">
</head>
<body>
    <div class="dashboard-container">
        <h1>Bienvenue sur le Tableau de Bord</h1>
        <p class="welcome-msg">Vous êtes connecté avec succès !</p>
        
        <div class="card-container">
            <div class="card">
                <h2>Gérer les Rendez-vous</h2>
                <p>Consulter, planifier et gérer vos rendez-vous.</p>
                <a href="manage_appointments.php" class="btn">Gérer les Rendez-vous</a>
            </div>
            <div class="card">
                <h2>Profil</h2>
                <p>Voir et modifier vos informations personnelles.</p>
                <a href="profile.php" class="btn">Voir le Profil</a>
            </div>
            <div class="card">
    <h2>Déconnexion</h2>
    <p>Se déconnecter de votre compte.</p>
    <a href="../Php/index_app.php?action=logout" class="btn">Déconnexion</a>
</div>

        </div>
    </div>
</body>
</html>
