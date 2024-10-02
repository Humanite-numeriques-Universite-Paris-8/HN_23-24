<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
echo "Index App Loaded";

require_once "../config/database.php";
require_once "../Controller/AuthController.php";

// Routing logic
$action = isset($_GET['action']) ? $_GET['action'] : 'login';

$authController = new AuthController(connectDB());

if ($action === 'register') {
    $authController->register();
} elseif ($action === 'login') {
    $authController->login();
} elseif ($action === 'logout') {
    $authController->logout();
} else {
    echo "Invalid action";
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['action']) && $_GET['action'] === 'add_cabinet') {
    $cabinetName = isset($_POST['cabinet_name']) ? $_POST['cabinet_name'] : '';
    $adresse = isset($_POST['adresse']) ? $_POST['adresse'] : '';
    $ville = isset($_POST['ville']) ? $_POST['ville'] : '';
    $doctorName = isset($_POST['doctor_name']) ? $_POST['doctor_name'] : '';
    $appointmentDates = isset($_POST['appointment_dates']) ? $_POST['appointment_dates'] : [];

    if (!$cabinetName || !$adresse || !$ville || !$doctorName || !$appointmentDates) {
        echo "Please fill in all required fields.";
        exit;
    }

    // Connect to the database and insert the cabinet information
    $conn = connectDB();
    $sql = "INSERT INTO cabinets (cabinet_name, adresse, ville, doctor_name, appointment_dates) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    
    // Utilisez bindValue ou passez directement les valeurs dans execute
    $stmt->execute([$cabinetName, $adresse, $ville, $doctorName, json_encode($appointmentDates)]);
    

    
    // Redirect after successful addition
    header("Location: /Projet1_Thyp_Ahef/View/Admin/admin-lists/admin-list.php");
    exit();

}


?>
