import { getUsersFromOmeka, addUserToOmeka } from './database.js';

const AuthController = {
    // Gestion de la connexion
    login: async function (email, password) {
        try {
            // Récupérer les utilisateurs depuis la table utilisateur (par exemple dans Omeka)
            const users = await getUsersFromOmeka(); // Cette fonction interroge ta base de données
            console.log("Utilisateurs récupérés :", users);  // Pour déboguer

            // Recherche de l'utilisateur par email dans la base
            const user = users.find(u => u["utilisateur:email"]?.[0]?.["@value"] === email); // Assure-toi de l'ID du champ email

            if (!user) {
                return { success: false, message: "Identifiant incorrect" };
            }

            // Vérification du mot de passe
            const storedPassword = user["utilisateur:mot_de_passe"]?.[0]?.["@value"]; // Vérifie que c'est le bon champ
            if (storedPassword !== password) {
                return { success: false, message: "Mot de passe incorrect" };
            }

            // Récupérer le rôle de l'utilisateur depuis la table `utilisateur`
            const role = user["utilisateur:role"]?.[0]?.["@value"];
            return { success: true, user: user, role: role };

        } catch (error) {
            console.error("Erreur lors de la connexion :", error);
            return { success: false, message: "Une erreur est survenue, veuillez réessayer." };
        }
    },


    // Gestion de l'inscription
    register: async function (username, email, password, role) {
        try {
            const userData = {
                "@type": "o:Item",
                "o:resource_class": { "o:id": 113 },
                "o:resource_template": { "o:id": 7 },
                "o:properties": {
                    "197": [{ "type": "literal", "@value": email }], // Email
                    "205": [{ "type": "literal", "@value": username }], // Nom d'utilisateur
                    "207": [{ "type": "literal", "@value": role }], // Rôle
                    "206": [{ "type": "literal", "@value": password }], // Mot de passe
                },
            };

            await addUserToOmeka(userData); // Enregistrement de l'utilisateur dans Omeka
            return { success: true, message: "Inscription réussie." };
        } catch (error) {
            console.error("Erreur lors de l'inscription :", error);
            return { success: false, message: "Erreur lors de l'inscription." };
        }
    },
};

export default AuthController;
