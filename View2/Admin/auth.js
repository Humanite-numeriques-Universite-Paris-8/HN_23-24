// auth.js
export class auth {
    constructor(authParams) {
        this.apiUrl = authParams.apiUrl;
        this.key_identity = authParams.key_identity;
        this.key_credential = authParams.key_credential;
    }

    // Fonction pour créer un item
    async createItem(data, callback) {
        const url = `${this.apiUrl}items?key_identity=${this.key_identity}&key_credential=${this.key_credential}`;
        
        const options = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        };

        try {
            const response = await fetch(url, options);
            if (response.ok) {
                const result = await response.json();
                callback(result); // Exécution du callback après la création de l'item
            } else {
                console.error('Erreur lors de la création de l\'item:', await response.text());
            }
        } catch (error) {
            console.error('Erreur de requête API:', error);
        }
    }
}
