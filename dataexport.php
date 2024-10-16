<?php
// Inclure le fichier de connexion à la base de données
require_once 'config/database.php'; 
$conn = connectDB();

if ($conn) {
    // Chemin du fichier CSV exporté
    $csvFile = 'C:/Users/ANASS/Dropbox/PC/Desktop/Questionnaires_Patient.csv'; 

    // Ouvrir le fichier CSV
    if (($handle = fopen($csvFile, 'r')) !== FALSE) {
        // Ignorer la première ligne d'en-tête
        fgetcsv($handle, 1000, ',');

        // Parcourir chaque ligne du fichier CSV
        while (($data = fgetcsv($handle, 1000, ',')) !== FALSE) {
            $email = $data[6]; // Supposons que la colonne email soit à l'index 6
            if (!empty($email)) {
                // Vérifier si l'utilisateur existe déjà dans la base de données
                $checkStmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE email = :email");
                $checkStmt->bindParam(':email', $email);
                $checkStmt->execute();
                $userExists = $checkStmt->fetchColumn();

                if ($userExists == 0) {
                    // Générer un nom d'utilisateur à partir de l'email
                    $username = explode('@', $email)[0];

                    // Générer un mot de passe aléatoire
                    $password = generateRandomPassword(); 
                    $hashed_password = password_hash($password, PASSWORD_BCRYPT); 

                    // Insérer les données dans la table `users` (sans le téléphone)
                    $stmt = $conn->prepare("INSERT INTO users (username, email, role, password) VALUES (:username, :email, 'patient', :password)");
                    $stmt->bindParam(':username', $username);
                    $stmt->bindParam(':email', $email);
                    $stmt->bindParam(':password', $hashed_password);

                    if ($stmt->execute()) {
                        // Afficher le succès d'ajout avec le mot de passe généré
                        echo "Utilisateur $email ajouté avec succès. Le mot de passe généré est $password.<br>";
                    } else {
                        echo "Erreur lors de l'ajout de $email.<br>";
                    }
                } else {
                    echo "Utilisateur avec l'email $email existe déjà. Ignoré.<br>";
                }
            } else {
                echo "Adresse e-mail manquante ou doublon détecté, ligne ignorée.<br>";
            }
        }
        fclose($handle); // Fermer le fichier après traitement
    } else {
        echo "Impossible d'ouvrir le fichier CSV.";
    }
} else {
    echo "Erreur de connexion à la base de données.";
}

// Fonction pour générer un mot de passe aléatoire
function generateRandomPassword($length = 8) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}
?>
