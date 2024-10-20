<?php
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

// Handle cabinet deletion requests
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];
    
    // Delete the cabinet only (without affecting doctors)
    $delete_query = "DELETE FROM cabinets WHERE id = :cabinet_id";
    $delete_stmt = $conn->prepare($delete_query);
    $delete_stmt->bindParam(':cabinet_id', $delete_id);

    if ($delete_stmt->execute()) {
        header("Location: voir_cabinets.php?success=Cabinet supprimé avec succès.");
        exit();
    } else {
        header("Location: voir_cabinets.php?error=Erreur lors de la suppression du cabinet.");
        exit();
    }
}

// Query to get all cabinets with their associated doctor info
$query = "SELECT cabinets.id, cabinets.nom AS cabinet_nom, cabinets.adresse, cabinets.specialite, users.username AS docteur_nom
          FROM cabinets
          LEFT JOIN users ON cabinets.docteur_id = users.id"; // LEFT JOIN ensures no issues when a doctor is missing

$result = $conn->query($query);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <h1 style="color: white" class="title">Liste des Cabinets</h1>
    
    <!-- Link to Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- Link to your custom CSS -->
    <link rel="stylesheet" href="../Admin/css/lister_cabinet.css">
    
    <style>
        /* Balanced, modern table styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background-image: url('../../images/images1.jpg'); /* Add your image path here */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            box-sizing: border-box;
        }

        /* Container for the table */
        .container {
            width: 90%;
            margin: 40px auto;
            background-color: rgba(255, 255, 255, 0.9); /* Light transparent background */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .cabinet-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            color: #444;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.15);
            border-radius: 8px;
            overflow: hidden;
        }
        .cabinet-table th, .cabinet-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cabinet-table th {
            background-color: #4F87A3FF;
            color: #fff;
            text-transform: uppercase;
            font-size: 18px;
        }
        .cabinet-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .cabinet-table tr:hover {
            background-color:  #43B0D8FF; /* Soft hover effect */
        }

        /* Success and error messages */
        .success {
            color: #4caf50;
            margin-bottom: 20px;
        }
        .error {
            color: #f44336;
            margin-bottom: 20px;
        }

        /* Button styling */
        .action-link {
            padding: 8px 12px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .modify {
            background-color: #4caf50; /* Green */
            margin-right: 10px;
        }
        .delete {
            background-color: #f44336; /* Red */
        }
        .action-link:hover {
            opacity: 0.9;
        }
        .action-link i {
            margin-right: 5px;
        }

        /* Improve overall typography */
        p {
            font-size: 16px;
            line-height: 1.5;
            color: #fff;
        }

        .title {
        font-family: 'Arial', sans-serif;
        font-size: 28px;
        font-weight: bold;
        color: #333;
        text-align: center;
        padding: 20px 0;
        margin-bottom: 20px;
        border-bottom: 2px solid #e0e0e0;
        letter-spacing: 1px;
    }
        /* Responsive for mobile */
        @media (max-width: 768px) {
            .cabinet-table th, .cabinet-table td {
                padding: 12px;
                font-size: 14px;
            }
            .action-link {
                padding: 8px 10px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<?php
// Display success or error messages
if (isset($_GET['success'])) {
    echo "<p class='success'>" . htmlspecialchars($_GET['success']) . "</p>";
} elseif (isset($_GET['error'])) {
    echo "<p class='error'>" . htmlspecialchars($_GET['error']) . "</p>";
}

if ($result->rowCount() > 0) {
    echo "<table class='cabinet-table'>";
    echo "<tr><th>Nom du Cabinet</th><th>Adresse</th><th>Spécialité</th><th>Docteur</th><th>Actions</th></tr>";
    
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['cabinet_nom']) . "</td>";
        echo "<td>" . htmlspecialchars($row['adresse']) . "</td>";
        echo "<td>" . (!is_null($row['specialite']) ? htmlspecialchars($row['specialite']) : 'Non spécifié') . "</td>";
        echo "<td>" . htmlspecialchars($row['docteur_nom'] ?? 'Non défini') . "</td>";
        echo "<td>
              <a href='../Admin/modifier_cabinet.php?id=" . $row['id'] . "' class='action-link modify'><i class='fas fa-edit'></i>Modifier</a>
              <a href='?delete_id=" . $row['id'] . "' class='action-link delete' onclick=\"return confirm('Êtes-vous sûr de vouloir supprimer ce cabinet?');\"><i class='fas fa-trash'></i>Supprimer</a>
              </td>";
        echo "</tr>";
    }
    
    echo "</table>";
} else {
    echo "<p>Aucun cabinet trouvé.</p>";
}
?>

</body>
</html>
