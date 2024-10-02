<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link rel="stylesheet" href="../css/login.css">
</head>
<body>
    <div class="login-container">
        <h2>Connexion</h2>
        <form method="POST" action="../Php/index_app.php?action=login">

            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <button type="submit">Connexion</button>
        </form>

        <?php if (isset($_GET['error'])): ?>
            <p class="error-message"><?php echo $_GET['error']; ?></p>
        <?php endif; ?>

        <p class="register-link">Vous n'avez pas de compte? 
        <a href="../View/register.php">S'inscrire</a>

        </p>
    </div>
</body>
</html>
