// omkApiHelper.js
export class omkApiHelper {
    constructor(params) {
        this.api = params.apiOmk;
        this.ident = params.ident;
        this.key = params.key;
    }

    // Ajouter un nouvel item (cabinet médical, par exemple)
    async addItem(data) {
        
    }

    // Récupérer un item à partir de son URL
    async getItemByUrl(url) {
        try {
            const response = await fetch(url, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            if (!response.ok) {
                throw new Error(`Erreur lors de la récupération de l'item : ${response.statusText}`);
            }

            return response.json();
        } catch (error) {
            console.error(error);
            throw error; // Rethrow the error after logging it
        }
    }

    // Récupérer des items en fonction de l'identifiant de la classe de ressource
    async getItemsByResourceClass(resourceClassId) {
        const url = `${this.api}items?resource_class_id=${resourceClassId}&key_identity=${this.ident}&key_credential=${this.key}`;
        
        try {
            const response = await fetch(url, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            if (!response.ok) {
                throw new Error(`Erreur API: ${response.statusText}`);
            }

            return response.json();
        } catch (error) {
            console.error(error);
            throw error; // Rethrow the error after logging it
        }
    }
    async deleteItem(id) {
        const url = `${this.api}items/${id}?key_identity=${this.ident}&key_credential=${this.key}`;
        try {
            const response = await fetch(url, { method: 'DELETE' });
            
            if (response.ok) {
                console.log(`Item ${id} supprimé avec succès.`);
                return response;
            }
    
            // Gérer les codes 204 ou autres réponses vides
            if (response.status === 204) {
                console.log('Requête DELETE réussie avec un statut 204 No Content.');
                return response;
            }
    
            // Lire la réponse en texte pour diagnostiquer les erreurs
            const errorText = await response.text();
            console.error('Erreur API DELETE :', errorText);
            throw new Error(`Erreur API: ${response.statusText} - ${errorText}`);
        } catch (error) {
            console.error('Erreur lors de la suppression:', error.message);
            throw error;
        }
    }
    // Récupérer un item par son ID
    async getItem(id) {
        const url = `${this.api}items/${id}?key_identity=${this.ident}&key_credential=${this.key}`;
        
        try {
            const response = await fetch(url, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            if (!response.ok) {
                throw new Error(`Erreur API: ${response.statusText}`);
            }

            return response.json();
        } catch (error) {
            console.error(error);
            throw error; // Rethrow the error after logging it
        }
    }

    

 
}
