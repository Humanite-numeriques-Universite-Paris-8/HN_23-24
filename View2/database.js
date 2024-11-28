// database.js
const API_URL = 'http://localhost/omeka/api';  // L'URL de ton instance Omeka
const HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YOUR_ACCESS_TOKEN' // Remplace par un token d'authentification si nécessaire
};

// Fonction pour récupérer les utilisateurs
export function getUsers() {
    return fetch(`${API_URL}/users`, {
        method: 'GET',
        headers: HEADERS
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            return data.users;
        } else {
            throw new Error('Erreur lors de la récupération des utilisateurs');
        }
    })
    .catch(error => {
        console.error(error);
    });
}

// Fonction pour ajouter un nouvel utilisateur
export function addUser(userData) {
    return fetch(`${API_URL}/users`, {
        method: 'POST',
        headers: HEADERS,
        body: JSON.stringify(userData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            return data.user;
        } else {
            throw new Error('Erreur lors de l\'ajout de l\'utilisateur');
        }
    })
    .catch(error => {
        console.error(error);
    });
}

// Fonction pour mettre à jour un utilisateur
export function updateUser(userId, updatedData) {
    return fetch(`${API_URL}/users/${userId}`, {
        method: 'PUT',
        headers: HEADERS,
        body: JSON.stringify(updatedData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            return data.user;
        } else {
            throw new Error('Erreur lors de la mise à jour de l\'utilisateur');
        }
    })
    .catch(error => {
        console.error(error);
    });
}

// Fonction pour supprimer un utilisateur
export function deleteUser(userId) {
    return fetch(`${API_URL}/users/${userId}`, {
        method: 'DELETE',
        headers: HEADERS
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            return data.message;
        } else {
            throw new Error('Erreur lors de la suppression de l\'utilisateur');
        }
    })
    .catch(error => {
        console.error(error);
    });
}
