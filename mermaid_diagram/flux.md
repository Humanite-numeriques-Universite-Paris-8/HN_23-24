classDiagram
    class User {
        <<Abstract>>
        +int userId
        +String username
        +String email
        +String password
        +login()
        +logout()
    }

    class Admin {
        +manageUsers()
        +viewAppointments()
        +addCabinet()
        +viewDoctors()
    }

    class Doctor {
        +String specialty
        +viewAppointments()
        +acceptAppointment()
        +rejectAppointment()
    }

    class Patient {
        +String fullName
        +String phoneNumber
        +bookAppointment()
        +cancelAppointment()
    }

    class Appointment {
        +int appointmentId
        +Date date
        +String time
        +String status
        +Patient patient
        +Doctor doctor
        +confirm()
        +cancel()
    }

    class Cabinet {
        +int cabinetId
        +String cabinetName
        +String address
        +String city
        +Doctor doctor
        +viewDetails()
    }

    class Auth {
        +register(username: String, password: String, email: String)
        +login(username: String, password: String)
        +logout()
    }

    User <|-- Admin
    User <|-- Doctor
    User <|-- Patient
    Doctor "1" --> "many" Appointment
    Patient "1" --> "many" Appointment
    Appointment "1" --> 1 Doctor
    Appointment "1" --> 1 Patient
    Cabinet "1" --> "many" Doctor

    style User fill:#bfb,stroke:#6f6,stroke-width:2px,color:#000,stroke-dasharray: 5 5
    style Appointment fill:#ffb,stroke:#663,stroke-width:2px,color:#000,stroke-dasharray: 5 5
    style Cabinet fill:#9ff,stroke:#369,stroke-width:2px,color:#000,stroke-dasharray: 5 5
    style Auth fill:#ffb,stroke:#663,stroke-width:2px,color:#000,stroke-dasharray: 5 5




//sequenceDiagram
