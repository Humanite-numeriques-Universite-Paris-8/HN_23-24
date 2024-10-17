<?php
class UserModel {
    private $dbConnection;

    public function __construct($dbConnection) {
        $this->dbConnection = $dbConnection;
    }
    public function register($username, $password, $email, $role) {
     
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT); 
    
  
        $stmt = $this->dbConnection->prepare("INSERT INTO users (username, password, email, role) VALUES (:username, :password, :email, :role)");
    
    
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':role', $role);  // Ensure this binds 'role' and not 'role_id'
    
        // Execute the query
        #hena exedcuter la requete
        if ($stmt->execute()) {
            return true;
        } else {
            print_r($stmt->errorInfo());
            return false;
        }
    }
    
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
?>
