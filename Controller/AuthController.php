<?php
require_once "../Model/user.php";

class AuthController {
    private $userModel;

    public function __construct($dbConnection) {
        $this->userModel = new UserModel($dbConnection);
    
        // Supprimez ces lignes de débogage
        // echo "Testing database connection.<br>";
    
        $stmt = $dbConnection->query("SELECT * FROM users");
        $users = $stmt->fetchAll();
        if ($users) {
            // echo "Database connection successful. Users found: " . count($users) . "<br>";
        } else {
            // echo "No users found in the database.<br>";
        }
    }
    

    public function login() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            $password = $_POST['password'];
    
            // Vérifiez si l'utilisateur existe dans la base de données
            $user = $this->userModel->getUserByEmail($email);
            if (!$user) {
                // Redirigez vers la page de login avec un message d'erreur
                header("Location: ../View/login.php?error=Aucun compte trouvé pour cet email. Veuillez vous inscrire.");
                exit();
            }
    
            // Vérifiez si le mot de passe est correct
            if (password_verify($password, $user['password'])) {
                session_start();
                $_SESSION['user'] = $user;
    
                // Vérifiez le rôle de l'utilisateur et redirigez en fonction
                if ($user['role_id'] == 1) {  // Admin role
                    header("Location: ../View/Admin/admin_dashboard.php");
                    exit();
                } elseif ($user['role_id'] == 2) {  // Patient role
                    header("Location: ../View/Patient/patient_dashboard.php");
                    exit();
                }
            } else {
                // Redirigez avec un message d'erreur si le mot de passe est incorrect
                header("Location: ../View/login.php?error=Mot de passe incorrect.");
                exit();
            }
        }
    }
    
    
    
    
    public function register() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $username = $_POST['username'];
            $email = $_POST['email'];
            $password = $_POST['password'];
            $role_id = $_POST['role_id'];
    
            // Vérifiez si l'utilisateur existe déjà
            $existingUser = $this->userModel->getUserByEmail($email);
            if ($existingUser) {
                // Redirigez avec un message d'erreur si l'email est déjà utilisé
                header("Location: ../View/register.php?error=Cet email est déjà enregistré. Veuillez vous connecter.");
                exit();
            }
    
            // Vérifiez si l'admin essaie de s'inscrire en tant que patient
            if ($email === 'a.hef2000@gmail.com' && $role_id == 2) {
                header("Location: ../View/register.php?error=L'administrateur ne peut pas être patient.");
                exit();
            }
    
            // Inscription réussie
            $this->userModel->register($username, $password, $email, $role_id);
            header("Location: ../View/login.php?success=Inscription réussie. Veuillez vous connecter.");
            exit();
        } else {
            // Afficher la page d'inscription
            include "../View/register.php";
        }
    }
    
    
    
    
    

    
    

    public function logout() {
        session_start();
        session_destroy();
        header("Location: ../View/login.php"); // Ensure the path to login.php is correct
        exit();
    }
    
}
