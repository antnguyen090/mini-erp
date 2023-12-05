

function convertMaxFileSize(string) {
    var maxFileSizeWithoutMB = string.replace("MB", "");
    return parseFloat(maxFileSizeWithoutMB) * 1024 * 1024;
}

function loadFilesName(fileNameArr) {
    $("div.fileLoading").removeClass("d-none");
    let html = ""
    handleFiles(fileNameArr, function handleEachFunc(fileName, fileSize, url) {
        html += showFileUploaded(fileName, fileSize, url, "view")
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        })
        $("#viewAccount .showFilesUploaded").html(html)
    })
    $("div.fileLoading").addClass("d-none");
}


function goBack() {
    window.location.replace(document.referrer);
}

function formattedDateToText(inputDate) {
    const dateObj = new Date(inputDate);

    const monthNames = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    const day = dateObj.getDate();
    const month = monthNames[dateObj.getMonth()];
    const year = dateObj.getFullYear();

    return day + " " + month + ', ' + year;
}

function formattedDate(inputDate) {
    if (inputDate !== null) {
        const dateObj = new Date(inputDate);

        const year = dateObj.getFullYear();
        let month = dateObj.getMonth() + 1;
        let day = dateObj.getDate();

        month = month < 10 ? "0" + month : month;
        day = day < 10 ? "0" + day : day;

        return year + "-" + month + "-" + day;
    } else return "";
}

function convertPayDate(inputString) {
    const [datePart, timePart] = inputString.split(' ');
    const [day, month, year] = datePart.split('/');

    document.getElementById("editPayDate").value = `${year}-${month}-${day}`;
}