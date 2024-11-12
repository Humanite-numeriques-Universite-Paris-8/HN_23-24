export class omkApiHelper {
    constructor(params) {
        this.api = params.apiOmk;
        this.ident = params.ident;
        this.key = params.key;
    }

    // Méthode pour obtenir tous les items
    async getItems() {
        const url = `${this.api}items?key_identity=${this.ident}&key_credential=${this.key}`;
        const response = await fetch(url);
        if (!response.ok) throw new Error(`Erreur lors de la récupération des items: ${await response.text()}`);
        const items = await response.json();
        return items.map(item => ({
            id: item['o:id'],
            email: item['cabinet_medical:mail'] ? item['cabinet_medical:mail'][0]['@value'] : 'N/A',
            username: item['cabinet_medical:username'] ? item['cabinet_medical:username'][0]['@value'] : 'N/A',
            role: item['cabinet_medical:role'] ? item['cabinet_medical:role'][0]['@value'] : 'N/A'
        }));
    }

    // Méthode pour mettre à jour un item
    async updateItem(id, data) {
        const url = `${this.api}items/${id}?key_identity=${this.ident}&key_credential=${this.key}`;
        const itemData = {
            "@type": "o:Item",
            "o:resource_class": { "o:id": 110 }, // Remplacez 110 par l'ID correct de la classe "Patient"
            "cabinet_medical:mail": [{ "type": "literal", "property_id": 197, "@value": data.email }],
            "cabinet_medical:username": [{ "type": "literal", "property_id": 205, "@value": data.username }],
            "cabinet_medical:role": [{ "type": "literal", "property_id": 207, "@value": data.role }]
        };
        
        const response = await fetch(url, {
            method: 'PUT', // ou 'PATCH' si c'est autorisé
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(itemData)
        });
    
        if (!response.ok) {
            const errorText = await response.text(); // Pour obtenir des détails sur l'erreur
            throw new Error(`Erreur lors de la mise à jour de l'item: ${errorText}`);
        }
    
        return response.json();
    }
    
    

    // Méthode pour supprimer un item
    async deleteItem(id) {
        const url = `${this.api}items/${id}?key_identity=${this.ident}&key_credential=${this.key}`;
        const response = await fetch(url, {
            method: 'DELETE', // Utiliser POST comme alternative
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ _method: 'DELETE' }) // Envoyer la méthode DELETE dans le corps de la requête
        });
    
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Erreur lors de la suppression de l'item: ${errorText}`);
        }
    
        return response.ok;
    }
    
    
}
