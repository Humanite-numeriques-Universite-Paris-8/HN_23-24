import { getUsersFromOmeka, addUserToOmeka } from './database.js';
import AuthController from './AuthController.js'; // Importation de ton contrôleur d'authentification

// Fonction de gestion de l'inscription
async function handleRegister() {
    const registerForm = document.getElementById('registerForm');
    if (!registerForm) return;

    registerForm.addEventListener('submit', async function (e) {
        e.preventDefault();

        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();
        const role = document.getElementById('role').value;

        if (!username || !email || !password || !role) {
            alert("Tous les champs sont obligatoires.");
            return;
        }

        try {
            // Vérifie si l'utilisateur existe déjà dans Omeka
            const users = await getUsersFromOmeka();
            const existingUser = users.find(
                (u) => u["cabinet_medical:email"]?.[0]?.["@value"] === email
            );

            if (existingUser) {
                alert("Cet email est déjà utilisé.");
                return;
            }

            // Ajouter l'utilisateur à Omeka via la fonction addUserToOmeka
            await addUserToOmeka(username, email, password, role);
            alert("Inscription réussie ! Vous pouvez maintenant vous connecter.");
            window.location.href = "../Auth/login.html"; // Redirection vers la page de connexion
        } catch (error) {
            console.error("Erreur lors de l'inscription :", error);
            alert("Erreur lors de l'inscription. Veuillez réessayer.");
        }
    });
}

// Fonction de gestion de la connexion
async function handleLogin() {
    const loginForm = document.getElementById('loginForm');
    const errorMessage = document.getElementById('error-message');
    
    if (!loginForm) return;

    loginForm.addEventListener('submit', async function (e) {
        e.preventDefault(); // Empêcher le comportement par défaut du formulaire

        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!email || !password) {
            errorMessage.innerText = "Tous les champs doivent être remplis.";
            return;
        }

        try {
            // Récupère les utilisateurs depuis Omeka
            const users = await getUsersFromOmeka();
            console.log("Users from Omeka:", users);  // Débogage pour afficher la structure des utilisateurs

            const user = users.find(u => {
                const userEmail = u['cabinet_medical:email']?.[0]?.['@value']?.trim();  // Assurer qu'il n'y a pas d'espaces
                return userEmail === email;
            });

            if (!user) {
                errorMessage.innerText = "Email non trouvé.";
                return;
            }

            // Vérifie le mot de passe
            const userPassword = user['cabinet_medical:password']?.[0]?.['@value']; // Récupère le mot de passe
            if (userPassword !== password) {
                errorMessage.innerText = "Mot de passe incorrect.";
                return;
            }

            // Authentification réussie
            sessionStorage.setItem('user', JSON.stringify(user));
            alert("Connexion réussie !");
            const role = user['cabinet_medical:role']?.[0]?.['@value']; // Récupère le rôle

            // Redirection selon le rôle
            if (role === 'admin') {
                window.location.href = "../Admin/admin-dashboard.html";
            } else if (role === 'medecin') {
                window.location.href = "../Medecin/medecin-dashboard.html";
            } else if (role === 'patient') {
                window.location.href = "../Patient/patient-dashboard.html";
            } else {
                errorMessage.innerText = "Rôle inconnu.";
            }
        } catch (error) {
            console.error("Erreur lors de la connexion:", error);
            errorMessage.innerText = "Une erreur est survenue, veuillez réessayer plus tard.";
        }
    });
}

// Appel des fonctions lors du chargement du DOM
document.addEventListener('DOMContentLoaded', () => {
    handleRegister(); // Appelle la fonction d'inscription
    handleLogin(); // Appelle la fonction de connexion
});
