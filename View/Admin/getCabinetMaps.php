<?php
header('Content-Type: application/json');

// URL de l'API Nominatim pour rechercher des cabinets médicaux à Paris
$url = "https://nominatim.openstreetmap.org/search?format=json&q=cabinet+medical+Paris&addressdetails=1&limit=1000";

// Initialisation de cURL pour faire la requête
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_USERAGENT, "MonApplication/1.0 (a.hef2000@gmail.com)");

// Exécute la requête et vérifie les erreurs cURL
$response = curl_exec($ch);
if (curl_errno($ch)) {
    echo json_encode(['error' => 'Erreur lors de la récupération des données']);
    curl_close($ch);
    exit;
}
curl_close($ch);

// Décoder la réponse JSON
$data = json_decode($response, true);

// Extraire uniquement les adresses
$addresses = [];
if (is_array($data) && !empty($data)) {
    foreach ($data as $place) {
        $addresses[] = $place['display_name'];
    }
}

// Retourner les adresses en JSON
echo json_encode($addresses);
