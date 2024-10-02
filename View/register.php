<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link rel="stylesheet" href="../css/register.css">
</head>
<body>
    <div class="register-container">
        <h2>Inscription</h2>
        <form method="POST" action="../Php/index_app.php?action=register">

            <input type="text" name="username" placeholder="Nom d'utilisateur" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <select name="role_id">
                <option value="1">Admin</option>
                <option value="2">Patient</option>
            </select>
            <button type="submit">S'inscrire</button>
        </form>

        <?php if (isset($_GET['error'])): ?>
            <p class="error-message"><?php echo $_GET['error']; ?></p>
        <?php endif; ?>

        <p class="login-link">Déjà inscrit? 
        <a href="../View/login.php">Connectez-vous ici.</a>


        </p>
    </div>
</body>
</html>
