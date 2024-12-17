<?php
require_once '../../config/database.php'; // Assurez-vous que le chemin est correct

// Connexion à la base de données
$conn = connectDB();

// Récupérer la liste des médecins
$query = "
    SELECT DISTINCT m.id AS medecin_id, 
                    m.username AS medecin_name, 
                    m.email AS medecin_email, 
                    m.phone AS medecin_phone
    FROM users m
    LEFT JOIN cabinets c ON m.id = c.docteur_id
    WHERE m.role = 'medecin'";


$stmt = $conn->prepare($query);
$stmt->execute();
$medecins = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Médecins</title>

    <!-- Link to Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
            body {
    font-family: 'Roboto', sans-serif;
    background-image: url('../../images/images1.jpg'); /* Path to your image */
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: flex-start; /* Align the container at the top with space to the bottom */
    min-height: 100vh; /* Make sure the body takes the full height of the viewport */
}

.container {
    width: 100%;
    max-width: 2000px;
    margin:  50px auto; /* Add margin to push the container down and away from the top */
    padding: 20px;
    background-color: white;  /* Reduced margin to move the table higher */
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    position: relative;
    min-height: 30vh; /* Ensures the container has space at the bottom */
}

        h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 8px 12px;
            color: white;
            font-size: 14px;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff;
            margin-right: 8px;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn i {
            margin-right: 6px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        form {
            display: inline-block;
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>Liste des Médecins</h1>

        <?php if (count($medecins) > 0): ?>
            <table>
                <tr>
                    <th>Nom du Médecin</th>
                    <th>Email du Médecin</th>
                    <th>Numéro de Téléphone</th>
                    <th>Actions</th>
                </tr>
                <?php foreach ($medecins as $medecin): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($medecin['medecin_name']); ?></td>
                        <td><?php echo htmlspecialchars($medecin['medecin_email']); ?></td>
                        <td><?php echo htmlspecialchars($medecin['medecin_phone'] ?? 'Non renseigné'); ?></td>
                        <td>
                            <a href="modifier_medecin.php?id=<?php echo $medecin['medecin_id']; ?>" class="btn btn-primary">
                                <i class="fas fa-edit"></i>Modifier
                            </a>
                            <form action="supprimer_medecin.php" method="POST">
                                <input type="hidden" name="medecin_id" value="<?php echo $medecin['medecin_id']; ?>">
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-trash-alt"></i>Supprimer
                                </button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </table>
        <?php else: ?>
            <p>Aucun médecin trouvé.</p>
        <?php endif; ?>
    </div>
</body>
</html>
