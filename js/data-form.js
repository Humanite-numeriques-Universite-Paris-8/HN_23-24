// Google Sheets API parameters
const sheetID = '1IythoFSP7yu-3qKPh_HPyY_rDxr7p6a2rs3Fx8zIWNI'; // Your Google Sheet ID
const apiKey = 'AIzaSyA0kGOS33BZvkVSI9yfVuxOng3qAKMIGWk'; // Your Google API key




// Function to fetch data from the Google Sheet
async function fetchData() {
    // Use the correct sheet name and ensure it's URL-encoded
    const range = encodeURIComponent('Réponses au formulaire 1'); // Replace with your actual sheet name
    const url = `https://sheets.googleapis.com/v4/spreadsheets/${sheetID}/values/${range}?key=${apiKey}`;
    
    try {
        // Fetch the data from Google Sheets API
        let response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        // Convert the response to JSON
        let data = await response.json();
        // Call the function to display data in the table
        displayData(data.values);
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

// Function to display data in the table
function displayData(data) {
    if (!data || data.length === 0) {
        console.error('No data found.');
        return;
    }

    // Get the table body element
    const tableBody = document.getElementById('data-table').querySelector('tbody');
    tableBody.innerHTML = ''; // Clear any existing rows

    // Iterate over the data and create table rows
    data.forEach((row, index) => {
        if (index === 0) return; // Skip the header row from the Google Sheet

        let tr = document.createElement('tr');

        row.forEach((cell) => {
            let td = document.createElement('td');
            td.textContent = cell;
            tr.appendChild(td);
        });

        // Append the row to the table body
        tableBody.appendChild(tr);
    });
}

// Call the fetchData function when the page loads
fetchData();
