classDiagram
    class Utilisateur {
        +int id
        +String nomUtilisateur
        +String email
        +String motDePasse
    }

    class Admin {
        +ajouterCabinet()
        +listerCabinets()
        +modifierCabinet()
        +supprimerCabinet()
        +obtenirListeMedecins()
        +obtenirListePatients()
        +modifierMedecin()
        +supprimerMedecin()
        +modifierPatient()
        +supprimerPatient()
        +rechercher médecin()
        +rechercher spécialité()
    }

    class Medecin {
        +String specialite
        +listerRdv()
        +validerRdv()
        +supprimerRdv()
        +annulerRdv()
        +telechargerPdfRdv()
    }

    class Patient {
        +String username
        +reserverRdv()
        +listerRdv()
        +listerCabinets()
        +deplacerRdv()
        +annulerRdv()
        +telechargerPdfRdv()
        +rechercher médecin()
        +rechercher spécialité()
        +listerFormulaire()
    }

    class RendezVous {
        +int id
        +int patient_id
        +int docteur_id
        +Date dateRendezVous
        +int phonePatient
        +Date createdAt
        +confirmer()
        +annuler()
    }

    class Cabinet {
        +int id
         +int docteur_id
        +String nomCabinet
        +String adresse
        +String specialite
        
    }

    Utilisateur <|-- Admin
    Utilisateur <|-- Medecin
    Utilisateur <|-- Patient
    Medecin "1" --> "*" RendezVous : gère
    Patient "1" --> "*" RendezVous : a réservé
    Cabinet "1" --> "*" Medecin : contient




sequenceDiagram
    participant Admin
    participant Patient
    participant Medecin
    participant BaseDeDonnees as Base de Données

    %% Interactions Admin
    Admin->>+BaseDeDonnees: Ajouter Cabinet
    BaseDeDonnees-->>-Admin: Confirmation

…    BaseDeDonnees-->>-Medecin: Confirmation Validation

    Medecin->>+BaseDeDonnees: Supprimer RDV
    BaseDeDonnees-->>-Medecin: Confirmation Suppression

    Medecin->>+BaseDeDonnees: Télécharger PDF de RDV
    BaseDeDonnees-->>-Medecin: Fichier PDF
