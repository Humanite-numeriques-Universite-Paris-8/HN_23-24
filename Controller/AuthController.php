<?php
require_once "../Model/user.php"; // Ensure this path is correct

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
                header("Location: ../View/login.php?error=Aucun compte trouvé pour cet email. Veuillez vous inscrire.");
                exit();
            }

            // Verify if the password is correct
            if (password_verify($password, $user['password'])) {
                session_start();
                $_SESSION['user'] = $user;

                // Check user role and redirect accordingly
                switch ($user['role']) {
                    case 'admin':
                        header("Location: ../View/Admin/admin_dashboard.html");

                        break;
                    case 'doctor':
                        header("Location: ../View/Doctor/doctor_dashboard.html");
                        break;
                    case 'patient':
                        header("Location: ../View/Patient/patient_dashboard.html");
                        break;
                }
                exit();
            } else {
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
            $role = $_POST['role']; // This should be 'role', not 'role_id'
    
            // Check if the user already exists
            $existingUser = $this->userModel->getUserByEmail($email);
            if ($existingUser) {
                // Redirect with error message if the email is already used
                header("Location: ../View/register.php?error=Cet email est déjà enregistré. Veuillez vous connecter.");
                exit();
            }
    
            // Register the user with the role
            if ($this->userModel->register($username, $password, $email, $role)) {
                header("Location: ../View/login.php?success=Inscription réussie. Veuillez vous connecter.");
                exit();
            } else {
                header("Location: ../View/register.php?error=Erreur lors de l'inscription. Veuillez réessayer.");
                exit();
            }
        } else {
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
?>
