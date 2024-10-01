<?php
function connectDB() {
    $host = 'localhost';
    $db = 'appointment_system';
    $user = 'anas_thyp';
    $pass = 'anashefied';

    try {
        return new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
        die();
    }
}
