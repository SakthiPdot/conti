

var examples = {};

//From html - shows how pdf tables can be be drawn from html tables
examples.broman = function () {
	
    var doc = new jsPDF('p', 'pt');
   // doc.text("From HTML", 40, 50);
    var companyname = document.getElementById('companyname').innerHTML;
    var area = document.getElementById('area').innerHTML;
    if(document.getElementById('street') != null){
    	var street = document.getElementById('street').innerHTML;
    }
    
    var city = document.getElementById('city').innerHTML;
    var phoneno = document.getElementById('phoneno').innerHTML;
    var logo = document.getElementById('logo').innerHTML;
    var title = document.getElementById('title').innerHTML;
    var logoimg = document.getElementById('logoimg').innerHTML;
    var filter_branch=document.getElementById('filter_branch').innerHTML;
    var filter_username=document.getElementById('filter_username').innerHTML;
    
    doc.text(companyname, 160, 50);
    doc.text(area, 160, 70);
    if(document.getElementById('street') == null){
    	doc.text(city, 160, 90);
    	doc.text(phoneno, 160, 110);
    	doc.text(title,40,220);
    	doc.text(filter_branch, 40, 180);
    	doc.text(filter_username, 40, 200);
    	
    }else {
    	/*doc.text(street, 160, 90);
        doc.text(city, 160, 110);
        doc.text(phoneno, 160, 130);
        doc.text(title,160,150);*/
    	doc.text(city, 160, 90);
    	doc.text(phoneno, 160, 110);
    	doc.text(title,40,220);
    	doc.text(filter_branch, 40, 180);
    	doc.text(filter_username, 40, 200);
    }
    
   
   
    try {
    	var headerImgData = 'data:image/jpg;base64,';
    	 doc.addImage(headerImgData+logo, 40, 40, 100, 100);
    } catch(err) {
    	
    	try {
    		var headerImgData = 'data:image/png;base64,';
       	 	doc.addImage(headerImgData+logo, 40, 40, 100, 100);
    	} catch(err){
    		var headerImgData = 'data:image/gif;base64,';
       	 	doc.addImage(headerImgData+logo, 40, 40, 100, 100);
    	}
    	
    }
    
   
    
    var elem = document.getElementById("basic-table");
    var res = doc.autoTableHtmlToJson(elem);
    doc.autoTable(res.columns, res.data, {startY: 240,styles: {overflow: 'linebreak'},
    	theme: 'grid'
    });
    return doc;
};


// Default - shows what a default table looks like
examples.html = function () {
    var doc = new jsPDF('p', 'pt');
    doc.autoTable(getColumns(), getData());
    return doc;
};

// Minimal - shows how compact tables can be drawn
examples.minimal = function () {
    var doc = new jsPDF('p', 'pt');
    doc.autoTable(getColumns(), getData(), {
        tableWidth: 'wrap',
        styles: {cellPadding: 2},
        headerStyles: {rowHeight: 15, fontSize: 8},
        bodyStyles: {rowHeight: 12, fontSize: 8, valign: 'middle'}
    });
    return doc;
};

// Long data - shows how the overflow features looks and can be used
examples.long = function () {
    var doc = new jsPDF('l', 'pt');
    var columnsLong = getColumns().concat([
        {title: shuffleSentence(), dataKey: "text"},
        {title: "Text with a\nlinebreak", dataKey: "text2"}
    ]);

    doc.text("Overflow 'ellipsize' (default)", 10, 40);
    doc.autoTable(columnsLong, getData(), {
        startY: 55,
        margin: {horizontal: 10},
        columnStyles: {text: {columnWidth: 250}}
    });

    doc.text("Overflow 'hidden'", 10, doc.autoTableEndPosY() + 30);
    doc.autoTable(columnsLong, getData(), {
        startY: doc.autoTableEndPosY() + 45,
        margin: {horizontal: 10},
        styles: {overflow: 'hidden'},
        columnStyles: {email: {columnWidth: 160}}
    });

    doc.text("Overflow 'linebreak'", 10, doc.autoTableEndPosY() + 30);
    doc.autoTable(columnsLong, getData(3), {
        startY: doc.autoTableEndPosY() + 45,
        margin: {horizontal: 10},
        styles: {overflow: 'linebreak'},
        bodyStyles: {valign: 'top'},
        columnStyles: {email: {columnWidth: 'wrap'}},
    });

    return doc;
};

// Content - shows how tables can be integrated with any other pdf content
examples.content = function () {
    var doc = new jsPDF('p', 'pt');

    doc.setFontSize(18);
    doc.text('A story about Miusov', 40, 60);
    doc.setFontSize(11);
    doc.setTextColor(100);
    var text = doc.splitTextToSize(shuffleSentence(faker.lorem.words(55)) + '.', doc.internal.pageSize.width - 80, {});
    doc.text(text, 40, 80);

    var cols = getColumns();
    cols.splice(0, 2);
    doc.autoTable(cols, getData(40), {startY: 150});

    doc.text(text, 40, doc.autoTableEndPosY() + 30);

    return doc;
};

// Multiple - shows how multiple tables can be drawn both horizontally and vertically
examples.multiple = function () {
    var doc = new jsPDF('p', 'pt');
    doc.setFontSize(22);
    doc.text("Multiple tables", 40, 60);
    doc.setFontSize(12);

    doc.autoTable(getColumns().slice(0, 3), getData(), {
        startY: 90,
        pageBreak: 'avoid',
        margin: {right: 305}
    });

    doc.autoTable(getColumns().slice(0, 3), getData(), {
        startY: 90,
        pageBreak: 'avoid',
        margin: {left: 305}
    });

    for (var j = 0; j < 6; j++) {
        doc.autoTable(getColumns(), getData(9), {
            startY: doc.autoTableEndPosY() + 30,
            pageBreak: 'avoid',
        });
    }

    return doc;
};



// Header and footers - shows how header and footers can be drawn
examples['header-footer'] = function () {
    var doc = new jsPDF('p', 'pt');
    var totalPagesExp = "{total_pages_count_string}";

    var pageContent = function (data) {
        // HEADER
        doc.setFontSize(20);
        doc.setTextColor(40);
        doc.setFontStyle('normal');
//        doc.addImage(headerImgData, 'JPEG', data.settings.margin.left, 40, 25, 25);
        doc.text("Report", data.settings.margin.left + 35, 60);

        // FOOTER
        var str = "Page " + data.pageCount;
        // Total page number plugin only available in jspdf v1.0+
        if (typeof doc.putTotalPages === 'function') {
            str = str + " of " + totalPagesExp;
        }
        doc.setFontSize(10);
        doc.text(str, data.settings.margin.left, doc.internal.pageSize.height - 30);
    };
    
    doc.autoTable(getColumns(), getData(40), {
        addPageContent: pageContent,
        margin: {top: 80}
    });

    // Total page number plugin only available in jspdf v1.0+
    if (typeof doc.putTotalPages === 'function') {
        doc.putTotalPages(totalPagesExp);
    }

    return doc;
};

// Themes - shows how the different themes looks
examples.themes = function () {
    var doc = new jsPDF('p', 'pt');
    doc.setFontSize(12);
    doc.setFontStyle('bold');

    doc.text('Theme "striped"', 40, 50);
    doc.autoTable(getColumns(), getData(), {startY: 60});

    doc.text('Theme "grid"', 40, doc.autoTableEndPosY() + 30);
    doc.autoTable(getColumns(), getData(), {startY: doc.autoTableEndPosY() + 40, theme: 'grid'});

    doc.text('Theme "plain"', 40, doc.autoTableEndPosY() + 30);
    doc.autoTable(getColumns(), getData(), {startY: doc.autoTableEndPosY() + 40, theme: 'plain'});

    return doc;
};

// Horizontal - shows how tables can be drawn with horizontal headers
examples.horizontal = function () {
    var doc = new jsPDF('p', 'pt');
    doc.autoTable(getColumns().splice(1,4), getData(), {
        drawHeaderRow: function() {
            // Don't draw header row
            return false;
        },
        columnStyles: {
            first_name: {fillColor: [41, 128, 185], textColor: 255, fontStyle: 'bold'}
        }
    });
    return doc;
};


// Custom style - shows how custom styles can be applied to tables
examples.custom = function () {
    var doc = new jsPDF('p', 'pt');
    doc.autoTable(getColumns().slice(2, 6), getData(20), {
        styles: {
            font: 'courier',
            lineColor: [44, 62, 80],
            lineWidth: 2
        },
        headerStyles: {
            fillColor: [44, 62, 80],
            fontSize: 15,
            rowHeight: 30
        },
        bodyStyles: {
            fillColor: [52, 73, 94],
            textColor: 240
        },
        alternateRowStyles: {
            fillColor: [74, 96, 117]
        },
        columnStyles: {
            email: {
                fontStyle: 'bold'
            }
        },
        createdCell: function (cell, data) {
            if (data.column.dataKey === 'expenses') {
                cell.styles.halign = 'right';
                if (cell.raw > 600) {
                    cell.styles.textColor = [255, 100, 100];
                    cell.styles.fontStyle = 'bolditalic';
                }
                cell.text = '$' + cell.text;
            } else if (data.column.dataKey === 'country') {
                cell.text = cell.raw.split(' ')[0];
            }
        }
    });
    return doc;
};

// Custom style - shows how custom styles can be applied to tables
examples.spans = function () {
    var doc = new jsPDF('p', 'pt');
    doc.setFontSize(12);
    doc.setTextColor(0);
    doc.setFontStyle('bold');
    doc.text('Col and row span', 40, 50);
    var data = getData(80);
    data.sort(function (a, b) {
        return parseFloat(b.expenses) - parseFloat(a.expenses);
    });
    doc.autoTable(getColumns(), data, {
        theme: 'grid',
        startY: 60,
        drawRow: function (row, data) {
           
        	// Colspan
            doc.setFontStyle('bold');
            doc.setFontSize(10);
            if (row.index === 0) {
                doc.setTextColor(200, 0, 0);
                doc.rect(data.settings.margin.left, row.y, data.table.width, 20, 'S');
                doc.autoTableText("Priority Group", data.settings.margin.left + data.table.width / 2, row.y + row.height / 2, {
                    halign: 'center',
                    valign: 'middle'
                });
                data.cursor.y += 20;
            } else if (row.index === 5) {
                doc.rect(data.settings.margin.left, row.y, data.table.width, 20, 'S');
                doc.autoTableText("Other Groups", data.settings.margin.left + data.table.width / 2, row.y + row.height / 2, {
                    halign: 'center',
                    valign: 'middle'
                });
                data.cursor.y += 20;
            }

            if (row.index % 5 === 0) {
                var posY = row.y + row.height * 6 + data.settings.margin.bottom;
                if (posY > doc.internal.pageSize.height) {
                    doc.autoTableAddPage();
                }
            }
        },
        drawCell: function (cell, data) {
            // Rowspan
            if (data.column.dataKey === 'id') {
                if (data.row.index % 5 === 0) {
                    doc.rect(cell.x, cell.y, data.table.width, cell.height * 5, 'S');
                    doc.autoTableText(data.row.index / 5 + 1 + '', cell.x + cell.width / 2, cell.y + cell.height * 5 / 2, {
                        halign: 'center',
                        valign: 'middle'
                    });
                }
                return false;
            }
        }
    });
    return doc;
};

/*
 |--------------------------------------------------------------------------
 | Below is some helper functions for the examples
 |--------------------------------------------------------------------------
 */

// Returns a new array each time to avoid pointer issues
var getColumns = function () {
    return [
        {title: "ID", dataKey: "id"},
        {title: "Name", dataKey: "first_name"},
        {title: "Email", dataKey: "email"},
        {title: "City", dataKey: "city"},
        {title: "Country", dataKey: "country"},
        {title: "Expenses", dataKey: "expenses"}
    ];
};

// Uses the faker.js library to get random data.
function getData(rowCount) {
    rowCount = rowCount || 4;
    var sentence = faker.lorem.words(12);
    var data = [];
    for (var j = 1; j <= rowCount; j++) {
        data.push({
            id: j,
            first_name: faker.name.findName(),
            email: faker.internet.email(),
            country: faker.address.country(),
            city: faker.address.city(),
            expenses: faker.finance.amount(),
            text: shuffleSentence(sentence),
            text2: shuffleSentence(sentence)
        });
    }
    return data;
}

function shuffleSentence(words) {
    words = words || faker.lorem.words(8);
    var str = faker.helpers.shuffle(words).join(' ').trim();
    return str.charAt(0).toUpperCase() + str.slice(1);
}

// Use http://dopiaza.org/tools/datauri or similar service to convert an image into image data

//var headerImgData = 'data:image/jpg;base64,';

