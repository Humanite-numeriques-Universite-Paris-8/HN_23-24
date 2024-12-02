<?php
// Inclure les configurations nécessaires
require_once '../../config/database.php'; // Connexion à la base de données
require_once '../../config/omeka_api.php'; // URL et clés de l'API Omeka

$conn = connectDB();

// Fonction pour récupérer les items depuis Omeka S
function getOmekaItems() {
    $url = OMEKA_API_BASE_URL . "items?key_identity=" . OMEKA_API_KEY_IDENTITY . "&key_credential=" . OMEKA_API_KEY_CREDENTIAL;
    $response = file_get_contents($url);

    if ($response === FALSE) {
        die("Erreur lors de la connexion à l'API Omeka S.");
    }

    return json_decode($response, true);
}

// Fonction pour normaliser un email
function normalizeEmail($email) {
    return strtolower(trim($email));
}

// Fonction pour ajouter ou mettre à jour les patients dans la base de données
function importOrUpdatePatients($conn, $items) {
    $addedCount = 0;
    $updatedCount = 0;

    foreach ($items as $item) {
        // Vérifier si l'item appartient à la classe "cabinet_medical:Patient"
        if (isset($item['@type']) && in_array("cabinet_medical:Patient", $item['@type'])) {
            $email = isset($item['cabinet_medical:mail'][0]['@value']) ? normalizeEmail($item['cabinet_medical:mail'][0]['@value']) : null;
            $username = isset($item['cabinet_medical:username'][0]['@value']) ? $item['cabinet_medical:username'][0]['@value'] : 'Non renseigné';
            $phone = isset($item['cabinet_medical:phone'][0]['@value']) ? $item['cabinet_medical:phone'][0]['@value'] : null;

            if ($email) {
                // Rechercher l'utilisateur dans la base de données par email
                $checkStmt = $conn->prepare("SELECT id FROM users WHERE email = :email");
                $checkStmt->bindParam(':email', $email);
                $checkStmt->execute();
                $existingUser = $checkStmt->fetch(PDO::FETCH_ASSOC);

                if ($existingUser) {
                    // Mettre à jour les informations de l'utilisateur
                    $updateStmt = $conn->prepare("UPDATE users SET username = :username, phone = :phone WHERE id = :id");
                    $updateStmt->bindParam(':username', $username);
                    $updateStmt->bindParam(':phone', $phone);
                    $updateStmt->bindParam(':id', $existingUser['id']);

                    if ($updateStmt->execute()) {
                        echo "Utilisateur mis à jour : {$email}<br>";
                        $updatedCount++;
                    }
                } else {
                    // Ajouter un nouvel utilisateur
                    $password = password_hash(generateRandomPassword(), PASSWORD_BCRYPT);
                    $insertStmt = $conn->prepare("INSERT INTO users (username, email, phone, role, password) VALUES (:username, :email, :phone, 'patient', :password)");
                    $insertStmt->bindParam(':username', $username);
                    $insertStmt->bindParam(':email', $email);
                    $insertStmt->bindParam(':phone', $phone);
                    $insertStmt->bindParam(':password', $password);

                    if ($insertStmt->execute()) {
                        echo "Nouvel utilisateur ajouté : {$email}<br>";
                        $addedCount++;
                    }
                }
            }
        }
    }

    return ["added" => $addedCount, "updated" => $updatedCount];
}

// Générer un mot de passe aléatoire
function generateRandomPassword($length = 8) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomPassword = '';
    for ($i = 0; $i < $length; $i++) {
        $randomPassword .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomPassword;
}

// Récupérer les items depuis Omeka S
$items = getOmekaItems();

// Importer ou mettre à jour les patients dans la base de données locale
$result = importOrUpdatePatients($conn, $items);

// Résultat de l'importation
echo "Importation terminée : " . $result['added'] . " patients ajoutés, " . $result['updated'] . " patients mis à jour.";
?>
