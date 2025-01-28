document.getElementById('cabinetForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Empêche la soumission du formulaire pour validation

    // Récupérer les valeurs des champs
    const nom = document.getElementById('nom').value;
    const adresse = document.getElementById('adresse').value;
    const specialite = document.getElementById('specialite').value;

    // Vérification que tous les champs sont remplis
    if (!nom || !adresse || !specialite) {
        document.getElementById('error-message').style.display = 'block';
        return; // Arrêter l'exécution si un champ est manquant
    }

    // Créer l'objet cabinet
    const cabinetData = {
        nom: nom,
        adresse: adresse,
        specialite: specialite
    };

    // Envoi des données à Omeka S
    addCabinetToOmeka(cabinetData);
});

// Fonction pour envoyer les données à Omeka S
function addCabinetToOmeka(cabinetData) {
    const apiOmk = 'http://localhost/Sites/omeka-s/api/';
    const ident = 't0q2LUc9THKR0MF6zJLCbC7rKNe6tjln'; // clé d'identité
    const key = 'qeOVCpGdgMqil4bFh0MZSWjaRWxjh1zW'; // clé de credential

    // Ajouter un cabinet via l'API Omeka S
    fetch(apiOmk + 'items', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${key}`  // Authentification avec la clé
        },
        body: JSON.stringify({
            resource_class: 'cabinet_medical',  // Classe de ressource
            data: [
                { "property_id": 1, "value": cabinetData.nom },      // Nom
                { "property_id": 2, "value": cabinetData.adresse },  // Adresse
                { "property_id": 3, "value": cabinetData.specialite } // Spécialité
            ]
        })
    })
    .then(response => response.json())
    .then(data => {
        // Afficher la réponse de l'API
        console.log('Cabinet ajouté :', data);
        // Tu peux ici afficher un message de succès ou rediriger l'utilisateur
    })
    .catch(error => {
        // Afficher les erreurs si elles se produisent
        console.error('Erreur lors de l\'ajout du cabinet:', error);
        document.getElementById('error-message').textContent = "Une erreur s'est produite lors de l'ajout du cabinet.";
        document.getElementById('error-message').style.display = 'block';
    });
}
