//Licence: MIT Brányi Balázs & Oláh Zoltán 2023-2024

// Create an array to store chart references
var chartArray = [];

/*********************************************************************************************************
 * Függvény: ShowSearchedRows
 * Leírs: Ez a függvény megjeleníti vagy elrejti a táblázat sorait egy szöveges szűrő alapján, 
 *         majd frissíti a megadott táblázat grafikonját az el nem rejtett sorok alapján.
 *
 * Paraméterek:
 * - filterText (string): A keresett szöveg, amely alapjn a sorokat szűrjük.
 * - rows (Array): A tblzat sorai, amelyeket meg kell jeleníteni vagy el kell rejteni.
 * - tableId (string): Ama tblzat azonosítója, amelynek grafikonjt frissíteni kell. Ha nincs megadva, 
 *   akkor az összes tblzat grafikonjt frissítjük.
 *********************************************************************************************************/
function ShowSearchedRows(filterText, rows, tableId) {
    filterText = filterText.toLowerCase();
    const unhiddenRows = [];
    rows.forEach(row => {
        const rowText = row.innerText.toLowerCase();
        if (rowText.includes(filterText)) {
            row.style.display = "";
            // Show the row
            unhiddenRows.push(row);
            //Az el nem rejtett sorokat tömbhöz adjuk
        } else {
            row.style.display = "none";
            // Hide the row
        }
    }
    );
    if (tableId) {
        generateChart(tableId, unhiddenRows);
    } else {
        tablakszama = document.querySelectorAll(`.collapsible-table`).length;
        for (let n = 1; n <= tablakszama; n++) {
            generateChart(`table${n}`, unhiddenRows);
        }
        ;
    }
    ;/*return unhiddenRows.length;*/
}
/*********************************************************************************************************
 * Függvény: handleFilter
 * Leírs: Ez a függvény kezeli a szűrő bemeneti mezőt, és megjeleníti vagy elrejti a táblázat sorait a 
 *         megadott szűrő szöveg alapjn. Ha az oldal keresést végzi, akkor az oldal keresési mezőjét hasznlja.
 *
 * Paraméterek:
 * - tableId (string): Annak a tblzatnak az azonosítója, amelynek a sorait szűrjük.
 * - isPageSearch (boolean, alapértelmezett: false): Ha igaz, az oldal keresési mezőjét használja a szűréshez.
 */
function handleFilter(tableId, isPageSearch=false) {
    let filterInput;
    let rows;
    /*let NumberOfFilteredRows;*/
    if (isPageSearch) {
        filterInput = document.getElementById('pageSearch');
        rows = document.querySelectorAll('.collapsible-content');
    } else {
        filterInput = document.querySelector(`#filterInput${tableId}`);
        rows = document.querySelectorAll(`#${tableId} .collapsible-content`);
    }
    if (filterInput.value.length < 3) {
        ShowSearchedRows('', rows, tableId);
    } else {
        ShowSearchedRows(filterInput.value, rows, tableId);
    }
    StyleDependingOnStatus();
    const sorok = document.querySelectorAll('.collapsible-content');
    const NumberOfFilteredRows = Array.from(sorok).filter(sorok => {
        return getComputedStyle(sorok).display !== 'none';
    }
    ).length;
	const talalatszam = document.getElementById("talalatszam");
	if (talalatszam) {
	    // Update the element's inner text if it exists
		talalatszam.innerText = NumberOfFilteredRows;
	} else {
	    // Add code to handle the missing element, e.g., create it dynamically
		const newElement = document.createElement('td');
		newElement.id = 'talalatszam';
		newElement.innerText = NumberOfFilteredRows;
		document.querySelector('.pageNumber tbody tr').appendChild(newElement);
	}
    const pageNumber = document.querySelector('#kereso .pageNumber');
    const showPageNumber = () => {
        pageNumber.style.opacity = 1;
        // Show the element
        clearTimeout(pageNumber._hideTimeout);
        // Clear any previous timeout
        pageNumber._hideTimeout = setTimeout( () => {
            pageNumber.style.opacity = "";
            // Hide after 5 seconds
        }
        , 5000);
    }
    ;
    showPageNumber();
    /*}*/
}

/*********************************************************************************************************
 *Függvény: StyleDependingOnStatus
 *Leírás: Ez a függvény megváltoztatja a sor megjelenését a visszajelzés oszlopban (rejtettOszlop osztályú oszlop) található szám alapján.
 *Ha nincs visszajelzés, vagy 8 (hibának ítéltetett), akkor alapértelmezett stílusú, ha 3 (megoldottnak jelzett), akkor piros, ha 7,9 (segítségre vár), akkor rejtett lesz az adott sor.
 */
function StyleDependingOnStatus() {
    // Get all the tables on the page
    rows = document.querySelectorAll('.collapsible-content');
    // Get the value of the toggle switch to show all
    if (document.getElementById("toggler-1")) {
        everyrow = document.getElementById("toggler-1").checked;
    } else {
        everyrow = true
    }
    ;// Iterate over each row in the current table
    for (let i = 0; i < rows.length; i++) {
        const row = rows[i];

        // Find the cell with the specific class
        const cell = row.querySelector(".rejtettOszlop");

        // If the cell with the class is found, check its value
        if (cell) {
            const value = parseInt(cell.textContent);

            // Apply style to the entire row based on the condition
            switch (value) {
            case 0:
            case 8:
                break;
            case 3:
                for (let j = 0; j < row.cells.length; j++) {
                    row.cells[j].style.setProperty("background-color", "lightcoral", "important");
                }
                break;
            default:
                if (everyrow) {
                    row.style.setProperty("display", "none", "important");
                } else {
                    for (let j = 0; j < row.cells.length; j++) {
                        row.cells[j].style.setProperty("background-color", "lightblue", "important");
                    }
                }
                ;break;
            }
        }
    }
}

/*********************************************************************************************************
/**************************            *******************************************************************
/*************************  GRAFIKONOK  ******************************************************************
/**************************            *******************************************************************
/*********************************************************************************************************


/*********************************************************************************************************
 * Vonaldiagram generálása táblázat alapján.
 * 
 * @param {string} tableId - A táblázat azonosítója.
 * @param {Array} rows - Az elérhető sorok tömbje.
 * @returns {string} - Az esetleges hibaüzenet vagy üres string, ha nincs hiba.
 */
function generateLineChart(tableId, rows) {
    if (tableId == null) {
        return '';
    }
    ;const table = document.getElementById(tableId);
    const firstRow = table.rows[1];
    const checkboxes = document.querySelectorAll(`#${tableId} .columnCheckbox`);
    const selectedColumns = Array.from(checkboxes).filter(checkbox => checkbox.checked);

    const labels = selectedColumns.map(checkbox => {
        const cellIndex = parseInt(checkbox.getAttribute('data-column')) - 1;
        if (firstRow.cells[cellIndex]) {
            return firstRow.cells[cellIndex].textContent;
        } else {
            console.error(`Cell ${cellIndex} does not exist in the first row.`);
            return '';
        }
    }
    );

    const datasets = [];
    var tableactuallength = 0;
    for (let i = 2; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row.style.display === "") {
            tableactuallength += 1
        }
    }
    ;var actualrownumber = 1;
    for (let i = 2; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row.style.display === "") {
            actualrownumber += 1;
            const categoryName = row.cells[0].textContent;

            const data = selectedColumns.map(checkbox => {
                const cellIndex2 = parseInt(checkbox.getAttribute('data-column')) - 1;
                if (firstRow.cells[cellIndex2]) {
                    return row.cells[cellIndex2].textContent;
                } else {
                    console.error(`Cell ${cellIndex2} does not exist in the first row.`);
                    return '';
                }

            }
            );
            pickedcolor = '#' + (Math.floor(16099931 + (actualrownumber - 1) * 1237910 / (tableactuallength + 1)) % 16777215).toString(16).padStart(6, '0');
            let found = false;
            if (tableactuallength > 8) {
                for (let i = 0; i < datasets.length; i++) {
                    if (datasets[i].label == categoryName) {
                        summed = data.map( (a, j) => String(a * 1 + datasets[i].data[j] * 1));
                        found = true;
                        datasets[i].data = summed;
                    }
                }
                ;if (!found) {
                    datasets.push({
                        label: categoryName,
                        data: data,
                        borderColor: pickedcolor,
                        fill: false
                    })
                }
                ;
            } else {
                for (let i = 0; i < datasets.length; i++) {
                    if (datasets[i].label == categoryName) {
                        found = true
                    }
                    ;
                }
                ;if (found) {
                    var newcategoryName = " " + String(row.cells[1].textContent);
                } else {
                    var newcategoryName = "";
                }
                ;const categorytopush = categoryName + newcategoryName;
                datasets.push({
                    label: categorytopush,
                    data: data,
                    borderColor: pickedcolor,
                    fill: false
                });
            }
            ;
        }
    }

    const chartData = {
        labels: labels,
        datasets: datasets,
    };

    const canvasId = `canv-${tableId}`;
    const chartId = `chart-${tableId}`;
    let canvas = document.getElementById(canvasId);

    if (!canvas) {
        // If the canvas does not exist, create it
        canvas = document.createElement('canvas');
        canvas.id = canvasId;
        table.parentNode.insertBefore(canvas, table);
    }

    const ctx = canvas.getContext('2d');

    // Customize chart options
    const chartOptions = {
        responsive: true,
        scales: {
            xAxes: [{
                ticks: {
                    beginAtZero: true,
                    fontColor: "#fff",
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Hónapok',
                    fontSize: 18,
                    fontColor: "#eee",
                },
            }],
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    fontColor: "#fff",
                },
                scaleLabel: {
                    display: true,
                    labelString: 'í‰rtékek',
                    fontSize: 18,
                    fontColor: "#eee",
                },
            }],
        },
        legend: {
            labels: {
                fontColor: "#fff",
            }
        },
    };

    const backgroundColorPlugin = {
        id: 'customCanvasBackgroundColor',
        beforeDraw: (chart) => {
            const ctx = chart.ctx;
            ctx.fillStyle = 'rgba(247, 194, 150, 0.8)';
            ctx.fillRect(0, 0, chart.width, chart.height);
        }
    };

    // Destroy the previous chart if it exists
    destroyChartById(chartId);

    // Create a new chart with chartoptions
    if (chartData.datasets.length == 0) {
        return '';
    }
    ;let newChart = new Chart(ctx,{
        type: 'line',
        data: chartData,
        options: chartOptions,
        plugins: [backgroundColorPlugin]
    });

    chartArray.push({
        id: chartId,
        instance: newChart
    });

}

/*********************************************************************************************************
 * Függvény: generatePyramidChart
 * Leírs: Ez a függvény egy piramisdiagramot generál egy táblázat alapján, amely megjeleníti a különböző 
 *         kategóriákhoz tartozó adatokat. A diagram vízszintes sávokat használ a vizuális ábrázoláshoz.
 *
 * Paraméterek:
 * - tableId (string): Annak a táblázatnak az azonosítója, amely alapján a piramisdiagramot generáljuk.
 * - rows (Array): A táblázat sorai, amelyeket a diagram készítéséhez használunk.
 */
function generatePyramidChart(tableId, rows) {
    if (tableId == null) {
        return '';
    }
    ;const table = document.getElementById(tableId);
    const firstRow = table.rows[1];
    const datasets = [];
    const categories = [];
    const firstColumn = [];
    const secondColumn = [];
    for (let i = 2; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row.style.display === "") {
            if (row.cells[0].textContent != ' Összesen:') {
                categories.push(row.cells[0].textContent);
                processed1 = row.cells[1].textContent.replace(/ /g, '');
                firstColumn.push(parseInt(processed1));
                processed2 = row.cells[2].textContent.replace(/ /g, '');
                secondColumn.push(parseInt(processed2));
            }
            ;
        }
        ;
    }
    datasets.push({
        label: firstRow.cells[1].textContent,
        data: firstColumn.reverse(),
        borderColor: '#0066FF',
        backgroundColor: '#0099FF'
    });
    datasets.push({
        label: firstRow.cells[2].textContent,
        data: secondColumn.reverse(),
        borderColor: '#FF3366',
        backgroundColor: '#FF6699'
    });
    categories.reverse();

    const chartData = {
        datasets: datasets,
        labels: categories
    };
    const canvasId = `canv-${tableId}`;
    const chartId = `chart-${tableId}`;
    let canvas = document.getElementById(canvasId);

    if (!canvas) {
        // If the canvas does not exist, create it
        canvas = document.createElement('canvas');
        canvas.id = canvasId;
        table.parentNode.insertBefore(canvas, table);
    }

    const ctx = canvas.getContext('2d');

    // Customize chart options
    const chartOptions = {
        indexAxis: 'y',
        responsive: true,
        aspectRatio: 3,
        scales: {
            xAxes: [{
                ticks: {
                    fontColor: "#fff",
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Létszám',
                    fontSize: 18,
                    fontColor: "#eee",
                },
            }],
            yAxes: [{
                stacked: true,
                ticks: {
                    fontColor: "#fff",
                },
            }],
        },
        legend: {
            labels: {
                fontColor: "#fff",
            }
        },
    };

    const backgroundColorPlugin = {
        id: 'customCanvasBackgroundColor',
        beforeDraw: (chart) => {
            const ctx = chart.ctx;
            ctx.fillStyle = 'rgba(247, 194, 150, 0.8)';
            ctx.fillRect(0, 0, chart.width, chart.height);
        }
    };

    // Destroy the previous chart if it exists
    destroyChartById(chartId);

    // Create a new chart with chartoptions
    nonempty = false;
    for (let i = 0; i < chartData.datasets.length; i++) {
        if (chartData.datasets[i].data.length != 0) {
            nonempty = true
        }
        ;
    }
    ;if (!nonempty) {
        return '';
    }
    ;let newChart = new Chart(ctx,{
        type: 'horizontalBar',
        data: chartData,
        options: chartOptions,
        plugins: [backgroundColorPlugin]
    });

    chartArray.push({
        id: chartId,
        instance: newChart
    });

}

/*********************************************************************************************************
 * Függvény: generatePieChart
 * Leírs: Ez a függvény egy kördiagramot generál egy táblázat alapján, amely megjeleníti a különböző 
 *         kategóriákhoz tartozó adatokat.
 *
 * Paraméterek:
 * - tableId (string): Annak a táblázatnak az azonosítója, amely alapján a kördiagramot generáljuk.
 * - rows (Array): A táblázat sorai, amelyeket a diagram készítéséhez használunk.
 */
function generatePieChart(tableId, rows) {
    if (tableId == null) {
        return '';
    }
    ;const table = document.getElementById(tableId);
    const firstRow = table.rows[1];
    const datasets = [];
    const categories = [];
    const data = [];
    const colors = [];
    var tableactuallength = 0;
    for (let i = 2; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row.style.display === "") {
            tableactuallength += 1
        }
    }
    ;var actualrownumber = 0;
    for (let i = 2; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row.style.display === "") {
            actualrownumber += 1;
	    //pickedcolor = '#' + (Math.floor(16099931 + (actualrownumber - 1) * 9656832 / (tableactuallength + 1)) % 16777215).toString(16).padStart(6, '0');
            pickedcolor = '#' + (Math.floor(16099931 + (actualrownumber - 1) * 2697771 / (tableactuallength + 1)) % 16777215).toString(16).padStart(6, '0');
            if (row.cells[0].textContent != 'Összesen:') {
                categories.push(row.cells[0].textContent)
                data.push(row.cells[1].textContent)
                colors.push(pickedcolor)
            }
            ;
        }
        ;
    }
    ;datasets.push({
        label: categories,
        data: data,
        backgroundColor: colors
    });
    const chartData = {
        datasets: datasets,
        labels: categories
    };
    const canvasId = `canv-${tableId}`;
    const chartId = `chart-${tableId}`;
    let canvas = document.getElementById(canvasId);

    if (!canvas) {
        // If the canvas does not exist, create it
        canvas = document.createElement('canvas');
        canvas.id = canvasId;
        table.parentNode.insertBefore(canvas, table);
    }

    const ctx = canvas.getContext('2d');

    // Customize chart options
    const chartOptions = {
        indexAxis: 'y',
        responsive: true,
        aspectRatio: 3,

        legend: {
            labels: {
                fontColor: "#fff",
            }
        },
    };

    const backgroundColorPlugin = {
        id: 'customCanvasBackgroundColor',
        beforeDraw: (chart) => {
            const ctx = chart.ctx;
            ctx.fillStyle = 'rgba(247, 194, 150, 0.8)';
            ctx.fillRect(0, 0, chart.width, chart.height);
        }
    };

    // Destroy the previous chart if it exists
    destroyChartById(chartId);

    // Create a new chart with chartoptions
    nonempty = false;
    for (let i = 0; i < chartData.datasets.length; i++) {
        if (chartData.datasets[i].data.length != 0) {
            nonempty = true
        }
        ;
    }
    ;if (!nonempty) {
        return '';
    }
    ;let newChart = new Chart(ctx,{
        type: 'pie',
        data: chartData,
        options: chartOptions,
        plugins: [backgroundColorPlugin]
    });

    chartArray.push({
        id: chartId,
        instance: newChart
    });

}

/*********************************************************************************************************
 * Függvény: generateChart
 * Leírs: Ez a függvény egy táblázat alapján generál grafikonokat. A táblázat típusa alapján vonaldiagramot 
 *         vagy piramisdiagramot készít a megadott sorokból.
 *
 * Paraméterek:
 * - tableId (string): Annak a táblázatnak az azonosítója, amely alapján a grafikont generáljuk.
 * - unhiddenRows (Array): A nem elrejtett sorok tömbje, amelyeket a grafikon készítéséhez használunk.
 */
function generateChart(tableId, unhiddenRows) {
    const table = document.getElementById(tableId);
    let ChartType = table.getAttribute('charttype');
    if (ChartType == 'line') {
        generateLineChart(tableId, unhiddenRows);
    }
    ;if (ChartType == 'pyramid') {
        generatePyramidChart(tableId, unhiddenRows);
    }
    ;if (ChartType == 'Pie') {
        generatePieChart(tableId, unhiddenRows);
    }
    ;

}
/*********************************************************************************************************
 * Diagram megsemmisítése azonosító alapján.
 * 
 * @param {string} chartId - A diagram azonosítója.
 */
function destroyChartById(chartId) {
    for (var i = 0; i < chartArray.length; i++) {
        if (chartArray[i].id === chartId) {
            chartArray[i].instance.destroy();
            chartArray.splice(i, 1);
            // Remove the chart reference from the array
            break;
        }
    }
}

/*********************************************************************************************************
 * Diagram keresése azonosító alapján.
 * 
 * @param {string} chartId - A diagram azonosítója.
 * @returns {object|null} - A megtalált diagram példnya vagy null, ha nem található.
 */
function findChartById(chartId) {
    for (var i = 0; i < chartArray.length; i++) {
        if (chartArray[i].id === chartId) {
            return chartArray[i].instance;
        }
    }
    return null;
    // Nem talált diagramot :(
}
