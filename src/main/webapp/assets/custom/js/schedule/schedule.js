const birthdayWishes = [
    "Wishing you a day filled with love and laughter. Happy Birthday!",
    "May this year be filled with happiness and success. Happy Birthday!",
    "On your special day, may all your dreams come true. Happy Birthday!",
    "Another year older, but just as fabulous as ever. Happy Birthday!",
    "Here's to a year of new adventures and wonderful memories. Happy Birthday!",
    "May your birthday be as bright and beautiful as you are. Happy Birthday!",
    "Wishing you all the joy and love in the world on your birthday. Happy Birthday!",
    "A year wiser, a year bolder, and a year more amazing. Happy Birthday!",
    "To the world, you may be one person, but to me, you are the world. Happy Birthday!",
    "May your day be filled with surprises, laughter, and everything you love. Happy Birthday!",
    "On your special day, I hope you feel as cherished as you have made me feel. Happy Birthday!",
    "Wishing you a year of incredible experiences and great accomplishments. Happy Birthday!",
    "Today, we celebrate the incredible person you are. Happy Birthday!",
    "May your birthday be the start of a year filled with good luck, good health, and much happiness. Happy Birthday!",
    "Another year of laughter, joy, and adventure awaits. Happy Birthday!",
    "You're not getting older, you're getting better! Happy Birthday!",
    "May your day be as beautiful and bright as your smile. Happy Birthday!",
    "Wishing you a day of relaxation and happiness. Happy Birthday!",
    "Here's to a year filled with new opportunities and exciting possibilities. Happy Birthday!",
    "May your birthday be the beginning of a year filled with love and laughter. Happy Birthday!",
    "Every day with you is special, but today is a little extra special. Happy Birthday!",
    "You are a year older, a year wiser, and a year more incredible. Happy Birthday!",
    "Wishing you a day that's as wonderful as you are. Happy Birthday!",
    "May this year bring you everything your heart desires. Happy Birthday!",
    "Another year of making wonderful memories. Happy Birthday!",
    "Cheers to a fantastic year ahead! Happy Birthday!",
    "May your day be filled with love, laughter, and all the things that make you smile. Happy Birthday!",
    "You're not just a year older, you're a year more amazing. Happy Birthday!",
    "Wishing you the happiest of birthdays filled with love and joy. Happy Birthday!",
    "Today, we celebrate you and all the happiness you bring to our lives. Happy Birthday!",
    "May your birthday be the start of a year filled with great accomplishments. Happy Birthday!",
    "You're not getting older, you're getting better! Happy Birthday!",
];

let iconBirthdayCalendar = '<img style="position: absolute; right: 80%;" src="https://cdn-icons-png.flaticon.com/512/2985/2985632.png" class="cakeIconCalendar" alt="Cake" title="Cake" width="25" height="25">';

function debounce(func, delay) {
    let timer;
    return function () {
        const context = this;
        const args = arguments;
        clearTimeout(timer);
        timer = setTimeout(function () {
            func.apply(context, args);
        }, delay);
    };
}

function getBirthdayWishForDate(month, day) {
    const randomIndex = (month * day) % birthdayWishes.length;
    return birthdayWishes[randomIndex];
}

function replaceObjectById(array, objectId, newObject) {
    const index = array.findIndex((item) => item.id === objectId);
    if (index !== -1) {
        array[index] = newObject;
    }
}

let callingApi = false

const loadScheduleBtn = `<button class="btn btn-outline-none btn-load loadSchedule border-0" disabled>
                                                        <span class="d-flex align-items-center">
                                                            <span class="spinner-border flex-shrink-0"
                                                                  role="status">
                                                                <span class="visually-hidden">Loading...</span>
                                                            </span>
                                                        </span>
                       </button>`

function subtractDaysFromDate(inputDate) {
    let currentDate = new Date(inputDate);
    let year = currentDate.getFullYear();
    let month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
    let day = currentDate.getDate().toString().padStart(2, '0');
    return year + '-' + month + '-' + day;
}

function loadSchedule(){
    $("button.fc-today-button.btn.btn-primary").after(loadScheduleBtn)
}

function removeLoadSchedule(){
    $("button.loadSchedule").remove()
}
var start_date = document.getElementById("event-start-date"), timepicker1 = document.getElementById("timepicker1"),
    timepicker2 = document.getElementById("timepicker2"), date_range = null, T_check = null;
const baseUrlEvent = "/api/v1/events";
const codeDisabled = ["BIRTHDAY", "OPENED", "REOPENED", "REGISTERED","POSTPONED", "CLOSED"]
const codeEvents = ["HOLIDAY","SEMINAR","TEAM_BUILDING","MEETING","TRAINING","PARTY","OTHER",]
var statusCodePrevent = ["CLOSED", "REGISTERED", "POSTPONED"]
const BIRTHDAY_CODE = "BIRTHDAY"
const typeEnum = {
    "bg-danger text-light": "HOLIDAY",
    "bg-success text-light": "SEMINAR",
    "bg-secondary text-light": "TEAM_BUILDING",
    "bg-primary text-light": "MEETING",
    "bg-info text-light": "TRAINING",
    "bg-warning text-light": "PARTY",
    "bg-dark text-light": "OTHER",
};
let currentMonth = ""
var listBirthday = []

const birthdayIcon = '<img src="https://cdn-icons-png.flaticon.com/512/2985/2985632.png" class="cakeIcon" alt="Cake" title="Cake" width="44" height="44">'
function returnType(name){
    return typeEnum[name]
}

function getEventColor(code) {
    const bgToCode = {};
    for (const key in typeEnum) {
        const bgValue = typeEnum[key];
        bgToCode[bgValue] = key;
    }
    return bgToCode[code];
}

const taskCode = {
    'bg-soft-secondary': 'REGISTERED',
    'bg-soft-warning': 'OPENED',
    'bg-soft-danger' :'POSTPONED',
    'bg-soft-info' : 'REOPENED',
    'bg-soft-success' : 'CLOSED',
    'bg-soft-primary' :'BIRTHDAY'
}

function returnTaskCode(name){
    return taskCode[name]
}

function getStatusColor(code){
    const bgToCode = {};
    for (const key in taskCode) {
        const bgValue = taskCode[key];
        bgToCode[bgValue] = key;
    }
    return bgToCode[code];
}

function dateToString (date){
    return date.toISOString().slice(0, 10)
}



function subtractDays(date, days) {
    var newDate = new Date(date);
    newDate.setDate(newDate.getDate() - days);
    if (newDate.getDate() === 31 && [0, 2, 4, 6, 7, 9, 11].includes(newDate.getMonth())) {
        newDate.setDate(30);
    } else if (newDate.getDate() === 31 && newDate.getMonth() === 1) {
        if ((newDate.getFullYear() % 4 === 0 && newDate.getFullYear() % 100 !== 0) || newDate.getFullYear() % 400 === 0) {
            newDate.setDate(29);
        } else {
            newDate.setDate(28);
        }
    }

    if (newDate.getMonth() === 11) {
        newDate.setFullYear(newDate.getFullYear() - 1);
    }

    return newDate;
}

function addDays(date, days) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);

    while (result.getDate() !== (date.getDate() + days)) {
        result = new Date(result.getFullYear(), result.getMonth(), 0);
        days -= (date.getDate() + days - result.getDate());
        result.setDate(1);
        result.setMonth(result.getMonth() + 1);

        if (result.getMonth() === 1) {
            if ((result.getFullYear() % 4 === 0 && (result.getFullYear() % 100 !== 0 || result.getFullYear() % 400 === 0)) && result.getDate() > 29) {
                result.setDate(29);
            } else if (result.getDate() > 28) {
                result.setDate(28);
            }
        }

        if (result.getDate() > 30) {
            result.setDate(30);
        }
    }

    return result;
}

function originalStringDateToDate(originalDateISOString){
// Create a Date object from the ISO 8601 string
    const originalDate = new Date(originalDateISOString);
    return originalDate
}

function alertInput(text){
    let html =
        '<div class="col-12 mb-1 alert-danger">'+
        '<div class="alert alert-danger alert-dismissible alert-outline fade show mb-xl-0" role="alert">'+
        '<strong> '+text+' </strong>'+ '</div>'+
        '</div>'
    return html
}

function checkEmptyString(text){
    if (text.trim() === "" || !text) {
        return true;
    }
}

function deleteEvent(y, v, g) {
    let id = v._def.publicId
    callAjaxByJsonWithData(baseUrlEvent + "/" + id, "DELETE", null, function (rs){
        if(rs > 0) {
            if (v) {
                for (var t = 0; t < y.length; t++) y[t].id == v.id && (y.splice(t, 1), t--);
                // upcomingEvent(y),
                    v.remove(),
                    v = null,
                    g.hide()
                $("#deleteSuccessEvent").modal("show")
            }
            upcomingEvent(CALENDAR_RESULT)
        } else{
            refreshPage()
        }
        BtnLoadRemove()
    }, function (error){
        console.log("Error")
        console.log(error)
        BtnLoadRemove()
    })
}

function popupSuccess(text){
    var modal = `
                        <strong class="btn-success rounded-circle p-2">${text}.</strong> 
                        `
    $("#successComment div.modal-body p").html(modal)
    $("#successComment").modal("show");
}


function refreshPage() {
    location.reload();
}


var currentApiDate = ""
let idArr = window.location.href.split("/")
let userId = idArr[idArr.length-1].replaceAll("#","")
let CALENDAR_RESULT = []
function formatDate(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month + '-' + day;
}

function formatDateYYMM(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month
}



function flatPickrInit() {
    var e = {enableTime: !0, noCalendar: !0};
    flatpickr(start_date, {
        enableTime: !1, mode: "range", minDate: "today", onChange: function (e, t, n) {
            1 < t.split("to").length ? document.getElementById("event-time").setAttribute("hidden", !0) : (document.getElementById("timepicker1").parentNode.classList.remove("d-none"), document.getElementById("timepicker1").classList.replace("d-none", "d-block"), document.getElementById("timepicker2").parentNode.classList.remove("d-none"), document.getElementById("timepicker2").classList.replace("d-none", "d-block"), document.getElementById("event-time").removeAttribute("hidden"))
        }
    });
    flatpickr(timepicker1, e), flatpickr(timepicker2, e)
}

function flatpicekrValueClear() {
    start_date.flatpickr().clear(), timepicker1.flatpickr().clear(), timepicker2.flatpickr().clear()
}

function eventClicked() {
    document.getElementById("form-event").classList.add("view-event"),
        document.getElementById("event-title").classList.replace("d-block", "d-none"),
        document.getElementById("event-category").classList.replace("d-block", "d-none"),
        document.getElementById("event-start-date").parentNode.classList.add("d-none"),
        document.getElementById("event-start-date").classList.replace("d-block", "d-none"),
        document.getElementById("event-time").setAttribute("hidden", !0),
        document.getElementById("timepicker1").parentNode.classList.add("d-none"),
        document.getElementById("timepicker1").classList.replace("d-block", "d-none"),
        document.getElementById("timepicker2").parentNode.classList.add("d-none"),
        document.getElementById("timepicker2").classList.replace("d-block", "d-none"),
        document.getElementById("event-location").classList.replace("d-block", "d-none"),
        document.getElementById("event-description").classList.replace("d-block", "d-none"),
        document.getElementById("event-start-date-tag").classList.replace("d-none", "d-block"),
        document.getElementById("event-timepicker1-tag").classList.replace("d-none", "d-block"),
        document.getElementById("event-timepicker2-tag").classList.replace("d-none", "d-block"),
        document.getElementById("event-location-tag").classList.replace("d-none", "d-block"),
        document.getElementById("event-description-tag").classList.replace("d-none", "d-block"),
        document.getElementById("btn-save-event").setAttribute("hidden", !0)
}

function editEvent(e) {
    var t = e.getAttribute("data-id");
    "new-event" == t ? (document.getElementById("modal-title").innerHTML = "",
        document.getElementById("modal-title").innerHTML = "Add Event",
        document.getElementById("btn-save-event").innerHTML = "Add Event",
        eventTyped()) : "edit-event" == t ? (e.innerHTML = "Cancel",
        e.setAttribute("data-id", "cancel-event"),
        document.getElementById("btn-save-event").innerHTML = "Update Event",
        e.removeAttribute("hidden"), eventTyped()) : (e.innerHTML = "Edit",
        e.setAttribute("data-id", "edit-event"),
        eventClicked())
}

function eventTyped() {
    document.getElementById("form-event").classList.remove("view-event"), document.getElementById("event-title").classList.replace("d-none", "d-block"), document.getElementById("event-category").classList.replace("d-none", "d-block"), document.getElementById("event-start-date").parentNode.classList.remove("d-none"), document.getElementById("event-start-date").classList.replace("d-none", "d-block"), document.getElementById("timepicker1").parentNode.classList.remove("d-none"), document.getElementById("timepicker1").classList.replace("d-none", "d-block"), document.getElementById("timepicker2").parentNode.classList.remove("d-none"), document.getElementById("timepicker2").classList.replace("d-none", "d-block"), document.getElementById("event-location").classList.replace("d-none", "d-block"), document.getElementById("event-description").classList.replace("d-none", "d-block"), document.getElementById("event-start-date-tag").classList.replace("d-block", "d-none"), document.getElementById("event-timepicker1-tag").classList.replace("d-block", "d-none"), document.getElementById("event-timepicker2-tag").classList.replace("d-block", "d-none"), document.getElementById("event-location-tag").classList.replace("d-block", "d-none"), document.getElementById("event-description-tag").classList.replace("d-block", "d-none"), document.getElementById("btn-save-event").removeAttribute("hidden")
}

function upcomingEvent(e) {
    var currentDate = new Date()
    e.sort(function (e, t) {
        return new Date(e.start) - new Date(t.start)
    })
        let newArr = []
        e.map(event=>{
             if (event.start >=currentDate || event.end >=currentDate){
                 newArr.push(event)
             }
        })
        e = newArr
        document.getElementById("upcoming-event-list").innerHTML = null,
        Array.from(e).forEach(function (e) {
            var event = e
            var t = e.title,
                n = (l = e.end ? (endUpdatedDay = new Date(e.end)).setDate(endUpdatedDay.getDate() - 1) : l) || void 0;

            n = "Invalid Date" == n || null == n ? null : (a = new Date(n).toLocaleDateString("en", {
                year: "numeric",
                month: "numeric",
                day: "numeric"
            }), new Date(a).toLocaleDateString("en-GB", {
                day: "numeric",
                month: "short",
                year: "numeric"
            }).split(" ").join(" "));
            (e.start ? str_dt(e.start) : null) === (l ? str_dt(l) : null) && (n = null);
            var a = e.start,
                d = (a = "Invalid Date" === a || void 0 === a ? null : (d = new Date(a).toLocaleDateString("en", {
                    year: "numeric",
                    month: "numeric",
                    day: "numeric"
                }), new Date(d).toLocaleDateString("en-GB", {
                    day: "numeric",
                    month: "short",
                    year: "numeric"
                }).split(" ").join(" ")), n ? " to " + n : ""), n = e.className.split("-"), i = e.description || "",
                e = tConvert(getTime(e.start));
            l = (e == (l = tConvert(getTime(l))) && (e = "Full day event", l = null), l ? " to " + l : "");

            if(dateToString(originalStringDateToDate(event.start)) == dateToString(originalStringDateToDate(event.end))){
                d = ""
            }
            let typeHtml =  ""
            let codeType = ""
            if(codeDisabled.includes(event.code)){
                e = "Task"
                l= ""
                var startIndex = event.className.indexOf("-");
                codeType = event.className.substring(startIndex);
                typeHtml =  "<small class='badge badge"+ codeType +" ms-auto'>"+ event.code +"</small>"
            }else{
                let string = event.className.split(" ")[0]
                var startIndex = string.indexOf("-");
                codeType = event.className.substring(startIndex);
                typeHtml =  "<small class='badge bg"+ codeType +" ms-auto'>"+ event.code +"</small>"
                n[2] = "dark"
            }

            let iconBirthday = '<img '+
                ' src = "https://cdn-icons-png.flaticon.com/512/2985/2985632.png"'+
                ' className = "cakeIcon"'+
                ' alt = "Cake"'+
                ' title = "Cake"'+
                ' width = "25"'+
                ' height = "25" >'
            let xhtml = "<i class='mdi mdi-checkbox-blank-circle me-2 text-" + n[2] + "'>"

            if(event.code == BIRTHDAY_CODE){
                e = "HAPPY BIRTHDAY"
                l= ""
                xhtml = iconBirthday
            }

            u_event = "<div class='card mb-3'>                        " +
                "<div class='card-body'>                            " +
                "<div class='d-flex mb-3'>                                " +
                "<div class='flex-grow-1'>" + xhtml
                +
                "</i><span class='fw-medium'>" + a + d + " </span>" +
                "</div>                                " +
                "<div class='flex-shrink-0'>" +
                typeHtml +
                "</div>                           " +
                " </div>                            " +
                "<h6 class='card-title fs-16'> " + t + "</h6>                            " +
                "<p class='text-muted text-truncate-two-lines mb-0'> " + i + "</p>                       " +
                " </div>                   " +
                " </div>",
                document.getElementById("upcoming-event-list").innerHTML += u_event
        })
}

function getTime(e) {
    if (null != (e = new Date(e)).getHours()) return e.getHours() + ":" + (e.getMinutes() ? e.getMinutes() : 0)
}

function tConvert(e) {
    var e = e.split(":"), t = e[0], e = e[1], n = 12 <= t ? "PM" : "AM";
    return (t = (t %= 12) || 12) + ":" + (e = e < 10 ? "0" + e : e) + " " + n
}

var str_dt = function (e) {
    var e = new Date(e), t = "" + ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][e.getMonth()],
        n = "" + e.getDate(), e = e.getFullYear();
    return t.length < 2 && (t = "0" + t), [(n = n.length < 2 ? "0" + n : n) + " " + t, e].join(",")
};

var str_dt_end = function (e) {
    var e = new Date(e)
    e.setUTCDate(e.getUTCDate() - 1)
    var t = "" + ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][e.getMonth()],
        n = "" + e.getDate(), e = e.getFullYear();
    return t.length < 2 && (t = "0" + t), [(n = n.length < 2 ? "0" + n : n) + " " + t, e].join(",")
};

document.addEventListener("DOMContentLoaded", function () {
    flatPickrInit();
    var g = new bootstrap.Modal(document.getElementById("event-modal"), {keyboard: !1}),

        d = (document.getElementById("event-modal"), document.getElementById("modal-title")),

        i = document.getElementById("form-event"), v = null, p = document.getElementsByClassName("needs-validation"),

        e = new Date,
        t = e.getDate(),
        n = e.getMonth(),
        e = e.getFullYear(),
        a = FullCalendar.Calendar,
        l = document.getElementById("external-events"),
        e = (new a(l, {

        }),
            document.getElementById("calendar"));

    function o(e) {
        document.getElementById("form-event").reset(), document.getElementById("btn-delete-event").setAttribute("hidden", !0), g.show(), i.classList.remove("was-validated"), i.reset(), v = null, d.innerText = "Add Event", newEventData = e, document.getElementById("edit-event-btn").setAttribute("data-id", "new-event"), document.getElementById("edit-event-btn").click(), document.getElementById("edit-event-btn").setAttribute("hidden", !0)
    }

    function r() {
        return 768 <= window.innerWidth && window.innerWidth < 1200 ? "timeGridWeek" : window.innerWidth <= 768 ? "listMonth" : "dayGridMonth"
    }

    var c = new Choices("#event-category", {searchEnabled: !1})
    var configE = {
        timeZone: "local",
        editable: false,
        droppable: false,
        selectable: !0,
        navLinks: !0,
        initialView: r(),
        themeSystem: "bootstrap",
        fixedWeekCount: false,
        headerToolbar: {
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth"
        },
        windowResize: function (e) {
            var t = r();
            E.changeView(t)
        },
        eventResize: function (t) {
            var e = CALENDAR_RESULT.findIndex(function (e) {
                return e.id == t.event.id
            });
            CALENDAR_RESULT[e] && (CALENDAR_RESULT[e].title = t.event.title, CALENDAR_RESULT[e].start = t.event.start, CALENDAR_RESULT[e].end = t.event.end || null, CALENDAR_RESULT[e].allDay = t.event.allDay, CALENDAR_RESULT[e].className = t.event.classNames[0], CALENDAR_RESULT[e].description = t.event._def.extendedProps.description || "", CALENDAR_RESULT[e].location = t.event._def.extendedProps.location || "")
                // ,  upcomingEvent(CALENDAR_RESULT)
        },
        eventClick: function (e) {
            if(callingApi) return
            $("img.cakeIcon").remove()
            removeAlert()
            let codeEvent = e.event._def.extendedProps.code
            let idEvent = e.event._def.publicId
            let dateEvent = e.event._instance.range
            let checkAllDay = e.event._def.allDay
            document.getElementById("edit-event-btn").removeAttribute("hidden"),
                document.getElementById("btn-save-event").setAttribute("hidden", !0),
                document.getElementById("edit-event-btn").setAttribute("data-id", "edit-event")
            document.getElementById("edit-event-btn").innerHTML = "Edit"
            eventClicked(),
                flatPickrInit(),
                flatpicekrValueClear(),
                i.reset(),
                v = e.event,
                document.getElementById("modal-title").innerHTML = "",
                document.getElementById("event-location-tag").innerHTML = void 0 === v.extendedProps.location ? "No Location" : v.extendedProps.location,
                document.getElementById("event-description-tag").innerHTML = void 0 === v.extendedProps.description ? "No Description" : v.extendedProps.description,
                document.getElementById("event-title").value = v.title,
                document.getElementById("event-location").value = void 0 === v.extendedProps.location ? "No Location" : v.extendedProps.location,
                document.getElementById("event-description").value = void 0 === v.extendedProps.description ? "No Description" : v.extendedProps.description,
                document.getElementById("eventid").value = v.id, (c.destroy(),
                (c = new Choices("#event-category", {searchEnabled: !1})).setChoiceByValue(getEventColor(codeEvent)));
            let typeHtml =""
            if(codeDisabled.includes(codeEvent)) {
                let colorCode = getStatusColor(codeEvent)
                let startIndex = colorCode.indexOf("-");
                let codeType = colorCode.substring(startIndex);
                typeHtml =  "<small class='badge badge"+ codeType +" ms-auto p-2'>"+ codeEvent +"</small>"
                $("#edit-event-btn").addClass("d-none")
                $("#btn-delete-event").addClass("d-none")
                $("#btn-link-task").attr("data-id", idEvent)
                $("#btn-link-task").removeClass("d-none")
            } else{
                if(userCurrent.role === U_OWNER || userCurrent.role === U_MANAGER){
                    $("#edit-event-btn").removeClass("d-none")
                    $("#btn-delete-event").removeClass("d-none")
                }else{
                    $("#edit-event-btn").addClass("d-none")
                    $("#btn-delete-event").addClass("d-none")
                }
                let string = getEventColor(codeEvent).split(" ")[0]
                let startIndex = string.indexOf("-");
                let codeType = string.substring(startIndex);
                typeHtml =  "<small class='badge bg"+ codeType +" ms-auto p-2'>"+ codeEvent +"</small>"
                $("#btn-link-task").addClass("d-none")
            }
            document.getElementById("event-status-tag").innerHTML = typeHtml
            if(codeEvent === BIRTHDAY_CODE){
                let date = dateToString(originalStringDateToDate(dateEvent.start)).split("-")
                $("#event-modal .modal-title").before(birthdayIcon)
                $("#btn-link-task").addClass("d-none")
                console.log(date)
                document.getElementById("event-description-tag").innerHTML = getBirthdayWishForDate(date[1], date[2])
            }
            g.show()
            function t(e, check) {
                if(check){
                    e = subtractDays(e, 1)
                }
                var t = "" + ((e = new Date(e)).getMonth() + 1), n = "" + e.getDate();
                return [e.getFullYear(), t = t.length < 2 ? "0" + t : t, n = n.length < 2 ? "0" + n : n].join("-")
            }

            var e = v.start, n = v.end, a = null == n ? str_dt(e) : str_dt(e) + " to " + str_dt_end(n),
                e = null == n ? t(e, false) : t(e, false) + " to " + t(n, true),
                n = (flatpickr(start_date, {
                    defaultDate: checkAllDay ? e : e.split("to")[0],
                    altInput: !0,
                    altFormat: "j F Y",
                    dateFormat: "Y-m-d",
                    mode: "range",
                    onChange: function (e, t, n) {
                        1 < t.split("to").length
                            ?
                            document.getElementById("event-time").setAttribute("hidden", !0)
                            :  (document.getElementById("timepicker1").parentNode.classList.remove("d-none"),
                                document.getElementById("timepicker1").classList.replace("d-none", "d-block"),
                                document.getElementById("timepicker2").parentNode.classList.remove("d-none"),
                                document.getElementById("timepicker2").classList.replace("d-none", "d-block"),
                                document.getElementById("event-time").removeAttribute("hidden"))
                    }
                }),
                    document.getElementById("event-start-date-tag").innerHTML =
                        (dateToString(originalStringDateToDate(dateEvent.start)) == dateToString(originalStringDateToDate(dateEvent.end)))
                            ? a.split("to")[0] :
                            a ,
                    getTime(v.start)),
                e = getTime(v.end);

            n == e ? ( document.getElementById("event-timepicker1-tag").innerHTML="",
                document.getElementById("event-timepicker2-tag").innerHTML="" ,
                document.getElementById("event-time").setAttribute("hidden", !0),
                flatpickr(document.getElementById("timepicker1"), {
                    enableTime: !0,
                    noCalendar: !0,
                    dateFormat: "H:i"
                }), flatpickr(document.getElementById("timepicker2"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i"
            })) : (document.getElementById("event-time").removeAttribute("hidden"), flatpickr(document.getElementById("timepicker1"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i",
                defaultDate: n
            }), flatpickr(document.getElementById("timepicker2"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i",
                defaultDate: e
            }), document.getElementById("event-timepicker1-tag").innerHTML = tConvert(n),
                document.getElementById("event-timepicker2-tag").innerHTML = tConvert(e)),
                codeEvent === BIRTHDAY_CODE ?( document.getElementById("event-timepicker1-tag").innerHTML="",
                    document.getElementById("event-timepicker2-tag").innerHTML="") : "",
                newEventData = null, d.innerText = v.title, document.getElementById("btn-delete-event").removeAttribute("hidden")
        },
        dateClick: function (e) {
            if (callingApi) return
            if( userCurrent.role == U_MANAGER || userCurrent.role == U_OWNER){
                $("#btn-link-task").addClass("d-none")
                $("img.cakeIcon").remove()
                removeAlert()
                o(e)
            } else{
                return false
            }
        },
        events: null,
        dayCellDidMount: async function(arg) {
            if (listBirthday.includes(subtractDaysFromDate(arg.date))) {
                $("td[data-date='"+subtractDaysFromDate(arg.date)+"'] .fc-daygrid-day-top > a").after(iconBirthdayCalendar)
            }
        },
        datesSet: function(info) {
            return formatDateYYMM(info.view.currentStart)
        },
        viewDidMount: function (e){
            $("#containerSchedule").css("visibility", "visible");
            $("div.containerLoading").addClass("d-none")
        }
    }
    var   E = new FullCalendar.Calendar(e, configE)
    currentApiDate = formatDateYYMM(E.getDate())

    async function fetchCalendarData(userId, currentApiDate) {
        return new Promise((resolve, reject) => {
            callAjaxByJsonWithData(
                "/api/v1/schedules/" + userId + "?monthly=" + currentApiDate,
                "GET",
                null,
                (rs) => {
                    let CALENDAR_API = [];
                    if (rs) {
                        rs.list.forEach((item) => {
                            if (statusCodePrevent.includes(item.statusTask.code)) {
                                return;
                            }
                            if(item.statusTask.code == BIRTHDAY_CODE) {
                                if(!listBirthday.includes(item.startDate)){
                                    listBirthday.push(item.startDate)
                                }
                            }
                            CALENDAR_API.push({
                                id: item.id,
                                code: item.statusTask.code,
                                title: item.title,
                                start: new Date(item.startDate),
                                end: new Date(item.dueOrCloseDate),
                                allDay: !0,
                                className: getStatusColor(item.statusTask.code),
                            });
                        });
                        resolve(CALENDAR_API);
                    }
                },
                (error) => {
                    console.log("Error");
                    console.log(error);
                    reject(error);
                }
            );
        });
    }

    async function fetchEventApiData(currentApiDate) {
        return new Promise((resolve, reject) => {
            callAjaxByJsonWithData(
                baseUrlEvent + "?month=" + currentApiDate,
                "GET",
                null,
                (rs) => {
                    let EVENT_API = [];
                    if (rs && rs.length > 0) {
                        rs.forEach((item) => {
                            let data = {
                                id: item.id,
                                code: item.type.code,
                                title: item.title,
                                description: item.content,
                                start: originalStringDateToDate(item.startDate),
                                className: getEventColor(item.type.code),
                            }
                            if(dateToString(originalStringDateToDate(item.startDate)) == dateToString(originalStringDateToDate(item.endDate))){
                                data.allDay = false
                                data.end = originalStringDateToDate(item.endDate)
                            }else{
                                data.allDay = true
                                data.end = originalStringDateToDate(item.endDate)
                            }
                            EVENT_API.push(data)
                        });
                    }
                    resolve(EVENT_API);
                },
                (error) => {
                    console.log("Error");
                    console.log(error);
                    reject(error);
                }
            );
        });
    }

    async function fetchData() {
        try {
            const [calendarData, eventApiData] = await Promise.all([
                fetchCalendarData(userId, currentApiDate),
                fetchEventApiData(currentApiDate),
            ]);
            CALENDAR_RESULT = calendarData.concat(eventApiData)
            upcomingEvent(CALENDAR_RESULT)
            E.addEventSource(CALENDAR_RESULT);
            E.render()
            i.addEventListener("submit", function (e) {
                $("#btn-delete-event").prop("disabled", true)
                if(userCurrent.role == U_OWNER || userCurrent.role == U_MANAGER) {
                    e.preventDefault();
                    var t,
                        n,
                        e = document.getElementById("event-title").value,
                        a = document.getElementById("event-category").value,
                        d = document.getElementById("event-start-date").value.split("to"),
                        i = new Date(d[0].trim()),
                        l = d[1] ? new Date(d[1].trim()) : "", o = null,
                        r = document.getElementById("event-location").value,
                        c = document.getElementById("event-description").value,
                        s = document.getElementById("eventid").value,
                        m = !1,
                        u = (1 < d.length ? ((o = new Date(d[1])).setDate(o.getDate() + 1),
                            d = new Date(d[0]), m = !0) : (t = d, u = document.getElementById("timepicker1").value.trim(),
                            n = document.getElementById("timepicker2").value.trim(),
                            d = new Date(d + "T" + u), o = new Date(t + "T" + n)), CALENDAR_RESULT.length + 1);
                    !1 === p[0].checkValidity() ? p[0].classList.add("was-validated") :
                        (v
                            ? (
                                t = CALENDAR_RESULT.findIndex(function (e) {
                                    return e.id == v.id
                                }),
                                CALENDAR_RESULT[t] && (CALENDAR_RESULT[t].title = e,
                                    CALENDAR_RESULT[t].start = d,
                                    CALENDAR_RESULT[t].end = l != "" ? l : o,
                                    CALENDAR_RESULT[t].allDay = m,
                                    CALENDAR_RESULT[t].className = a,
                                    CALENDAR_RESULT[t].description = c,
                                    CALENDAR_RESULT[t].location = r),
                                    updateEvent(CALENDAR_RESULT[t], E, v, g)
                            )
                            : (n = {
                                id: u,
                                title: e,
                                start: d,
                                end: o,
                                allDay: m,
                                className: a,
                                description: c,
                                location: r
                            }, addEventFunc(n, g, E)))
                } else{
                    return false
                }
            })
            document.getElementById("btn-delete-event").addEventListener("click", function (e) {
                $("#deleteEventModal").modal("show")
            })

            document.getElementById("deleteEventBtn").addEventListener("click", function (e) {
                $("#deleteEventModal").modal("hide")
                $("#btn-delete-event").addClass("d-none")
                $("#btn-delete-event").before(BtnDangerLoad)
                if(userCurrent.role == U_OWNER || userCurrent.role == U_MANAGER) {
                    deleteEvent(CALENDAR_RESULT, v, g)
                } else{
                    return false
                }
            })

            let $elm = document.getElementsByClassName('fc-today-button')[0];
            $elm.addEventListener('click', function() {
                let month = formatDateYYMM(E.getDate())
                callApiData( month)
            });
        } catch (error) {
            console.error("An error occurred:", error);
        }
    }

    fetchData();
    const debouncedCallApiData = debounce(callApiData, 1000);
    $(document).on("change","table.filterStatus input", function(){
        let newArr = []
        let $element = $(this)
        if($element.val() === "ALL" && $element.prop("checked")){
            $("input.checkFilter").prop("checked", true)
        } else if($element.val() === "ALL" && !$element.prop("checked")){
            $("input.checkFilter").prop("checked", false)
            newArr = getFilter()
        } else {
            newArr = getFilter()
        }
        let apiDate = formatDateYYMM(E.getDate())
        statusCodePrevent  = newArr
        debouncedCallApiData(apiDate);
    })

    function getFilter(){
        let newArr = []
        $("table.filterStatus input").each(function(index, item ){
            if(!$(item).prop("checked") && $("input.allFilter").prop("checked")){
                $("input.allFilter").prop("checked", false)
                getFilter()
            }
            if(!$(item).prop("checked") && !$("input.allFilter").prop("checked")){
                newArr.push($(item).val())
            }
        })
        statusCodePrevent = newArr
        return newArr
    }


    $(document).on("click",".fc-header-toolbar button",function (){
        let month = formatDateYYMM(E.getDate())
        if(currentMonth != month){
            currentMonth = month
            callApiData(month)
        }
    })
    async function fetchDataButton(currentApiDate) {
        try {
            CALENDAR_RESULT =[]
            const [calendarData, eventApiData] = await Promise.all([
                fetchCalendarData(userId, currentApiDate),
                fetchEventApiData(currentApiDate),
            ]);
            CALENDAR_RESULT = calendarData.concat(eventApiData)
            E.getEventSources().forEach(eventSource => {
                eventSource.remove();
            });
            // upcomingEvent(CALENDAR_RESULT)
            E.addEventSource(CALENDAR_RESULT);
            E.render()
            removeLoadSchedule(CALENDAR_RESULT)
            return CALENDAR_RESULT;
        } catch (error) {
            console.error("An error occurred:", error);
        }
    }

    function callApiData(apiDate, g, textSuccess){
        callingApi = true
        loadSchedule()
        $("#containerSchedule input").prop("disabled", true)
        $("#containerSchedule button").prop("disabled", true)
        fetchDataButton(apiDate).then(r =>{
           if(r && g && textSuccess) {
               popupSuccess("The event created successfully")
               g.hide()
               $("#btn-save-event").removeClass("d-none")
               BtnLoadRemove()
           }
            $("#btn-delete-event").prop("disabled", false)
            $("#containerSchedule input").prop("disabled", false)
            callingApi = false
            $("#containerSchedule button").prop("disabled", false)
            listBirthday.forEach(day=>{
                $("td[data-date='"+day+"'] .fc-daygrid-day-top > a").after(iconBirthdayCalendar)
            })
        })
    }

    function updateEvent(event, calendar, v, g) {
        removeAlert()
        let type = returnType(event.className)
        let title = event.title
        let content = event.description
        let startDate = event.start
        let endDate = event.end
        let id = event.id
        if(startDate.toString() === "Invalid Date"){
            let html = alertInput("Start Time Invalid")
            if($("#event-start-date").val() == ""){
                $("#event-start-date").parent().parent().after(html)
            } else{
                $("#event-time").after(html)
            }
            return false
        }
        if(endDate.toString() === "Invalid Date"){
            let html = alertInput("End Time Invalid")
            $("#event-time").after(html)
            return false
        }
        if(startDate >= endDate){
            let html = alertInput("Start Time and End Time Invalid")
            $("#event-time").after(html)
            return false
        }
        $("#btn-save-event").addClass("d-none")
        $("#btn-save-event").before(BtnSuccessLoad)
        let data = {
            id: id,
            type: type,
            title: title,
            content: content,
            startDate: startDate,
        }
        if(dateToString(originalStringDateToDate(startDate)) == dateToString(originalStringDateToDate(endDate))){
            data.endDate = endDate
        } else{
            data.endDate = addDays(endDate, 1)
            event.end = addDays(event.end, 1)
        }

        callAjaxByJsonWithData(baseUrlEvent, "PUT", data, function (rs){
            if(rs > 0){
                event.code = type
                replaceObjectById(CALENDAR_RESULT, event.id, event)
                upcomingEvent(CALENDAR_RESULT)
                CALENDAR_RESULT =[]
                callApiData(currentMonth!=""? currentMonth : currentApiDate, g, "The event updated successfully")
            } else{
                refreshPage()
            }
        }, function (error){
            console.log("Error")
            console.log(error)
            $("#btn-save-event").removeClass("d-none")
            BtnLoadRemove()
        })
    }
    function addEventFunc(event, g){
        removeAlert()
        let type = returnType(event.className)
        let title = event.title
        let content = event.description
        let startDate = event.start
        let endDate = event.end
        if(startDate.toString() == "Invalid Date"){
            let html = alertInput("Start Time Invalid")
            if($("#event-start-date").val() == ""){
                $("#event-start-date").parent().parent().after(html)
            } else{
                $("#event-time").after(html)
            }
            return false
        }
        if(endDate.toString() == "Invalid Date"){
            let html = alertInput("End Time Invalid")
            $("#event-time").after(html)
            return false
        }
        if(startDate >= endDate){
            let html = alertInput("Start Time and End Time Invalid")
            $("#event-time").after(html)
            return false
        }
        $("#btn-save-event").addClass("d-none")
        $("#btn-save-event").before(BtnSuccessLoad)
        let data = {
            type: type,
            title: title,
            content: content,
            startDate: startDate,
            endDate: endDate,
        }
        callAjaxByJsonWithData(baseUrlEvent,"POST", data, async function (rs){
            if(rs){
                event.id = rs.id
                event.code = type
                CALENDAR_RESULT.push(event)
                upcomingEvent(CALENDAR_RESULT)
                CALENDAR_RESULT =[]
                callApiData(currentMonth!=""? currentMonth : currentApiDate, g, "The event created successfully")
            } else{
                $("#btn-save-event").removeClass("d-none")
                BtnLoadRemove()
            }
        }, function (error){
            console.log("Have Error")
            BtnLoadRemove()
            $("#btn-save-event").removeClass("d-none")
            console.log(error)
        })
    }

    $(document).on("click","#btn-link-task", function (){
        var dataId = $(this).attr("data-id");
        var newTabURL = "/tasks/" + dataId;
        window.open(newTabURL, '_blank');
    })
});


