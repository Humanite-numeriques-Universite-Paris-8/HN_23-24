// Google Sheets API parameters
const sheetID = '1IythoFSP7yu-3qKPh_HPyY_rDxr7p6a2rs3Fx8zIWNI'; // My Google Sheet ID
const apiKey = 'AIzaSyA0kGOS33BZvkVSI9yfVuxOng3qAKMIGWk'; // My Google API key


async function fetchData() {
    const range = encodeURIComponent('Réponses au formulaire 1'); // Replace with the correct sheet name
    const url = `https://sheets.googleapis.com/v4/spreadsheets/${sheetID}/values/${range}?key=${apiKey}`;
  
    try {
        let response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        let data = await response.json();
        displayData(data.values); // Pass the data to the display function
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

    const tableBody = document.getElementById('questionnaire-table');
    tableBody.innerHTML = ''; // Clear existing rows

    data.forEach((row, index) => {
        if (index === 0) return; // Skip the header row

        let tr = document.createElement('tr');
        row.forEach(cell => {
            let td = document.createElement('td');
            td.textContent = cell;
            tr.appendChild(td);
        });
        tableBody.appendChild(tr);
    });
}

// Fetch data when the page loads
fetchData();