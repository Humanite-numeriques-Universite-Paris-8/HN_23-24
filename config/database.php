<?php
function connectDB() {
    $host = 'localhost';
    $db = 'appointment_system';
    $user = 'anas_thyp';
    $pass = 'anashefied';

    try {
        // Connexion via PDO
        $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
        // Définir le mode d'erreur PDO pour afficher les exceptions
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $conn;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
        return null;
    }
}
