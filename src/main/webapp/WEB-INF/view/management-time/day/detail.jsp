<%@ page import="com.webapp.erpapp.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/todo/");
%>
<c:set var="data" value="${dayResponse.data}" />
<c:set var="oneThingCalendar" value="${data.oneThingCalendar}" />
<c:set var="toDoList" value="${data.toDoList}" />
<c:set var="showButtonResult" value='${dayResponse!=null ? "" : "disabled"}'/>
<c:set var="infoButtonResult" value='${dayResponse!=null ? "Update" : "Create"}'/>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<html>
<head>
    <title>Detail of Day</title>
    <style>
        .full-height {
            min-height: 80vh;
        }
    </style>
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Management Time: <span class="fw-semibold text-success fst-italic">${dayResponse != null ? dayResponse.day : day}</span> </h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/management-time/${userId}">Management Time</a></li>
                    <li class="breadcrumb-item active">Management Time Day</li>
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
    <div class="row calendar-container d-none" data-date="${day}" data-id="${dayResponse.id}">
        <div class="card">
            <div class="row card-body">
                <div class="col-md-6">
                    <h4 class="fw-bolder">One Thing Calendar</h4>
                    <h5 class="fst-italic">Daily Important</h5>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th>Category</th>
                            <th>Target</th>
                            <th>Performance</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="theSingleMostImportantThing" value="${oneThingCalendar.theSingleMostImportantThing}" />
                        <tr name="theSingleMostImportantThing">
                            <td class="text-start">Single Most Important Thing</td>
                            <td><input class="form-control" type="text" value="${theSingleMostImportantThing.target}"></td>
                            <td><input class="form-check-input" type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}></td>
                        </tr>
                        <c:set var="lecture" value="${oneThingCalendar.lecture}" />
                        <tr name="lecture">
                            <td class="text-start">Lecture</td>
                            <td><input class="form-control" type="text" value="${lecture.target}"></td>
                            <td><input class="form-check-input" type="checkbox" ${lecture.performance ? 'checked' : ''}></td>
                        </tr>
                        <c:set var="dailyEvaluation" value="${oneThingCalendar.dailyEvaluation}" />
                        <tr name="dailyEvaluation">
                            <td class="text-start">Daily Evaluation</td>
                            <td><input class="form-control" type="text" value="${dailyEvaluation.target}"></td>
                            <td><input class="form-check-input" type="checkbox" ${dailyEvaluation.performance ? 'checked' : ''}></td>
                        </tr>
                        <c:set var="work" value="${oneThingCalendar.work}" />
                        <tr name="work">
                            <td class="text-start">Work</td>
                            <td><input class="form-control" type="text" value="${work.target}"></td>
                            <td><input class="form-check-input" type="checkbox" ${work.performance ? 'checked' : ''}></td>
                        </tr>
                        <c:set var="reading" value="${oneThingCalendar.reading}" />
                        <tr name="reading">
                            <td class="text-start">Reading</td>
                            <td><input class="form-control" type="text" value="${reading.target}"></td>
                            <td><input class="form-check-input" type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                        </tr>
                        </tbody>
                    </table>
                    <h4 class="fw-bolder">Gratitude Diary</h4>
                    <ul class="list-group mb-2" name="gratitudeDiary">
                        <c:forEach items="${data.gratitudeDiary}" var="entry" varStatus="loop">
                            <li class="list-group-item"><textarea class="form-control">${entry}</textarea></li>
                        </c:forEach>
                        <c:if test="${3-data.gratitudeDiary.size()>0}">
                            <c:forEach begin="1" end="${3-data.gratitudeDiary.size()}" varStatus="loop">
                                <li class="list-group-item"><textarea class="form-control"></textarea></li>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <h4 class="fw-bolder">Affirmation:</h4>
                    <textarea class="form-control affirmation">${data.affirmation}</textarea>
                </div>
                <div class="col-md-6 toDoList">
                    <h4 class="fw-bolder">To-Do List</h4>
                    <h5 class="fst-italic">Six to Twelve PM
                        <button class="btn btn-sm btn-primary ms-2 showDetail" data-name="sixToTwelvePm" ${showButtonResult}>Show Detail</button>
                    </h5>
                    <table class="table table-bordered sixToTwelvePm text-center align-middle">
                        <thead>
                        <tr>
                            <th>Target</th>
                            <th>Performance</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${toDoList.sixToTwelvePm}" var="entry" varStatus="loop">
                            <tr>
                                <td><input class="form-control" type="text" value="${entry.target}"></td>
                                <td><input class="form-check-input" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${4-toDoList.sixToTwelvePm.size()>0}">
                            <c:forEach begin="1" end="${4-toDoList.sixToTwelvePm.size()}" varStatus="loop">
                                <tr>
                                    <td><input class="form-control" type="text" value=""></td>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                    <h5 class="fst-italic">Twelve to Six PM
                        <button class="btn btn-sm btn-primary ms-2 showDetail" data-name="twelveToSixPm" ${showButtonResult}>Show Detail</button>
                    </h5>
                    <table class="table table-bordered twelveToSixPm text-center align-middle">
                        <thead>
                        <tr>
                            <th>Target</th>
                            <th>Performance</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${toDoList.twelveToSixPm}" var="entry" varStatus="loop">
                            <tr>
                                <td><input class="form-control" type="text" value="${entry.target}"></td>
                                <td><input class="form-check-input" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${4-toDoList.twelveToSixPm.size()>0}">
                            <c:forEach begin="1" end="${4-toDoList.twelveToSixPm.size()}" varStatus="loop">
                                <tr>
                                    <td><input class="form-control" type="text" value=""></td>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                    <h5 class="fst-italic">Six to Twelve AM
                        <button class="btn btn-sm btn-primary ms-2 showDetail" data-name="sixToTwelveAm" ${showButtonResult}>Show Detail</button>
                    </h5>
                    <table class="table table-bordered sixToTwelveAm text-center align-middle">
                        <thead>
                        <tr>
                            <th>Target</th>
                            <th>Performance</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${toDoList.sixToTwelveAm}" var="entry" varStatus="loop">
                            <tr>
                                <td><input class="form-control" type="text" value="${entry.target}"></td>
                                <td><input class="form-check-input" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${4-toDoList.sixToTwelveAm.size()>0}">
                            <c:forEach begin="1" end="${4-toDoList.sixToTwelveAm.size()}" varStatus="loop">
                                <tr>
                                    <td><input class="form-control" type="text" value=""></td>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 text-center align-middle">
                    <button class="btn btn-primary mr-2" id="backButton" onclick="window.location=document.referrer">Back</button>
                    <button class="btn btn-success ml-2" id="updateButton">${infoButtonResult}</button>
                </div>
            </div>
        </div>
    </div> <!-- end row-->
</div>

<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 30%;">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th class="align-middle">Q</th>
                        <th class="align-middle">Time Slot</th>
                        <th class="align-middle">Target</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <p class="mr-4 message-noti-day-detail" style="color:green;"></p>
                <button type="button" class="btn btn-primary" id="showDetailSubmit">Save changes</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<style>
    .container-fluid .form-check-input {
        font-size: 1.2rem;
    }

    textarea.form-control{
        min-height: 95px
    }
    textarea.affirmation{
        min-height: 155px
    }

    .form-check-input{
        margin: 0;
    }

</style>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        $(".containerLoading").addClass("d-none")
        $(".calendar-container").removeClass("d-none")
    })
    const M_SIX_TO_TWELVE_PM = 'SIX_TO_TWELVE_PM';
    const M_TWELVE_TO_SIX_PM = 'TWELVE_TO_SIX_PM';
    const M_SIX_TO_TWELVE_AM = 'SIX_TO_TWELVE_AM';

    const CodeToDetail = {
        "sixToTwelvePm" : "Six to Twelve PM",
        "twelveToSixPm" : "Twelve to Six PM",
        "sixToTwelveAm"  : "Six to Twelve AM"
    }
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
        let qresult = (name)=>{
            let array = {
                sixToTwelvePm: "6~12pm",
                twelveToSixPm: "12~6pm",
                sixToTwelveAm: "6~12am",
            }
            return array[name]
        }
        let interval = (name) =>{
            let intervalResult = []
            if(name == "sixToTwelvePm"){
                for (var i = 6; i < 12; i++) {
                    if (i === 11) {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "am");
                    }
                }
            }else if(name == "twelveToSixPm"){
                for (var i = 0; i <= 5; i++) {
                    if (i === 0) {
                        intervalResult.push(12 + "~" + (i+1) + "pm");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    }
                }
            }else{
                for (var i = 6; i < 12; i++) {
                    if (i == 11) {
                        intervalResult.push(i + "~" + (i + 1) + "am");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    }
                }
            }
            return intervalResult
        }
        let getCodeTime = (code)=>{
            let arr = {
                sixToTwelvePm: M_SIX_TO_TWELVE_PM,
                twelveToSixPm: M_TWELVE_TO_SIX_PM,
                sixToTwelveAm: M_SIX_TO_TWELVE_AM,
            }
            return arr[code]
        }
        $("#showDetailSubmit").click(function (){
            let target = $(this)
            target.addClass("d-none")
            target.before(BtnPrimaryLoad)
            $(".container-fluid button").each(function (){
                $(this).prop("disabled",true)
            })
            var dayId = $("div.calendar-container").attr("data-id")
            var codeData = $("#detailModal").attr("data-code")
            var code = getCodeTime(codeData)
            var targetArr = []
            $("#detailModal tr input.inputTarget").each(function() {
                let target = $(this).val()
                targetArr.push(target)
            })
            var data = {
                dayId: dayId,
                code: code,
                data:targetArr
            }

            callAjaxByJsonWithData('/api/v1/management-time-detail/exist/' + dayId, 'GET', null, function (rs) {
                if(!(typeof rs === 'boolean')){
                    $("button").each(function (){
                        $(this).prop("disabled",false)
                    })
                    target.removeClass("d-none")
                    BtnLoadRemove()
                    rsUnSuccess()
                    return
                }
                if(rs){ // update
                    callAjaxByJsonWithData('/api/v1/management-time-detail', 'PUT', data, function (rs) {
                        $("button").each(function (){
                            $(this).prop("disabled",false)
                        })
                        $("#detailModal").modal("hide")
                        target.removeClass("d-none")
                        BtnLoadRemove()
                        rsSuccess("Update")
                     });
                } else{ // create
                    callAjaxByJsonWithData('/api/v1/management-time-detail', 'POST', data, function (rs) {
                        $("button").each(function (){
                            $(this).prop("disabled",false)
                        })
                        $("#detailModal").modal("hide")
                        target.removeClass("d-none")
                        BtnLoadRemove()
                        rsSuccess("Update")
                    });
                }
            }, function (error){
                rsUnSuccess()
            });
        })
    $("button.showDetail").click(function (){
        $(this).addClass("d-none")
        $(this).after(BtnSmPrimaryLoad)
        $('.message-noti-day-detail').text('');
        var modal = $("#detailModal")
        var name = $(this).attr("data-name")
        var nameDisplay = CodeToDetail[name]
        $(".container-fluid button").each(function (){
            $(this).prop("disabled",true)
        })
        modal.attr("data-code",name )
        $("#detailModalLabel").text(nameDisplay)
        let arrayTime = interval(name)
        var code = getCodeTime(name)
        let html = '<tr>' +
            '<td rowspan="7" class="align-middle text-center">'+ qresult(name) +'</td>'+
            '</tr>'
        let idResponse = $(".calendar-container").attr("data-id")
        callAjaxByJsonWithData('/api/v1/management-time-detail/'+ idResponse +'/'+code, 'GET', null, function (rs) {
            if(rs.id != null) {
                if(rs.data != null) {
                    let data = rs.data;
                    if(arrayTime){
                        arrayTime.forEach((e, index)=>{
                            var dataOfArray = data[index];
                            if (data[index] == '' || data[index] == undefined) dataOfArray = '';
                            html+=
                                '<tr>'+
                                '<td class="align-middle">'+ e +'</td>'+
                                '<td><input type="text" class="form-control inputTarget" value="'+ dataOfArray + '" placeholder="Input target..."></td>'+
                                '</tr>'
                        })
                    }
                }
            }else{
                if (arrayTime) {
                    arrayTime.forEach((e) => {
                        html +=
                            '<tr>' +
                            '<td class="align-middle">' + e + '</td>' +
                            '<td><input type="text" class="form-control inputTarget" value="" placeholder="Input target..."></td>' +
                            '</tr>'
                    })
                }
            }
            BtnLoadRemove()
            $('button.showDetail').removeClass("d-none")
            $("#detailModal tbody").html(html)
            modal.modal("show")
            $("button").each(function (){
                $(this).prop("disabled",false)
            })
        })
    })

    $("#updateButton").click(function() {
        $(this).addClass("d-none")
        $(this).before(BtnSuccessLoad)
        var id = "${dayResponse.id}"
        var oneThingCalendar = {};
        $(".oneThingCalendar tr").each(function() {
            let name = $(this).attr("name")
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(name && target != ""){
                oneThingCalendar[name] = {
                    target: target,
                    performance: performance
                }
            }
        })
        var sixToTwelvePm = []
        var twelveToSixPm = []
        var sixToTwelveAm = []

        $("table.sixToTwelvePm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                  let newObject = {
                        target: target,
                      performance: performance
                    }
                sixToTwelvePm.push(newObject)
            }
        })

        $("table.twelveToSixPm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                let newObject = {
                    target: target,
                    performance: performance
                }
                twelveToSixPm.push(newObject)
            }
        })

        $("table.sixToTwelveAm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                let newObject = {
                    target: target,
                    performance: performance
                }
                sixToTwelveAm.push(newObject)
            }
        })

        var toDoList = {
            sixToTwelvePm: sixToTwelvePm,
            twelveToSixPm: twelveToSixPm,
            sixToTwelveAm: sixToTwelveAm,
        }

        var gratitudeDiary = []
        $('ul[name="gratitudeDiary"] textarea').each(function (){
            let text = $(this).val()
            if(text && text!=""){
                gratitudeDiary.push(text)
            }
        })
        var affirmation = $("textarea.affirmation").val()
        var dataInfor = {
            oneThingCalendar: oneThingCalendar,
            toDoList: toDoList,
            gratitudeDiary: gratitudeDiary,
            affirmation: affirmation
        }
        var apiUrlManagementTimeDayApi = "/api/v1/management-time/day"

        if("${day}" != "" && $("div.calendar-container").attr("data-id") == ""){
            dataCreate = {
                day: "${day}",
                userId: "${userId}",
                data: dataInfor
            }
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'POST', dataCreate, function (rs) {
                if(rs!=null){
                    rsSuccess("Create")
                    $("#updateButton").text("Update")
                    $("button.showDetail").prop("disabled",false)
                    $("div.calendar-container").attr("data-id", rs.id)
                    $("#updateButton").removeClass("d-none")
                    BtnLoadRemove()
                    return
                }
                rsUnSuccess()
            })
        }else if($("div.calendar-container").attr("data-id") != "") {
            var dataUpdate = {
                id: $("div.calendar-container").attr("data-id"),
                userId: userCurrent.id,
                data: dataInfor
            };
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'PUT', dataUpdate, function (rs) {
                if (rs != null) {
                    rsSuccess("Update")
                    $("#updateButton").removeClass("d-none")
                    BtnLoadRemove()
                    return
                }
                rsUnSuccess()
            })
        } else if("${day}" == ''){
            console.log("Error")
        }
    })
</script>
</body>
</html>
