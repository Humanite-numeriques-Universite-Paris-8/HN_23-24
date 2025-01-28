// Récupérer les rendez-vous depuis le localStorage
let appointments = JSON.parse(localStorage.getItem('appointments')) || [];

// Fonction pour annuler un rendez-vous
function cancelAppointment(appointmentId) {
    // Filtrer les rendez-vous pour supprimer celui avec l'ID donné
    appointments = appointments.filter(app => app.id !== appointmentId);

    // Sauvegarder les données mises à jour dans le localStorage
    localStorage.setItem('appointments', JSON.stringify(appointments));

    // Afficher un message de confirmation
    alert(`Le rendez-vous ID ${appointmentId} a été annulé avec succès !`);

    // Recharger la page pour mettre à jour l'affichage
    window.location.reload();
}

// Ajoutez des événements onclick dynamiquement aux boutons "Annuler"
document.addEventListener('DOMContentLoaded', () => {
    const cancelButtons = document.querySelectorAll('.cancel-btn');
    cancelButtons.forEach(button => {
        button.addEventListener('click', () => {
            const appointmentId = parseInt(button.dataset.id, 10); // Récupérer l'ID du bouton
            cancelAppointment(appointmentId); // Appeler la fonction pour annuler
        });
    });
});
