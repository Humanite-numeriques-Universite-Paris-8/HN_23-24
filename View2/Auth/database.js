const API_URL = 'http://localhost/sites/omeka-s/api';
const KEY_IDENTITY = 'fRlUIv2xrskzSWvNeuTXUyx8E8WEoCBK';
const KEY_CREDENTIAL = 'xUcKJOyZW4F9l4jxYOlENB7WJ7tYABe9';

// database.js
export async function getUsersFromOmeka() {
    try {
        const response = await fetch('http://localhost/sites/omeka-s/api/items?key_identity=fRlUIv2xrskzSWvNeuTXUyx8E8WEoCBK&key_credential=xUcKJOyZW4F9l4jxYOlENB7WJ7tYABe9');
        const data = await response.json();
        return data?.["o:item"] || [];
    } catch (error) {
        console.error("Erreur lors de la récupération des utilisateurs depuis Omeka", error);
        throw error;
    }
}

// Fonction pour récupérer les utilisateurs depuis Omeka
export async function getUsers() {
    try {
        const response = await fetch(`${API_URL}/items?key_identity=${KEY_IDENTITY}&key_credential=${KEY_CREDENTIAL}`);
        if (!response.ok) {
            throw new Error('Erreur de récupération des utilisateurs');
        }
        const data = await response.json();
        return data['o:items']; // Assurez-vous que la structure de la réponse est correcte
    } catch (error) {
        console.error('Erreur dans getUsers:', error);
        throw error;
    }
}

// export async function addUserToOmeka(userData) {
//     const url = `${API_URL}/items?key_identity=${KEY_IDENTITY}&key_credential=${KEY_CREDENTIAL}`;

//     try {
//         const response = await fetch(url, {
//             method: 'POST',
//             headers: { 'Content-Type': 'application/json' },
//             body: JSON.stringify(userData),
//         });

//         if (!response.ok) {
//             const errorText = await response.text();
//             console.error('Erreur lors de la création de l\'utilisateur :', errorText);
//             throw new Error(`Erreur : ${errorText}`);
//         }

//         console.log("Utilisateur créé avec succès :", await response.json());
//     } catch (error) {
//         console.error("Erreur dans addUserToOmeka :", error);
//         throw error;
//     }
// }

// Fonction pour récupérer les utilisateurs depuis Omeka


// Fonction pour ajouter un utilisateur à Omeka
export async function addUserToOmeka(username, email, password, role) {
    try {
        const response = await fetch('http://localhost/sites/omeka-s/api/items?key_identity=fRlUIv2xrskzSWvNeuTXUyx8E8WEoCBK&key_credential=xUcKJOyZW4F9l4jxYOlENB7WJ7tYABe9', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                "@type": "o:Item",
                "o:resource_class": { "o:id": 113 }, // Classe User
                "o:resource_template": { "o:id": 7 }, // Template User
                "cabinet_medical:email": [{ "type": "literal", "property_id": 197, "@value": email }],
                "cabinet_medical:nom_utilisateur": [{ "type": "literal", "property_id": 205, "@value": username }],
                "cabinet_medical:role": [{ "type": "literal", "property_id": 207, "@value": role }],
                "cabinet_medical:password": [{ "type": "literal", "property_id": 206, "@value": password }],
            })
        });
        const data = await response.json();
        return data;
    } catch (error) {
        console.error("Erreur lors de l'ajout de l'utilisateur dans Omeka", error);
        throw error;
    }
}
