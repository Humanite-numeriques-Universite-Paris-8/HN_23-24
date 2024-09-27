<?php
header('Content-Type: application/json');

$response = [];
$input = file_get_contents('php://input');
$data = json_decode($input, true);


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


file_put_contents('php://stderr', print_r($data, true));

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (json_last_error() !== JSON_ERROR_NONE) {
        $response['success'] = false;
        $response['message'] = "Invalid JSON format.";
    } else {
        $name = htmlspecialchars($data['name'] ?? '');
        $email = htmlspecialchars($data['email'] ?? '');
        $message = htmlspecialchars($data['message'] ?? '');

        if (!empty($name) && !empty($email) && !empty($message)) {
            $response['success'] = true;
            $response['message'] = "Thank you, $name! Your message has been received.";
            $response['formLink'] = "https://docs.google.com/forms/d/e/1FAIpQLScAyvTcCYkgsl9wE7qn8zPrgPHWa_T0RlJ_0_GNr25O6bkn8w/viewform?usp=sf_link";
        } else {
            $response['success'] = false;
            $response['message'] = "Please fill out all fields.";
        }
    }
} else {
    $response['success'] = false;
    $response['message'] = "No data received !";
}

echo json_encode($response);
?>
