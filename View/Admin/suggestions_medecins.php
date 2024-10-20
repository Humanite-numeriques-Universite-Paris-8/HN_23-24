<?php
require_once '../../config/database.php'; // Ensure the path is correct

$conn = connectDB();

// Retrieve the search term from the GET request
$search_term = isset($_GET['search_term']) ? $_GET['search_term'] : '';

if (!empty($search_term)) {
    // Query for doctors or specialties matching the search term
    $query = "SELECT c.specialite, u.username AS docteur_name
              FROM cabinets c
              JOIN users u ON c.docteur_id = u.id
              WHERE c.specialite LIKE :search_term OR u.username LIKE :search_term";
    $stmt = $conn->prepare($query);
    $search_term = "%" . $search_term . "%";
    $stmt->bindParam(':search_term', $search_term);
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (!empty($results)) {
        foreach ($results as $result) {
            echo "<div onclick=\"selectSuggestion('" . htmlspecialchars($result['specialite'] . ' - ' . $result['docteur_name']) . "')\">" . htmlspecialchars($result['specialite'] . ' - ' . $result['docteur_name']) . "</div>";
        }
    } else {
        echo "<div>Aucun résultat trouvé</div>";
    }
}
?>
