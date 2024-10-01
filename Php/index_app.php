<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "../config/database.php";
require_once "../Controller/AuthController.php";

// Routing logic
$action = isset($_GET['action']) ? $_GET['action'] : 'login';

// Supprimez ou commentez les lignes de test
// echo "Action requested: " . $action . "<br>";

$authController = new AuthController(connectDB());

if ($action === 'register') {
    // echo "Register page";
    $authController->register();
} elseif ($action === 'login') {
    // echo "Login page";
    $authController->login();
} elseif ($action === 'logout') {
    // echo "Logout";
    $authController->logout();
} else {
    echo "Invalid action";
}
?>
