//Licence: MIT Brányi Balázs & Oláh Zoltán 2023-2024
// 

/******************************************************************************************************************************
 * Függvény: findParentTable
 * Leírás: Ez a függvény egy adott DOM elem szülő táblázat elemét keresi meg, végighaladva a DOM hierarchián.
 *         Visszaadja a megtalált táblázat elemet, vagy null értéket, ha nem található.
 *
 * Paraméterek:
 * - element (HTMLElement): Az a DOM elem, amelynek szülő táblázat elemét keressük.
 */
function findParentTable(element) {
  // Traverse the DOM hierarchy to find the parent table element
  while (element && element.tagName !== 'TABLE') {
    element = element.parentElement;
  }
  // Return the found table element, or null if not found
  return element;
}

/******************************************************************************************************************************
 * Változó: headers
 * Leírás: Az összes, "collapsible-header" osztályú elemet tartalmazó NodeList, amelyeket kattintási eseményekhez használunk.
 */
const headers = document.querySelectorAll(".collapsible-header");

/******************************************************************************************************************************
 * Eseménykezelő: headers.forEach(header => { ... })
 * Leírás: Minden "collapsible-header" osztályú elemhez hozzáad egy kattintási eseményfigyelőt, amely összecsukja vagy 
 *         kinyitja a táblázat sorait, kivéve, ha az esemény egy <input> vagy <button> elemre történt.
 */
headers.forEach(header => {
  header.addEventListener("click", (event) => {
    // Check if the clicked element is an <input> field
    if (event.target.tagName !== 'INPUT' && event.target.tagName !== 'BUTTON') {
      const table = findParentTable(event.currentTarget);
      const contentRows = table.querySelectorAll(".collapsible-content");
      contentRows.forEach(contentRow => {
        contentRow.classList.toggle("collapsed");
      });
      
    }
  });
});

/******************************************************************************************************************************
 * Változó: pageSearchElement
 * Leírás: Az "pageSearch" azonosítójú elemet tárolja, amely az oldal keresési mezője.
 */
var pageSearchElement = document.getElementById("pageSearch");

/******************************************************************************************************************************
 * Feltételes blokk: Ellenőrzi, hogy a pageSearchElement nem null értékű-e. Ha nem az, meghívja a handleFilter 
 *                   függvényt oldal keresési módban.
 */
if (pageSearchElement !== null) {
	handleFilter(null, true);
}

/******************************************************************************************************************************
 * Függvény: exportTableToCSV
 * Leírás: Ez a függvény egy megadott táblázatot CSV formátumba exportál. Csak azokat a sorokat tartalmazza a 
 *         CSV fájl, amelyek nincsenek elrejtve (nem tartalmazzák a 'display: none' stílust).
 *
 * Paraméterek:
 * - tableId (string): Annak a táblázatnak az azonosítója, amelyet CSV formátumba exportálunk.
 * - filename (string): Az exportált CSV fájl neve.
 */
        function exportTableToCSV(tableId, filename) {
    		var csv = [];
    		var rows = document.getElementById(tableId).querySelectorAll("tr:not([style*='display: none'])");

    		for (var i = 0; i < rows.length; i++) {
        		var row = [];
        		var cols = rows[i].querySelectorAll("td, th");

        		for (var j = 0; j < cols.length; j++) {
            		// Skip columns with the specified classes
            		if (cols[j].classList.contains("rejtettOszlop") || cols[j].classList.contains("valaszOszlop")) {
                		continue;
            		}
            		row.push('"' + cols[j].textContent.trim() + '"'); // Trim to remove extra spaces
        		}
        		csv.push(row.join(","));
    	}

    // Download CSV file
    var csvContent = "data:text/csv;charset=utf-8," + csv.join("\n");
    var encodedUri = encodeURI(csvContent);
    var link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", filename);
    link.style.display = "none";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
        }

// Esemenykezelo letrehozasa a jelolonegyzetekhez
const columnCheckboxes = document.querySelectorAll('.columnCheckbox');
columnCheckboxes.forEach(checkbox => {
	checkbox.addEventListener('change', () => {
		const unhiddenRows = [];
		let tableId = checkbox.getAttribute('data-table');
		const table = document.getElementById(`table${tableId}`);
		for (let i = 2; i < table.rows.length; i++) { 
			const row = table.rows[i]; 
      			if (row.style.display === "") {
				unhiddenRows.push(row);
			};
		};
		generateChart(`table${tableId}`, unhiddenRows);
	});
});

const iseveryrow = document.getElementById("toggler-1");
if (iseveryrow) {iseveryrow.addEventListener('change', () => {handleFilter(null, true)});};

const tables = document.querySelectorAll(`.collapsible-table`);
tables.forEach(table => {
	let tableId = table.getAttribute('id');
	let filterInput = document.querySelector(`#filterInput${tableId}`);
	if (filterInput) {
        	filterInput.addEventListener("input", () => {handleFilter(tableId)});
    	} else {
        	console.error(`Input element not found.`);
    	}
});
let filterInput = document.getElementById('pageSearch');
if (filterInput) {
        filterInput.addEventListener("input", () => {handleFilter(null, true)});
} else {
        console.error(`Input element not found.`);
}


// Űrlapadatok elküldése
document.getElementById('urlap').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the default form submission

    // Collect all rows in the form
    const rows = document.querySelectorAll('#urlap .collapsible-content');
    let body = '#$\n';
    let n = 0;
    let uresDatum = false;
    let uresValaszto = false;

    // Loop through each row and get the select and date values
    rows.forEach(row => {
        const selectElement = row.querySelector('select');
	if (selectElement) {
        const inputElement = row.querySelector('input[type="date"]'); // May be null

        // Remove any existing error message before validating
        const existingErrorMessage = row.querySelector('.error-message');
        if (existingErrorMessage) {
            existingErrorMessage.remove();
        }

        // Reset border color for all date inputs
        if (inputElement) {
            inputElement.style.borderColor = ''; // Reset to default border
        }
	if (selectElement) {
            selectElement.style.borderColor = ''; // Reset to default border
        }

        // Check if the input[type="date"] exists
        if (inputElement) {
	        // Üres állás
        	if (selectElement.value !== "0") { 
			// a legördülő nem 0 (ki van jelölve valami)
			if (inputElement.value !== "") { 
			    // Teljesen ki van töltve
		            // Build the formatted string with select name, select value, and date value
        		    body += `${selectElement.name}: ${selectElement.value} : ${inputElement.value}\n`;
	        	    n++; 
			} else {
			    // Ki van jelölve valami, de hiányzik a dátum:
			    uresDatum = true
			    inputElement.style.borderColor = 'red'; //piros keret
	                    // Create and insert the error message below the input field
        	            const errorMessage = document.createElement('span');
                	    errorMessage.classList.add('error-message');
                	    errorMessage.classList.add('left');	
	                    errorMessage.textContent = 'Nincs megjelölve a hatály!';
	                    inputElement.after(errorMessage); // Insert after the input field
			}
		} else {
			if (inputElement.value !=="") {
			    //Ugyan üres a visszajelzés, de a dátum nem.
			    uresValaszto = true
			    selectElement.style.borderColor = 'red';
		            // Create and insert the error message below the input field
        		    const errorMessage = document.createElement('span');
                	    errorMessage.classList.add('error-message');
                	    errorMessage.classList.add('left');		
	        	    errorMessage.textContent = 'Nincs megjelölve, hogy a hatály milyen változásra vonatkozik!';
		            selectElement.after(errorMessage); // Insert after the input field
			}
		}
	} else {
		//Ellenőrzés
		if (selectElement.value !== "0") { 
	            // Build the formatted string with select name, select value, and date value
        	    body += `${selectElement.name}: ${selectElement.value}\n`;
	            n++; 
	        }
	}}
    });

//Ha hibát találtunk, nem küldünk semmit, de előtte tájékztatjuk a felhasználót...
const altalanosUzenet = "\r\rHa nem változott egy álláshely állapota, akkor nem kell megjelölni semmilyen választ.\rDe ha változott az állapota, akkor meg kell adni azt is, hogy melyik napon történt a változás.\r\rAz átvizsgálandó mezőket piros színű kerettel kiemeltük.";

    if (uresDatum && uresValaszto) {
	alert(`Találtunk olyan mezőt, ahol meg van adva a változás hatálya, de nincs kiválasztva a változás;\nés találtunk olyat is, ahol ki van választva a változás, de nincs megjelölve a hatálya!` + altalanosUzenet );
	return;
	} else { 
	if (uresDatum) {
		alert(`Találtunk olyan mezőt, ahol meg van adva a változás hatálya, de nincs kiválasztva a változás!` + altalanosUzenet );
		return;
	}
	if (uresValaszto) {
		alert(`Találtunk olyan mezőt, ahol ki van választva a változás, de nincs megjelölve a hatálya!` + altalanosUzenet );
		return;
	}
    }

    body += '#$';


    // If there's valid data to send, construct the mailto URL and send the email
    if (n > 0) {
        const subject = encodeURIComponent('###Adatszolg visszajelzes###');
        const mailtoLink = `mailto:branyi.balazs@bfkh.gov.hu,olah.zoltan3@bfkh.gov.hu?subject=${subject}&body=${encodeURIComponent(body)}`;

        // Create a temporary anchor element to trigger the mailto link
        const tempLink = document.createElement('a');
        tempLink.href = mailtoLink;
        tempLink.style.display = 'none'; // Hide the link
        document.body.appendChild(tempLink);
        tempLink.click();
        document.body.removeChild(tempLink);
    }
});


//### Indítópulthoz való visszatéréshez gomb
document.getElementById('inditopultButton').addEventListener('click', function() {
    window.location.href = 'file:///L:/Ugyintezok/Adatszolg%C3%A1ltat%C3%B3k/HRELL/Ind%C3%ADt%C3%B3pult.html';
});

document.addEventListener("DOMContentLoaded", function() {
    var tetejereGomb = document.getElementById("tetejereGomb");

    window.onscroll = function() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            tetejereGomb.style.display = "block";
        } else {
            tetejereGomb.style.display = "none";
        }
    };

    tetejereGomb.addEventListener("click", function() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
    });
});

//### Visszajelzésgomb megjelenítése
document.addEventListener("DOMContentLoaded", function() {
    var visszajelzesGomb = document.getElementById("visszajelzesGomb");

    function checkVisszajelzesOszlop() {
        // Alapértelmezés szerint rejtve a gomb
        visszajelzesGomb.style.display = "none";

        // Minden táblázatot bejárunk
        var tables = document.querySelectorAll("table");
        for (var i = 0; i < tables.length; i++) {
            // Az oszlopok fejléceit (második sor) keressük
            var headerRow = tables[i].querySelector("thead tr:nth-child(2)"); // A második sor (fejléc) oszlopai
            if (headerRow) {
                var cells = headerRow.querySelectorAll("th, td"); // Fejléc oszlopainak cellái
                for (var cell of cells) {
                    if (cell.textContent.trim() === "Visszajelzés") {
                        visszajelzesGomb.style.display = "block"; // Ha találunk "Visszajelzés" oszlopot, megjelenítjük a gombot
                        return; // Ha megtaláltuk, nem kell tovább keresni
                    }
                }
            }
        }
    }

    // Ellenőrzés betöltéskor
    checkVisszajelzesOszlop();
});

/************************/

function Kapcsolo() {
    // Check if the toggler element already exists
    if (!document.querySelector('.toggler')) {
        // Create a div element for the toggler
        let togglerDiv = document.createElement('div');
        togglerDiv.classList.add('toggler');
	let tooltipDiv = document.createElement('div');
	tooltipDiv.classList.add('tooltip');
        
        // Create the input element
        let inputElement = document.createElement('input');
        inputElement.id = "toggler-1";
        inputElement.name = "toggler-1";
        inputElement.type = "checkbox";
        inputElement.checked = true;
        
        // Create the label element and set innerHTML for SVGs
        let labelElement = document.createElement('label');
        labelElement.setAttribute('for', 'toggler-1');
        labelElement.innerHTML = `
            <svg class="toggler-on" viewBox="0 0 130.2 130.2">
                <polyline class="path check" points="100.2,40.2 51.5,88.8 29.8,67.5"></polyline>
            </svg>
		<div class="left toggler-on" style="min-width: 120px; top:150%;right:-30%;text-align:center;margin-right:0px;padding:5px 0px;">
		Intézendő eltérések
		</div>
		<div class="left toggler-off" style="min-width: 120px; top:150%;right:-30%;text-align:center;margin-right:0px;padding:5px 0px;">
		Minden eltérés
		</div>
            <svg class="toggler-off" viewBox="0 0 130.2 130.2">
                <line class="path line" x1="34.4" y1="34.4" x2="95.8" y2="95.8"></line>
                <line class="path line" x1="95.8" y1="34.4" x2="34.4" y2="95.8"></line>
            </svg>
        `;

        // Append the input and label to the toggler div
	togglerDiv.appendChild(tooltipDiv);
        tooltipDiv.appendChild(inputElement);
        tooltipDiv.appendChild(labelElement);

        // Insert the toggler div before the button with id="inditopultButton"
        let fejlecDiv = document.getElementById("fejlec");
        fejlecDiv.prepend(togglerDiv);
    }
};

/**********************************************************************************************************************************************
 * Függvény: Cellaszínező
 * Leírás: Ez a függvény kiszínezi a cellákat az alapján, hogy milyen régen történt a legutóbbi visszajelzés. Csak akkor lép életbe, ha legalább a visszajelzések vele már beérkezett.
 */

document.addEventListener("DOMContentLoaded", function() {
	Cellaszinezo();
	const title = document.title;
	if (document.title.includes("Ellenőrzés")) {
		Kapcsolo();
		const iseveryrow = document.getElementById("toggler-1");
		if (iseveryrow) {iseveryrow.addEventListener('change', () => {handleFilter(null, true)});};
	};
});

function Cellaszinezo() {
	if (!document.title.includes("üres álláshelyek")) {return;}

	// Get the title of the document
        const title = document.title;

        // Define a regex pattern to match dates
        const datePattern = /(\d{4})\.\s*(\d{1,2})\.\s*(\d{1,2})/g;
	const match = title.match(datePattern);

        if (match) {
        	// Extract the date string
        	const dateString = match[0];
                
        	// Convert to Date object
        	currentDate = new Date(dateString);
	}

    // Get the cells from table2
    const table2 = document.getElementById('table2');
    const rows = table2.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    
    // Extract the values for comparison
    const unanswered = parseInt(rows[0].getElementsByTagName('td')[1].innerText.trim());
    const answered = parseInt(rows[1].getElementsByTagName('td')[1].innerText.trim());
    
    // Calculate the ratio
    const ratio = (answered / (answered + unanswered)) * 100;
    
    // If the ratio exceeds 50%, proceed to modify table3
    if (ratio > 50) {
        const table3 = document.getElementById('table3');
        const rows3 = table3.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        for (let i = 0; i < rows3.length; i++) {
            const row = rows3[i];
            // Find the "Legutóbbi állapot ideje" column, it's the 4th column (index 3)
            const dateCell = row.getElementsByTagName('td')[3];
            const dateText = dateCell ? dateCell.innerText.trim() : null;
            
            // Check if the date is null, empty, or invalid
            if (!dateText || isNaN(Date.parse(dateText.replace(/\./g, '-')))) {
                // Treat as an old date and set background to lightred
                applyBackgroundToRow(row, 'lightcoral');
            } else {
                // Parse the date (assuming format 'YYYY. MM. DD.')
                const parsedDate = new Date(dateText.replace(/\./g, '-'));
                
                // Calculate the difference in days between current date and parsed date
                const timeDifference = currentDate - parsedDate;
                const dayDifference = Math.ceil(timeDifference / (1000 * 60 * 60 * 24)); // Convert milliseconds to days
                
                if (dayDifference <= 5) {
                    // Change background to lightgreen for rows updated in the last 5 days
                    applyBackgroundToRow(row, 'lightgreen');
                } else {
                    // Change background to lightred for older rows
                    applyBackgroundToRow(row, 'lightcoral');
                }
            }
        }
    }
};

// Function to set the background color for all cells in a row except the "buborektabla" (the nested table)
function applyBackgroundToRow(row, color) {
    const cells = row.getElementsByTagName('td');
    for (let j = 0; j < cells.length; j++) {
        // Check if the cell contains a descendant of the class "buborektabla" and skip it
        if (!cells[j].querySelector('.buborektabla') && !cells[j].closest('.buborektabla')) {
            cells[j].style.setProperty('background-color', color, 'important');
        }
    }
}
//Üzenet a NEM Firefox-ot használóknak
    document.addEventListener("DOMContentLoaded", function () {
        // Check if the browser is not Firefox
        const isFirefox = navigator.userAgent.toLowerCase().includes('firefox');
        
        if (!isFirefox) {
            // Show the browser warning message
            document.getElementById('browser-warning').style.display = 'block';
        }
    });

    // Function to close the warning message
    function closeWarning() {
        document.getElementById('browser-warning').style.display = 'none';
    }