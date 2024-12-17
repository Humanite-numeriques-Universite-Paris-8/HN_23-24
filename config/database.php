<?php
function connectDB() {
    $host = 'localhost';
    $db = 'appointment_system'; // Update this with your actual database name
    $user = 'anas_thyp'; // Update this with your actual username
    $pass = 'anashefied'; // Update this with your actual password

    try {
        $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $conn;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
        return null;
    }
}
