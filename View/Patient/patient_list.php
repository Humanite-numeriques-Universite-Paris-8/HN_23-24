<h2>Liste des Patients ayant réservé</h2>
<table>
    <tr>
        <th>Nom du Patient</th>
        <th>Email</th>
        <th>Cabinet Réservé</th>
        <th>Date de Rendez-vous</th>
    </tr>
    <!-- Loop through database records and display them here -->
    <?php 
        // Fetch patient bookings from the database
        foreach ($patients as $patient) {
            echo "<tr><td>{$patient['name']}</td><td>{$patient['email']}</td><td>{$patient['cabinet_name']}</td><td>{$patient['appointment_date']}</td></tr>";
        }
    ?>
</table>
