// Simuler une base de données d'utilisateurs dans le localStorage
const usersDB = JSON.parse(localStorage.getItem('users')) || [];

// Fonction pour sauvegarder les utilisateurs dans le localStorage
function saveUsers(users) {
    localStorage.setItem('users', JSON.stringify(users));
}

// Fonction pour récupérer un utilisateur par email
function getUserByEmail(email) {
    return usersDB.find(user => user.email === email);
}

// Fonction pour ajouter un nouvel utilisateur
function addUser(username, email, password, role) {
    usersDB.push({ username, email, password, role });
    saveUsers(usersDB);
}

// Fonction pour gérer les actions
function handleAction(action) {
    switch (action) {
        case 'register':
            handleRegister();
            break;
        case 'login':
            handleLogin();
            break;
        case 'logout':
            handleLogout();
            break;
        default:
            alert("Action invalide !");
            break;
    }
}

// Gestion de l'inscription
function handleRegister() {
    const registerForm = document.getElementById('registerForm');
    if (!registerForm) return;

    registerForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();
        const role = document.getElementById('role').value;

        if (!username || !email || !password || !role) {
            alert("Tous les champs sont obligatoires.");
            return;
        }

        // Vérifier si l'utilisateur existe déjà
        if (getUserByEmail(email)) {
            alert("Cet email est déjà enregistré. Veuillez vous connecter.");
            return;
        }

        // Ajouter l'utilisateur
        addUser(username, email, password, role);
        alert("Inscription réussie ! Vous pouvez maintenant vous connecter.");
        window.location.href = "../Auth/login.html";
    });
}

// Gestion de la connexion
function handleLogin() {
    const loginForm = document.getElementById('loginForm');
    if (!loginForm) return;

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!email || !password) {
            alert("Tous les champs sont obligatoires.");
            return;
        }

        // Vérifier si l'utilisateur existe
        const user = getUserByEmail(email);
        if (!user || user.password !== password) {
            alert("Identifiants incorrects.");
            return;
        }

        // Stocker les informations de session
        sessionStorage.setItem('user', JSON.stringify(user));
        alert("Connexion réussie !");

        // Rediriger selon le rôle
        switch (user.role) {
            case 'admin':
                window.location.href = "../Admin/admin-dashboard.html";
                break;
            case 'medecin':
                window.location.href = "../Medecin/medecin-dashboard.html";
                break;
            case 'patient':
                window.location.href = "../Patient/patient-dashboard.html";
                break;
            default:
                alert("Rôle inconnu !");
                break;
        }
    });
}

// Gestion de la déconnexion
function handleLogout() {
    // Supprimer les données de session
    sessionStorage.clear();
    alert("Vous êtes déconnecté.");
    window.location.href = "../Auth/login.html";
}

// Identifier l'action à partir des paramètres URL
function getActionFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('action') || 'login';
}

// Exécuter l'action
const action = getActionFromURL();
handleAction(action);
