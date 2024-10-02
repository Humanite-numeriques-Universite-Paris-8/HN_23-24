<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Cabinet</title>
    <link rel="stylesheet" href="../../css/admin_dashboard.css">
</head>
<body>

    <!-- Form to Add a New Cabinet -->
    <div class="form-container">
        <h1>Ajouter un Cabinet</h1>
        <form method="POST" action="../Php/index_app.php?action=add_cabinet">
            <label for="cabinet_name">Nom du Cabinet:</label>
            <input type="text" id="cabinet_name" name="cabinet_name" required>

            <label for="adresse">Adresse:</label>
            <input type="text" id="adresse" name="adresse" required>

            <label for="doctor_name">Nom du Docteur:</label>
            <input type="text" id="doctor_name" name="doctor_name" required>

            <button type="submit">Ajouter Cabinet</button>
        </form>
    </div>

</body>
</html>
