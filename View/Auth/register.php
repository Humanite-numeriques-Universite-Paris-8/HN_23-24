<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link rel="stylesheet" href="../css/register.css"> <!-- Lien vers le fichier CSS -->
</head>
<body>
    <div class="register-container">
        <h2>Inscription</h2>
        <form method="POST" action="../../Controller/index_app.php?action=register">
            <input type="text" name="username" placeholder="Nom d'utilisateur" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <select name="role">
                <option value="admin">Admin</option>
                <option value="doctor">Médecin</option>
                <option value="patient">Patient</option>
            </select>

            <button type="submit">S'inscrire</button>
        </form>
        <?php if (isset($_GET['error'])): ?>
    <p class="error"><?php echo htmlspecialchars($_GET['error']); ?></p>
<?php endif; ?>

<?php if (isset($_GET['success'])): ?>
    <p class="success"><?php echo htmlspecialchars($_GET['success']); ?></p>
<?php endif; ?>


        <p class="login-link">Déjà inscrit? 
        <a href="../Auth/login.php">Connectez-vous ici.</a>
        </p>
    </div>
</body>
</html>
