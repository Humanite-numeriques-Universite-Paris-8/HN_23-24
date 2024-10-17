<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>

<style>
    /* register.css */

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.register-container {
    width: 100%; /* Ajustez à 100% de la largeur disponible */
    max-width: 400px; /* Limitez la largeur maximale pour ne pas être trop large */
    padding: 30px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

input, select, button {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border-radius: 4px;
    border: 1px solid #ccc;
}

button {
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

.error-message {
    color: red;
    text-align: center;
}

.login-link {
    text-align: center;
}

.login-link a {
    color: #4CAF50;
    text-decoration: none;
}

</style>
</head>
<body>
    <div class="register-container">
        <h2>Inscription</h2>
        <form method="POST" action="../../Controller-Auth/index_app.php?action=register">
            <input type="text" name="username" placeholder="Nom d'utilisateur" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <select name="role">
                <option value="admin">Admin</option>
                <option value="medecin">Médecin</option>
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
