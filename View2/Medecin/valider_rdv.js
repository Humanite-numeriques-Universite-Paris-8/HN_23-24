// Récupérer les rendez-vous depuis le localStorage
let appointments = JSON.parse(localStorage.getItem('appointments')) || [];

// Fonction pour valider un rendez-vous
function validateAppointment(appointmentId) {
    // Rechercher le rendez-vous par ID
    const appointmentIndex = appointments.findIndex(app => app.id === appointmentId);
    if (appointmentIndex > -1) {
        // Mettre à jour l'état de validation
        appointments[appointmentIndex].isValidated = true;

        // Sauvegarder les données dans le localStorage
        localStorage.setItem('appointments', JSON.stringify(appointments));

        // Afficher un message de succès
        alert(`Le rendez-vous ID ${appointmentId} a été validé avec succès !`);

        // Recharger la page pour mettre à jour l'affichage
        window.location.reload();
    } else {
        alert(`Erreur : Rendez-vous avec ID ${appointmentId} introuvable.`);
    }
}

// Exemple d'appel de la fonction (peut être lié à un événement onclick)
document.addEventListener('DOMContentLoaded', () => {
    // Ajoutez des événements onclick dynamiquement aux boutons "Valider"
    const validateButtons = document.querySelectorAll('.validate-btn');
    validateButtons.forEach(button => {
        button.addEventListener('click', () => {
            const appointmentId = parseInt(button.dataset.id, 10); // Récupérer l'ID du bouton
            validateAppointment(appointmentId); // Valider le rendez-vous
        });
    });
});
