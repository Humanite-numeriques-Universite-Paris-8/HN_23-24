document.addEventListener("DOMContentLoaded", function() {
    const formElement = document.querySelector("form"); // Select your form

    formElement.addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent the default form submission
    
        const formData = new FormData(formElement);
    
        // Correct URL for form submission
        fetch('http://localhost/Projet1_Thyp_Ahef/View/Admin/PHP/index_app.php?action=add_cabinet', {
            method: 'POST',
            body: formData,
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to submit the form.'); // Adjust error message as needed
            }
            return response.json(); // Adjust based on your server response
        })
        .then(data => {
            console.log('Success:', data);
            window.location.href = "http://localhost/Projet1_Thyp_Ahef/View/Admin/admin-lists/admin-list.php"; // Redirect to cabinet list
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
    
});
