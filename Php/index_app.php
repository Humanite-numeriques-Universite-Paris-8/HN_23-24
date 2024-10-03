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
} elseif ($action === 'add_cabinet') {
    // Logic for managing cabinet addition
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $cabinetName = $_POST['cabinet_name'];
        $adresse = $_POST['adresse'];
        $ville = $_POST['ville'];
        $doctor_id = $_POST['doctor_id'];

        // Insert into the database
        $stmt = $conn->prepare("INSERT INTO cabinets (cabinet_name, adresse, ville, doctor_id) VALUES (?, ?, ?, ?)");
        $stmt->execute([$cabinetName, $adresse, $ville, $doctor_id]);

        // Redirect after successful insertion
        header("Location: /Projet1_Thyp_Ahef/View/Admin/admin-lists/admin-list.php?action=list_cabinets");
        exit();
    }
} else {
    echo "Invalid action";
}


?>
