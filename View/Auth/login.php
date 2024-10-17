<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link rel="stylesheet" href="../Auth/css/login.css">
    <style>
        /* Ajoutez des styles simples pour l'erreur et le succès */
        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .success {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Connexion</h2>

        <!-- Affichage des messages d'erreur ou de succès au-dessus du formulaire -->
        <?php if (isset($_GET['error'])): ?>
            <p class="error"><?php echo htmlspecialchars($_GET['error']); ?></p>
        <?php endif; ?>

        <?php if (isset($_GET['success'])): ?>
            <p class="success"><?php echo htmlspecialchars($_GET['success']); ?></p>
        <?php endif; ?>

        <form method="POST" action="../../Controller/index_app.php?action=login">
            <!-- Vérifiez que cette action est correcte -->
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <button type="submit">Connexion</button>
        </form>

        <p class="register-link">Vous n'avez pas de compte? 
            <a href="../Auth/register.php">S'inscrire</a>
        </p>
    </div>
</body>
</html>
