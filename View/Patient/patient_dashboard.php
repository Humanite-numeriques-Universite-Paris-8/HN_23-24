<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <link rel="stylesheet" href="../../css/patient_dashboard.css">
    <style>
        /* General styling for the navbar */
 
    </style>
</head>
<body>

    <!-- Navbar starts here -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>DoctoCabinet</h1> <!-- Replace with your site name -->
        </div>
        <div class="navbar-right">
            <div class="dropdown">
                <button class="dropbtn">Anas HEFIED ▼</button> <!-- User's name -->
                <div class="dropdown-content">
                <a href="../../Php/index_app.php?action=logout">Déconnexion</a>

                </div>
            </div>
        </div>
    </div>
    <!-- Navbar ends here -->

    <!-- Search Section -->
    <div class="search-container">
        <h1>Vivez en meilleure santé</h1>
        <form method="GET" action="search_cabinets.php">
            <input type="text" name="query" placeholder="Nom, spécialité, établissement..." required>
            <input type="text" name="location" placeholder="Où ?" required>
            <button type="submit">Rechercher</button>
        </form>
    </div>

</body>
</html>
