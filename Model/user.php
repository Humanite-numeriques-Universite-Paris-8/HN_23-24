<?php
class UserModel {
    private $dbConnection;

    public function __construct($dbConnection) {
        $this->dbConnection = $dbConnection;
    }

    public function register($username, $password, $email, $role_id) {
        // Hacher le mot de passe avant de l'enregistrer
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
        
        // Préparer la requête d'insertion
        $stmt = $this->dbConnection->prepare("INSERT INTO users (username, password, email, role_id) VALUES (:username, :password, :email, :role_id)");
        
        // Lier les paramètres à la requête
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':role_id', $role_id, PDO::PARAM_INT);
        
        // Exécuter la requête
        if ($stmt->execute()) {
            return true;
        } else {
            // Gérer les erreurs potentielles
            print_r($stmt->errorInfo());
            return false;
        }
    }
    

    // Add the getUserByUsername method here
    public function getUserByUsername($username) {
        $stmt = $this->dbConnection->prepare("SELECT * FROM users WHERE username = :username LIMIT 1");
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getUserByEmail($email) {
        $stmt = $this->dbConnection->prepare("SELECT * FROM users WHERE email = :email LIMIT 1");
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getUserById($id) {
        $stmt = $this->dbConnection->prepare("SELECT * FROM users WHERE id = :id LIMIT 1");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}