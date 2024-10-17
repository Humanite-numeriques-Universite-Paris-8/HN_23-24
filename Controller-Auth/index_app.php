<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "../config/database.php";
require_once "../Controller-Auth/AuthController.php"; // Ensure this path is correct

// Connect to the database
$conn = connectDB();

// Set action based on the query parameter
$action = isset($_GET['action']) ? $_GET['action'] : 'login';

$authController = new AuthController($conn); // Ensure AuthController is correctly set up

// Handle the different actions
switch ($action) {
    case 'register':
        $authController->register(); 
        break;
    case 'login':
        $authController->login();
        break;
    case 'logout':
        $authController->logout();
        break;
    default:
        echo "Action invalide";
        break;
}

exit();
?>
