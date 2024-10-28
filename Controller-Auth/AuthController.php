<?php
require_once "../Model/user.php"; 

class AuthController {
    private $userModel;

    public function __construct($dbConnection) {
        $this->userModel = new UserModel($dbConnection);
    }

    public function login() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            $password = $_POST['password'];
    
            // Check if the user exists in the database
            $user = $this->userModel->getUserByEmail($email);
            if (!$user) {
                // Redirect to login page with error message
                header("Location: ../View/Auth/login.php?error=Aucun compte trouvé pour cet email. Veuillez vous inscrire.");
                exit();
            }
    
            // Verify if the password is correct
            if (password_verify($password, $user['password'])) {
                // Password matches, proceed with session setup
                session_start();
                $_SESSION['user_id'] = $user['id']; 
                $_SESSION['username'] = $user['username'];
                $_SESSION['email'] = $user['email']; 
                $_SESSION['role'] = $user['role'];
    
                // Redirect based on user role
                switch ($user['role']) {
                    case 'admin':
                        header("Location: ../View/Admin/admin-dashboard.php");
                        break;
                    case 'medecin':
                        header("Location: ../View/Medecin/medecin_dashboard.php");
                        break;
                    case 'patient':
                        header("Location: ../View/Patient/patient_dashboard.php");
                        break;
                }
    
                exit();
            } else {
                header("Location: ../View/Auth/login.php?error=Mot de passe incorrect.");
                exit();
            }
        }
    }

    public function register() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $username = $_POST['username'];
            $password = $_POST['password'];
            $email = $_POST['email'];
            $role = $_POST['role'];
    
            // Vérification si le rôle admin est sélectionné mais l'email n'est pas celui autorisé
            if ($role === 'admin' && $email !== 'a.hef2000@gmail.com') {
                // Redirection avec un message d'erreur
                header("Location: ../View/Auth/register.php?error=Vous ne pouvez pas créer un autre compte admin avec cet email.");
                exit();
            }
    
            // Vérifiez si l'email est déjà utilisé
            $existingUser = $this->userModel->getUserByEmail($email);
            if ($existingUser) {
                // Redirection avec un message d'erreur
                header("Location: ../View/Auth/register.php?error=Cet email est déjà enregistré. Veuillez vous connecter.");
                exit();
            }
    
            // Vérifiez que tous les champs sont remplis
            if (empty($username) || empty($password) || empty($email) || empty($role)) {
                header("Location: ../View/Auth/register.php?error=Tous les champs doivent être remplis.");
                exit();
            }
    
            // Enregistrement de l'utilisateur
            //$hashedPassword = password_hash($password, PASSWORD_BCRYPT); // Hasher le mot de passe 
            $this->userModel->register($username, $password, $email, $role);

            // Redirection vers la page de connexion après enregistrement
            header("Location: ../View/Auth/login.php?success=Inscription réussie, veuillez vous connecter.");
            exit();
        } else {
            // Charger la vue d'enregistrement pour une requête GET
            include "../View/Auth/register.php";
        }
    }
    
    public function logout() {
        session_start();
        session_destroy();
        header("Location: ../View/Auth/login.php");
        exit();
    }
}
