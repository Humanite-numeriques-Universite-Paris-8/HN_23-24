<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "../config/database.php";
require_once "../Controller/AuthController.php";

// Connect to the database
$conn = connectDB();

$action = isset($_GET['action']) ? $_GET['action'] : 'login';

$authController = new AuthController($conn);

if ($action === 'register') {
    $authController->register();
} elseif ($action === 'login') {
    $authController->login();
} elseif ($action === 'logout') {
    $authController->logout();
} 
else {
    echo "Invalid action";
}
       // Redirect after successful insertion
     
       exit();

    

 
?>
