// Simuler une base de données d'utilisateurs
const usersDB = JSON.parse(localStorage.getItem('users')) || [];

// Fonction pour sauvegarder les utilisateurs dans le localStorage
function saveUsers(users) {
    localStorage.setItem('users', JSON.stringify(users));
}

// Fonction pour récupérer un utilisateur par email
function getUserByEmail(email) {
    return usersDB.find(user => user.email === email);
}

// Fonction pour enregistrer un nouvel utilisateur
function registerUser(username, email, password, role) {
    usersDB.push({ username, email, password, role });
    saveUsers(usersDB);
}

// Contrôleur pour la gestion des utilisateurs
const AuthController = {
    login: function (email, password) {
        // Vérifier si l'utilisateur existe
        const user = getUserByEmail(email);
        if (!user) {
            return { success: false, message: "Aucun compte trouvé pour cet email. Veuillez vous inscrire." };
        }

        // Vérifier le mot de passe
        if (user.password !== password) {
            return { success: false, message: "Mot de passe incorrect." };
        }

        // Définir les données de session
        sessionStorage.setItem('user', JSON.stringify(user));
        return { success: true, role: user.role };
    },

    register: function (username, email, password, role) {
        // Vérification si le rôle admin est sélectionné mais l'email n'est pas autorisé
        if (role === 'admin' && email !== 'a.hef2000@gmail.com') {
            return { success: false, message: "Vous ne pouvez pas créer un autre compte admin avec cet email." };
        }

        // Vérifiez si l'email est déjà utilisé
        const existingUser = getUserByEmail(email);
        if (existingUser) {
            return { success: false, message: "Cet email est déjà enregistré. Veuillez vous connecter." };
        }

        // Vérifiez que tous les champs sont remplis
        if (!username || !email || !password || !role) {
            return { success: false, message: "Tous les champs doivent être remplis." };
        }

        // Enregistrer le nouvel utilisateur
        registerUser(username, email, password, role);
        return { success: true, message: "Inscription réussie, veuillez vous connecter." };
    },

    logout: function () {
        sessionStorage.clear();
        window.location.href = "../Auth/login.html";
    }
};

// Gestion du formulaire de connexion
if (document.getElementById('loginForm')) {
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();
        const errorMessage = document.getElementById('errorMessage');

        const result = AuthController.login(email, password);
        if (!result.success) {
            errorMessage.textContent = result.message;
            errorMessage.style.display = 'block';
            return;
        }

        // Rediriger en fonction du rôle
        errorMessage.style.display = 'none';
        if (result.role === "patient") {
            window.location.href = "../Patient/patient-dashboard.html";
        } else if (result.role === "medecin") {
            window.location.href = "../Medecin/medecin-dashboard.html";
        } else if (result.role === "admin") {
            window.location.href = "../Admin/admin-dashboard.html";
        }
    });
}

// Gestion du formulaire d'inscription
if (document.getElementById('registerForm')) {
    document.getElementById('registerForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();
        const role = document.getElementById('role').value;
        const message = document.getElementById('message');

        const result = AuthController.register(username, email, password, role);
        if (!result.success) {
            message.textContent = result.message;
            message.style.display = "block";
            return;
        }

        // Succès, rediriger vers la page de connexion
        message.style.color = "green";
        message.textContent = result.message;
        message.style.display = "block";

        setTimeout(() => {
            window.location.href = "../Auth/login.html";
        }, 2000);
    });
}

// Gestion de la déconnexion
if (document.getElementById('logoutButton')) {
    document.getElementById('logoutButton').addEventListener('click', function () {
        AuthController.logout();
    });
}
