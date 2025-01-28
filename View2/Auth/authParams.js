// authParams.js

const API_URL = 'http://localhost/sites/omeka-s/api';
const LOGIN_ENDPOINT = '/login';
const REGISTER_ENDPOINT = '/register';

// Clés d'authentification
const KEY_IDENTITY = 'fRlUIv2xrskzSWvNeuTXUyx8E8WEoCBK';
const KEY_CREDENTIAL = 'xUcKJOyZW4F9l4jxYOlENB7WJ7tYABe9';

const authHeaders = {
    'Content-Type': 'application/json',
};

// Exporter les clés et l'API URL pour réutilisation
export { API_URL, LOGIN_ENDPOINT, REGISTER_ENDPOINT, KEY_IDENTITY, KEY_CREDENTIAL, authHeaders };
