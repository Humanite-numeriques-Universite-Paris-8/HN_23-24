document.getElementById("add-cabinet-form").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent form from submitting the traditional way

    const name = document.getElementById("name").value;
    const address = document.getElementById("address").value;
    const doctor_id = document.getElementById("doctor_id").value;

    // Send data to PHP using AJAX
    fetch("../Php/add-cabinet.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ name, address, doctor_id })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Cabinet ajouté avec succès.");
            window.location.href = "../View/admin-dashboard.html";
        } else {
            alert("Erreur: " + data.message);
        }
    });
});

// Fetch doctors list dynamically from the server
fetch("../Php/get-doctors.php")
    .then(response => response.json())
    .then(data => {
        const doctorSelect = document.getElementById("doctor_id");
        data.doctors.forEach(doctor => {
            const option = document.createElement("option");
            option.value = doctor.id;
            option.textContent = doctor.username;
            doctorSelect.appendChild(option);
        });
    });
