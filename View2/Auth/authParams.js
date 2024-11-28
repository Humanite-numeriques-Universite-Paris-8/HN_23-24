// authParams.js

const API_URL = 'http://localhost/sites/omeka-s/api';
const LOGIN_ENDPOINT = '/login';
const REGISTER_ENDPOINT = '/register';

// Clés d'authentification
const KEY_IDENTITY = 'Nh2muclMwYy2RfkhsB20gXNrFowmmcr3';
const KEY_CREDENTIAL = 'M9A0hM93t7Ju4Vs8dYmJCLlEoXeIYqen';

const authHeaders = {
    'Content-Type': 'application/json'
};

// Exporter les clés et l'API URL pour réutilisation
export { API_URL, LOGIN_ENDPOINT, REGISTER_ENDPOINT, KEY_IDENTITY, KEY_CREDENTIAL, authHeaders };
