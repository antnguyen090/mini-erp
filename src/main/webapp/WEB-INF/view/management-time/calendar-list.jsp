<%@ page import="com.webapp.erpapp.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<!DOCTYPE html>
<html>
<head>
    <style>
        .calendar {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            text-align: center;
        }

        .seven_day {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            text-align: center;
        }

        .calendar .day {
            border: 1px solid #ccc;
            padding: 5px;
        }

        .seven_day .day {
            border: 1px solid #ccc;
            padding: 5px;
        }

        td {
            max-width: 40px;
        }

        tr td:first-child {
            max-width: 80px;
        }

        tr.theSingleMostImportantThing {
            background-color: white;
        }

        tr.lecture {
            background-color: #fcecec;
        }

        tr.dailyEvaluation {
            background-color: #e6f0e2;
        }

        tr.work {
            background-color: #fff9e6;
        }

        tr.reading {
            background-color: #e9e4f5;
        }

        th {
            background-color: #f3f3f3;
        }

        tr > th {
            color: #333333;
            font-size: 20px;
        }

    </style>
    <style>
        /* Tùy chỉnh kiểu của trang loading */
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .full-height {
            min-height: 80vh;
        }
    </style>
    <title>Calendars</title>
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">MANAGEMENT TIME CALENDAR</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <c:if test="${userRole != 'DEVELOPER'}">
                        <li class="breadcrumb-item"><a href="/management-time">Management Time</a></li>
                    </c:if>
                    <li class="breadcrumb-item active">Management Time Calendar</li>
                </ol>
            </div>

        </div>
    </div>
    <div style="width: 3rem; height: 3rem; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);" class="containerLoading d-flex align-items-center justify-content-center">
        <div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <div class="bg-white calendar-container d-none">
        <h1 class="text-center" id="currentMonthYear"></h1>
        <table class="table table-nowrap table-bordered" id="todoTable">
            <thead>
            <tr class="text-center week">
                <th scope="col"></th>
                <th scope="col" class="text-danger">Sun</th>
                <th scope="col">Mon</th>
                <th scope="col">Tue</th>
                <th scope="col">Wed</th>
                <th scope="col">Thu</th>
                <th scope="col">Fri</th>
                <th scope="col" class="text-primary">Sat</th>
                <th scope="col" class="text-success">Weekly To-do List</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div class="d-flex justify-content-center">
            <button id="prevMonth" class="btn btn-info">Previous Month</button>
            <button id="nextMonth" class="btn btn-info ms-4">Next Month</button>
        </div>
    </div>
</div>
<div class="modal fade" id="weeklyToDo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Weekly To-do List</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group content">
                        <label for="mostImportant">The Single Most Important Thing:</label>
                        <input type="text" class="form-control contentData" id="mostImportant">
                    </div>
                    <div class="form-group content">
                        <label for="lecture">Lecture:</label>
                        <input type="text" class="form-control contentData" id="lecture">
                    </div>
                    <div class="form-group content">
                        <label for="dailyEvaluation">Daily Evaluation:</label>
                        <input type="text" class="form-control contentData" id="dailyEvaluation">
                    </div>
                    <div class="form-group content">
                        <label for="work">Work:</label>
                        <input type="text" class="form-control contentData" id="work">
                    </div>
                    <div class="form-group content">
                        <label for="reading">Reading:</label>
                        <input type="text" class="form-control contentData" id="reading">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary saveWeeklyToDo">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    const numberOfRowsPerWeek = 6;
    const table = document.getElementById('todoTable');
    const currentMonthYear = document.getElementById('currentMonthYear');
    const prevMonthBtn = document.getElementById('prevMonth');
    const nextMonthBtn = document.getElementById('nextMonth');
    const dayCodeTrTag = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];

    const currentDate = new Date();
    // const previousMonthDate = new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, currentDate.getDate());
    // const nextMonthDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, currentDate.getDate());

    var rsSuccess = (text) =>{
        Swal.fire({
            html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/lupuorrc.json" trigger="loop" colors="primary:#0ab39c,secondary:#405189" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Well done !</h4><p class="text-muted mx-4 mb-0">'+ text +' successfully</p></div></div>',
            showCancelButton: !0,
            showConfirmButton: !1,
            customClass: {
                cancelButton: 'btn btn-primary w-xs mb-1'
            },
            cancelButtonText: "Back",
            buttonsStyling: !1,
            showCloseButton: !0
        })
    }
    var rsUnSuccess = () =>{
        Swal.fire({
            html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/tdrtiskw.json" trigger="loop" colors="primary:#f06548,secondary:#f7b84b" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Oops...! Something went Wrong !</h4><p class="text-muted mx-4 mb-0">Try Again</p></div></div>',
            showCancelButton: !0,
            showConfirmButton: !1,
            customClass: {
                cancelButton: 'btn btn-primary w-xs mb-1'
            },
            cancelButtonText: "Dismiss",
            buttonsStyling: !1,
            showCloseButton: !0
        })
    }

    $(document).on("click", ".saveWeeklyToDo", function () {
        let target = $(this)
        target.addClass("d-none")
        target.before(BtnPrimaryLoad)
        let id = $("#weeklyToDo").attr("data-id")
        let content = ""
        let arrContent = []
        $("#weeklyToDo .contentData").each(function (index) {
            content += $(this).val();
            arrContent.push($(this).val())
            if (index < $("#weeklyToDo .contentData").length - 1) {
                content += ",";
            }
        })
        let data = {
            id: id,
            content: content,
        }
        callAjaxByJsonWithData('/api/v1/weekly-management-time-day', 'PUT', data, function (rs) {
            if (rs === 1) {
                let selector = '.showWeeklyUpdate[data-id="' + id + '"]'
                let button = $(selector)
                let indexMain = parseInt(button.parent().parent().index()) / 6
                arrContent.forEach((item, index) => {
                    let selector = 'tr.' + dayCodeTrTag[index]
                    $(selector).eq(indexMain).children().last().text(item)
                })
                $("#weeklyToDo").modal("hide")
                rsSuccess("Save")
            } else{
                rsUnSuccess()
            }
            BtnLoadRemove()
            target.removeClass("d-none")
        })
    })

    $(document).on("click", "button.showWeeklyUpdate", function () {
        let target = $(this)
        target.addClass("d-none")
        target.before(BtnPrimaryLoad)
        let id = target.attr("data-id")
        let modal = $("#weeklyToDo")
        modal.attr("data-id", id)
        callAjaxByJsonWithData('/api/v1/weekly-management-time-day/' + id, 'GET', null, function (rs) {
            if (rs.weeklyContents != null) {
                $("#weeklyToDo div.content > input").each(function (index) {
                    $(this).val(rs.weeklyContents[index])
                })
            }
            target.removeClass("d-none")
            BtnLoadRemove()
            modal.modal("show")
        })
    })

    function getWeeksInMonth(year, month) {
        const firstDayOfMonth = new Date(year, month, 1);

        const lastDayOfMonth = new Date(year, month + 1, 0);

        const daysInMonth = lastDayOfMonth.getDate();

        const firstWeekStart = firstDayOfMonth.getDay();

        return Math.ceil((daysInMonth + firstWeekStart) / 7);
    }

    function populateCalendar(year, month, button) {
        const result = getFirstSundayLastSaturday(year, month);
        const formattedFirstSunday = formatDate(result.firstSunday);
        const formattedLastDay = formatDate(result.lastDay);
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "/api/v1/management-time/" + "${requestScope.user.id}" + "?startDate=" + formattedFirstSunday + "&endDate=" + formattedLastDay, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var responseData = JSON.parse(xhr.responseText);
                    // Clear the table
                    table.querySelector('tbody').innerHTML = '';

                    // Set the date to the 1st day of the specified month
                    let startDateOfCurrentDate = new Date(year, month, 1);

                    // Update the display for the current month and year
                    const options = {year: 'numeric', month: 'long'};
                    currentMonthYear.textContent = "Calendar of " + startDateOfCurrentDate.toLocaleDateString('en-US', options);
                    currentMonthYear.classList.add('fst-italic','p-3');
                    var fullName = "${requestScope.user.fullname}";
                    var span = document.createElement("span");
                    span.textContent = "Username: " + fullName;
                    span.style.fontSize = "20px";
                    currentMonthYear.appendChild(document.createElement("br"));
                    currentMonthYear.appendChild(span);

                    // Calculate the starting day (Sunday to Saturday: 0 to 6)
                    const startDay = startDateOfCurrentDate.getDay();

                    // Get the number of days in the specified month
                    const daysInMonth = new Date(year, month + 1, 0).getDate();

                    // Calculate the last day of the previous month
                    const lastDayOfPreviousMonth = getLastDayOfPreviousMonth(year, month);

                    var countLine = -1;
                    // Populate the calendar
                    const tbody = table.querySelector('tbody');
                    const weeksInSpecificMonth = getWeeksInMonth(year, month) * numberOfRowsPerWeek;
                    for (let i = 0; i < weeksInSpecificMonth; i++) {
                        const row = document.createElement('tr');
                        for (let j = 0; j < 9; j++) {
                            const cell = document.createElement('td');
                            cell.classList.add("text-center")
                            cell.classList.add("align-middle")
                            if (i % 6 === 0) {
                                if (j === 0) {
                                    countLine += 1;
                                    cell.textContent = '';
                                } else if (j < 8) {
                                    const dayNumber = countLine * 7 + j - startDay;
                                    <%--if (dayNumber < 1) {--%>
                                    <%--    let found = false;--%>
                                    <%--    if (responseData != null && responseData.length > 0) {--%>
                                    <%--        responseData.forEach((e) => {--%>
                                    <%--            e.listDayOfWeek.forEach((week) => {--%>
                                    <%--                const dateInResponse = new Date(week.day);--%>
                                    <%--                if (--%>
                                    <%--                    currentDate.getFullYear() === dateInResponse.getFullYear() &&--%>
                                    <%--                    (lastDayOfPreviousMonth - startDay + j) === dateInResponse.getDate()--%>
                                    <%--                ) {--%>
                                    <%--                    const link = document.createElement('a');--%>
                                    <%--                    link.textContent = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--                    link.href = "${user.id}" + '/day/?id=' + week.id;--%>
                                    <%--                    cell.appendChild(link);--%>
                                    <%--                    found = true;--%>
                                    <%--                }--%>
                                    <%--            })--%>
                                    <%--        });--%>
                                    <%--    }--%>

                                    <%--    if (!found) {--%>
                                    <%--        const link = document.createElement('a');--%>
                                    <%--        link.textContent = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--        const year = currentDate.getFullYear();--%>
                                    <%--        const month = currentDate.getMonth() + 1;--%>

                                    <%--        var day = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--        var dayData = day < 10 ? "0" + day : day;--%>
                                    <%--        var monthData = (month - 1) < 10 ? '0' + (month - 1) : (month - 1);--%>
                                    <%--        link.href = "${user.id}" + "/day/?day=" + year + "-" + monthData + "-" + dayData;--%>
                                    <%--        cell.appendChild(link);--%>
                                    <%--    }--%>
                                    <%--} else --%>
                                        if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        let found = false;
                                        if (responseData != null && responseData.length > 0) {
                                            responseData.forEach((e) => {
                                                e.listDayOfWeek.forEach((week) => {
                                                    const dateInResponse = new Date(week.day);
                                                    if (
                                                        currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                        currentDate.getMonth() === dateInResponse.getMonth() &&
                                                        dayNumber === dateInResponse.getDate()
                                                    ) {
                                                        const link = document.createElement('a');
                                                        link.classList.add("p-2");
                                                        link.classList.add("fs-6");
                                                        link.textContent = dayNumber;
                                                        link.href = "${user.id}" + '/day/?id=' + week.id;
                                                        if (dayNumber === currentDate.getDate() && month === new Date().getMonth()) {
                                                            link.classList.add("badge", "badge-soft-danger","rounded-pill");
                                                        }
                                                        cell.appendChild(link);
                                                        found = true;

                                                    }
                                                })
                                            });
                                        }

                                        if (!found) {
                                            const link = document.createElement('a');
                                            link.textContent = dayNumber;
                                            link.classList.add("p-2");
                                            link.classList.add("fs-6");
                                            if (dayNumber === currentDate.getDate() && month === new Date().getMonth()) {
                                                link.classList.add("badge", "badge-soft-danger","rounded-pill");
                                            }
                                            const year = currentDate.getFullYear();
                                            const currentMonth = currentDate.getMonth() + 1;
                                            link.href = "${user.id}" + "/day/?day=" + year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + (dayNumber < 10 ? '0' + dayNumber : dayNumber);
                                            cell.appendChild(link);
                                        }
                                    }
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                } else {
                                    if (responseData != null && responseData.length > 0) {
                                        responseData.forEach((e) => {
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            var weekNumber;
                                            if (e.startDate === formattedFirstSunday) {
                                                weekNumber = 1;
                                            } else {
                                                weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            }
                                            if (weekNumber === ((i / 6) + 1)) {
                                                const link = document.createElement("button");
                                                link.textContent = "Edit";
                                                link.classList.add("btn");
                                                link.classList.add("btn-primary");
                                                link.classList.add("showWeeklyUpdate");
                                                link.setAttribute("data-id", e.weeklyId);
                                                cell.appendChild(link);
                                            }
                                        })
                                        cell.classList.add("fw-bold")
                                        cell.classList.add("fst-italic")
                                    }
                                }
                            } else {
                                if (j === 0) {
                                    // Đây là hàng đầu tiên của ngày trong tuần, có thể thêm tên thích hợp
                                    const dayNames = ['The Single Most Important Thing', 'Lecture', 'Daily Evaluation', 'Work', 'Reading'];
                                    const dayNamesCode = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];
                                    row.classList.add(dayNamesCode[(i % 6) - 1])
                                    cell.textContent = dayNames[(i % 6) - 1];
                                    cell.classList.add("text-wrap")
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                } else if (j < 8) {
                                    if (responseData != null && responseData.length > 0) {
                                        cell.classList.add("fst-italic")
                                        responseData.forEach((e) => {
                                            e.listDayOfWeek.forEach((week) => {
                                                const dateInResponse = new Date(week.day);
                                                const currentDay = countLine * 7 + j - startDay;
                                                const dayNames = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];
                                                if (
                                                    currentDate.getMonth() === dateInResponse.getMonth() &&
                                                    currentDay === dateInResponse.getDate()
                                                ) {
                                                    const dayTodo = dayNames[(i % 6) - 1];
                                                    const targetTodo = week.data.oneThingCalendar[dayTodo];
                                                    if (targetTodo != null) {
                                                        cell.textContent = targetTodo.target;
                                                    } else {
                                                        cell.textContent = "";
                                                    }
                                                }
                                            })
                                        })
                                    }
                                } else {
                                    if (responseData != null && responseData.length > 0) {
                                        cell.classList.add("fw-bold")
                                        cell.classList.add("fst-italic")
                                        responseData.forEach((e) => {
                                            if (e.weeklyContents === null) {
                                                return;
                                            }
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            var weekNumber;
                                            if (e.startDate === formattedFirstSunday) {
                                                weekNumber = 1;
                                            } else {
                                                weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            }
                                            if (weekNumber === (Math.floor((i / 6) + 1))) {
                                                cell.textContent = e.weeklyContents[(i % 6) - 1];
                                            }
                                        });
                                    }
                                }
                            }
                            row.appendChild(cell);
                        }
                        tbody.appendChild(row);
                        $('div.custom-spinner').parent().remove()
                        if (button) {
                            button.prop("disabled", false)
                        }
                        $(".containerLoading ").addClass("d-none")
                        $("div.calendar-container").removeClass("d-none")
                    }
                } else {
                    window.location.href = "/management-time/";
                }
            }

        }
        xhr.send();
    }

    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#prevMonth")
        currentDate.setMonth(currentDate.getMonth() - 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth(), button);
    });

    nextMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#nextMonth")
        currentDate.setMonth(currentDate.getMonth() + 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth(), button);
    });


    function getLastDayOfPreviousMonth(year, month) {
        if (month === 0) {
            year--;
            month = 11;
        } else {
            month--;
        }
        return new Date(year, month + 1, 0).getDate();
    }

    function getFirstSundayLastSaturday(year, month) {
        const firstSunday = getLastSundayOfPreviousMonth(year, month);
        const lastDay = new Date(year, month + 1, 0);

        return {
            firstSunday,
            lastDay
        };
    }

    function getLastSundayOfPreviousMonth(year, month) {
        const firstSundayIsBeginningDay = new Date(year, month, 1);
        const lastDayOfPreviousMonth = new Date(year, month, 0);
        if (firstSundayIsBeginningDay.getDay() === 0) {
            return firstSundayIsBeginningDay;
        }
        const lastDay = lastDayOfPreviousMonth.getDate();
        const lastSundayOfPreviousMonth = new Date(year, month - 1, lastDay - lastDayOfPreviousMonth.getDay());
        return lastSundayOfPreviousMonth;
    }

    function getFirstAndLastDateOfMonth(year, month) {
        const firstDay = new Date(year, month, 1);

        const lastDay = new Date(year, month + 1, 0);
        return {
            firstDay,
            lastDay
        };
    }

    function formatDate(date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }
</script>
</body>
</html>