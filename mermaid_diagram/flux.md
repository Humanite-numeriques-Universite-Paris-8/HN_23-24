//classDiagram
  

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
        +obtenirListeMedecins()
        +obtenirListePatients()
    }

    class Medecin {
        +String specialite
        +listerRdv()
        +validerRdv()
        +supprimerRdv()
        +telechargerPdfRdv()
    }

    class Patient {
        +String username
        +reserverRdv()
        +listerCabinets()
        +deplacerModifierRdv()
        +annulerRdv()
        +telechargerPdfRdv()
    }

    class RendezVous {
        +int id
        +Date dateRendezVous
        +String statut
        +confirmer()
        +annuler()
    }

    class Cabinet {
        +int id
        +String nom
        +String adresse
        +String ville
        +voirDetails()
    }

    Utilisateur <|-- Admin
    Utilisateur <|-- Medecin
    Utilisateur <|-- Patient
    Medecin "1" --> "*" RendezVous : gère
    Patient "1" --> "*" RendezVous : a réservé
    Cabinet "1" --> "*" Medecin : contient






//sequenceDiagram

sequenceDiagram
    participant Admin
    participant Patient
    participant Medecin
    participant BaseDeDonnees as Base de Données

    %% Interactions Admin
    Admin->>+BaseDeDonnees: Ajouter Cabinet
    BaseDeDonnees-->>-Admin: Confirmation

    Admin->>+BaseDeDonnees: Lister Cabinets
    BaseDeDonnees-->>-Admin: Liste des Cabinets

    Admin->>+BaseDeDonnees: Lister Médecins
    BaseDeDonnees-->>-Admin: Liste des Médecins

    Admin->>+BaseDeDonnees: Lister Patients
    BaseDeDonnees-->>-Admin: Liste des Patients

    %% Interactions Patient
    Patient->>+BaseDeDonnees: Réserver RDV
    BaseDeDonnees-->>-Patient: Confirmation RDV

    Patient->>+BaseDeDonnees: Lister Cabinets
    BaseDeDonnees-->>-Patient: Liste des Cabinets

    Patient->>+BaseDeDonnees: Modifier RDV
    BaseDeDonnees-->>-Patient: Confirmation Modification

    Patient->>+BaseDeDonnees: Annuler RDV
    BaseDeDonnees-->>-Patient: Confirmation Annulation

    Patient->>+BaseDeDonnees: Télécharger PDF de RDV
    BaseDeDonnees-->>-Patient: Fichier PDF

    %% Interactions Médecin
    Medecin->>+BaseDeDonnees: Lister RDV
    BaseDeDonnees-->>-Medecin: Liste des RDV

    Medecin->>+BaseDeDonnees: Valider RDV
    BaseDeDonnees-->>-Medecin: Confirmation Validation

    Medecin->>+BaseDeDonnees: Supprimer RDV
    BaseDeDonnees-->>-Medecin: Confirmation Suppression

    Medecin->>+BaseDeDonnees: Télécharger PDF de RDV
    BaseDeDonnees-->>-Medecin: Fichier PDF
