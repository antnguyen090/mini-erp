<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link href="../../../assets/custom/css/common/style.css" rel="stylesheet">
    <script src="../../../assets/custom/js/task/task.js"></script>
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">DASHBOARD</h4>
            <c:if test="${requestScope.list != null}">
                <c:if test="${not empty requestScope.list}">
                    <marquee class="marquee-text" behavior="scroll" direction="left" scrollamount="15">
                        <img src="https://cdn-icons-png.flaticon.com/512/2985/2985632.png" class="cakeIconCalendar" alt="Cake" title="Cake" width="25" height="25">
                        Happy Birthday To
                        <c:forEach items="${requestScope.list}" var="person" varStatus="loop">
                            ${person.fullname}${!loop.last ? ', ' : ''}
                        </c:forEach>
                    </marquee>
                </c:if>
            </c:if>
        </div>
    </div>
</div>



<div class="row">
    <div class="col-12 background-content-color">
        <div class="row">
            <div class="col-xxl-4">
                <div class="card card-height-75">
                    <div class="card-header align-items-center d-flex">
                        <h4 class="card-title mb-0 flex-grow-1">Upcoming Activities</h4>
                        <div class="flex-shrink-0">
                            <div>
                                <a href="/schedules" class="">
                                    <img src="https://cdn-icons-png.flaticon.com/512/1968/1968779.png " width="25"
                                         height="25" alt="" title="" class="img-small">
                                </a>
                            </div>
                        </div>
                    </div><!-- end card header -->
                    <div class="card-body pt-0">
                        <ul class="list-group list-group-flush border-dashed" id="eventList" style="height: 235px">
                        </ul><!-- end -->
                        <div class="align-items-center mt-2 row g-3 text-center text-sm-start">
                            <div class="col-sm" id="showTotal">
                            </div>
                            <div class="col-sm-auto d-flex">
                                <div class="d-flex justify-content-center align-items-center d-none pageLoading me-2">
                                                <span class="spinner-grow flex-shrink-0" role="status">
                                                    <span class="visually-hidden"> Loading...</span>
                                                </span>
                                </div>
                                <ul class="pagination pagination-separated pagination-sm justify-content-center justify-content-sm-start mb-0"
                                    id="pagination">
                                </ul>
                            </div>
                        </div>
                    </div><!-- end card body -->
                </div><!-- end card -->
            </div>
            <div class="col-xxl-4">
                <div class="loader">
                    <span>ERP-MINI</span>
                    <span>ERP-MINI</span>
                </div>
            </div>
            <div class="col-xxl-4">
                <div class="card card-height-75">
                    <div class="card-header align-items-center d-flex">
                        <h4 class="card-title mb-0 flex-grow-1">My Tasks</h4>
                        <div class="flex-shrink-0">
                            <div>
                                <a href="/tasks" class="">
                                    <img src="https://cdn-icons-png.flaticon.com/512/2387/2387635.png " width="30"
                                         height="30" alt="" title="" class="img-small">
                                </a>
                            </div>
                        </div>
                    </div><!-- end card header -->

                    <div class="card-body p-0">

                        <div class="align-items-center p-3 justify-content-between d-flex">
                            <div class="flex-shrink-0">
                                <div class="text-muted ps-2"><span class="fw-semibold">Task doing</span>
                                </div>
                            </div>
                            <div class="flex-shrink-0">
                                <div class="text-muted float-end pe-3"><span class="fw-semibold">End date</span>
                                </div>
                            </div>
                        </div><!-- end card header -->

                        <div data-simplebar="init">
                            <div class="simplebar-wrapper" style="margin: 0px;">
                                <div class="simplebar-height-auto-observer-wrapper">
                                    <div class="simplebar-height-auto-observer"></div>
                                </div>
                                <div class="simplebar-mask">
                                    <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                        <div class="simplebar-content-wrapper" tabindex="0" role="region"
                                             aria-label="scrollable content"
                                             style="height: auto; overflow: hidden scroll;">
                                            <div class="simplebar-content" style="padding: 0px;">
                                                <ul class="list-group list-group-flush border-dashed px-3"
                                                    id="taskList">
                                                </ul><!-- end ul -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="simplebar-placeholder" style="width: auto; height: 200px;"></div>
                            </div>
                            <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                            </div>
                            <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                <div class="simplebar-scrollbar"
                                     style="height: 178px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                            </div>
                        </div>
                        <div class="p-3 pt-2">
                            <a href="/tasks" class="text-muted text-decoration-underline">Show more...</a>
                        </div>
                    </div><!-- end card body -->
                </div><!-- end card -->
            </div>
        </div>
        <div class="row">
            <div class="col-xxl-4">
                <div class="card">
                    <div class="card-header align-items-center d-flex">
                        <h4 class="card-title mb-0 flex-grow-1">Notifications</h4>
                        <div>
                            <a href="/notifications" class="">
                                <img src="https://cdn-icons-png.flaticon.com/512/4764/4764539.png " width="28"
                                     height="28" alt="" title="" class="img-small"> </a>
                        </div>
                    </div><!-- end card-header -->

                    <div class="card-body pt-0" id="notificationList" style="height: 300px">
                    </div><!-- end card body -->
                    <div class="mb-3 text-center"><a href="/notifications" class="text-muted text-decoration-underline">View
                        all News</a></div>
                </div><!-- end card -->
            </div>
            <div class="col-xxl-4">
                </video>
            </div>
            <div class="col-xxl-4">
                <div class="row">
                    <div class="col-xxl-6 col-sm-6">
                        <div class="card card-animate">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <p class="fw-medium text-muted mb-0">Opened Tasks</p>
                                        <h2 class="mt-4 ff-secondary fw-semibold"><span
                                                class="counter-value counter-opened-task" data-target="0">0</span></h2>
                                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i
                                                class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous
                                            month
                                        </p>
                                    </div>
                                    <div>
                                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-warning text-warning rounded-circle fs-4">
                                                    <i class="ri-briefcase-3-fill"></i>
                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- end card body -->
                        </div>
                    </div>
                    <div class="col-xxl-6 col-sm-6">
                        <div class="card card-animate">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <p class="fw-medium text-muted mb-0">Reopened Tasks</p>
                                        <h2 class="mt-4 ff-secondary fw-semibold"><span
                                                class="counter-value counter-reopened-task" data-target="0">0</span>
                                        </h2>
                                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i
                                                class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous
                                            month
                                        </p>
                                    </div>
                                    <div>
                                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-secondary text-secondary rounded-circle fs-4">
                                                    <i class="ri-arrow-go-back-line"></i>
                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- end card body -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    var htmlElement = document.documentElement;
    htmlElement.setAttribute("data-preloader", "block");
    const currentDay = new Date();

    const day = String(currentDay.getDate()).padStart(2, '0');
    const month = String(currentDay.getMonth() + 1).padStart(2, '0');
    const year = currentDay.getFullYear();

    const dateString = year + '-' + month + '-' + day;
    var tbodyElement = document.getElementById("notificationList");
    var eventBodyElement = document.getElementById("eventList");
    var taskBodyElement = document.getElementById("taskList");

    function loadPage(page) {
        $("div.pageLoading").removeClass("d-none");
        callAjaxByJsonWithData('/api/v1/events/upcoming?day=' + dateString + '&page=' + page, 'GET', null, function (rs) {
            if (rs) {
                let data = rs;
                let xhtml = "";
                data.list.forEach(function (event, index) {
                    xhtml += '<li class="list-group-item ps-0">' +
                        '<div class="row align-items-center g-3">' +
                        '<div class="col-auto" data-toggle="tooltip" data-bs-placement="bottom" title="' + getDayFromDate(event.startDate) + '">' +
                        '<div class="avatar-sm p-1 py-2 h-auto bg-light rounded-3">' +
                        '<div class="text-center">' +
                        '<h5 class="mb-0">' + getDayFromDate(event.startDate).getDate() + '</h5>' +
                        '<div class="text-muted">' + getDayOfWeek(event.startDate) + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col">' +
                        '<h5 class="text-muted mt-0 mb-1 fs-13">' + event.type.code + '</h5>' +
                        '<a style="cursor: default" class="text-reset fs-14 mb-0">' + event.title + '</a>' +
                        '</div>' +
                        '<div class="col-sm-auto">' +
                        '<div class="avatar-group">' +
                        '<div class="avatar-group-item">' +
                        '<a href="javascript: void(0);" class="d-inline-block" data-bs-toggle="tooltip" ' +
                        'data-bs-placement="top" title="" data-bs-original-title="Stine Nielsen">' +
                        '<img src="' + event.user.avatar + '" alt="" class="rounded-circle avatar-xxs">' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                })
                let showTotal = document.getElementById("showTotal");
                if (data.hasNext === false) {
                    showTotal.innerHTML = '<div class="text-muted">Showing <span class="fw-semibold">' + data.totalRecords + '</span> of <span class="fw-semibold">' + data.totalRecords + '</span> Results</div>'
                } else {
                    showTotal.innerHTML = '<div class="text-muted">Showing <span class="fw-semibold">' + (data.pageNumber * data.pageSize) + '</span> of <span class="fw-semibold">' + data.totalRecords + '</span> Results</div>'
                }
                eventBodyElement.innerHTML = xhtml;
                updatePagination(data, "pagination");
                $(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                })
                $("div.pageLoading").addClass("d-none");
            } else {
                console.log("Data API Error")
            }
        }, function (error) {
            console.log("Call API Error")
            console.log(error)
        })
    }

    function updatePagination(responseData, paginationId) {
        let pagination = document.getElementById(paginationId);
        let totalPages = responseData.totalPages;
        let currentPage = responseData.pageNumber;

        let paginationHTML = "";

        function createListItem(text, pageNumber, isDisabled) {
            return '<li class="page-item ' + (isDisabled ? 'disabled' : '') + '">' +
                '<a style="cursor: pointer" class="page-link" ' +
                'onclick="loadPage(' + pageNumber + ')">' + text + '</a></li>';
        }

        paginationHTML += createListItem('←', 1, !responseData.hasPrevious);

        for (let page = 1; page <= totalPages; page++) {
            paginationHTML += '<li class="page-item ' + (page === currentPage ? 'active' : '') + '">' +
                '<a style="cursor: pointer" class="page-link" ' +
                'onclick="loadPage(' + page + ')">' + page + '</a></li>';
        }

        paginationHTML += createListItem('→', totalPages, !responseData.hasNext);

        pagination.innerHTML = paginationHTML;

    }


    function getDayOfWeek(dateString) {
        const date = new Date(dateString);

        const dayOfWeek = date.getDay();

        const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        return days[dayOfWeek];
    }

    function getDayFromDate(dateString) {
        const date = new Date(dateString);
        return date;
    }

    document.addEventListener("DOMContentLoaded", function () {
        callAjaxByJsonWithData('/api/v1/notifications?page=1&pageSize=3', 'GET', null, function (rs) {
                if (rs) {
                    let data = rs;
                    let xhtml = "";
                    data.forEach(function (notification, index) {
                        xhtml += '<div class="d-flex align-middle mt-4">' +
                            '<div class="flex-shrink-0">' +
                            '<img src="assets/images/small/img-1.jpg" class="rounded img-fluid" style="height: 60px;" alt="">' +
                            '</div>' +
                            '<div class="flex-grow-1 ms-3">' +
                            '<h6 class="mb-1 lh-base"><a href="/notifications/' + notification.id + '" class="text-reset" target="_blank">' + notification.title + '</a></h6>' +
                            '<p class="text-muted fs-12 mb-0">' + notification.createdDate + ' <i class="mdi mdi-circle-medium align-middle mx-1"></i>' + notification.user.fullname + '</p>' +
                            '</div>' +
                            '</div><!-- end -->';
                    });
                    tbodyElement.innerHTML = xhtml
                } else {
                    console.log("Data API Error")
                }
            },
            function (error) {
                console.log("Call API Error")
                console.log(error)
            })
        callAjaxByJsonWithData('/api/v1/events/upcoming?day=' + dateString, 'GET', null, function (rs) {
            if (rs) {
                let data = rs;
                let xhtml = "";
                data.list.forEach(function (event, index) {
                    xhtml += '<li class="list-group-item ps-0">' +
                        '<div class="row align-items-center g-3">' +
                        '<div class="col-auto" data-toggle="tooltip" data-bs-placement="bottom" title="' + getDayFromDate(event.startDate) + '">' +
                        '<div class="avatar-sm p-1 py-2 h-auto bg-light rounded-3">' +
                        '<div class="text-center">' +
                        '<h5 class="mb-0">' + getDayFromDate(event.startDate).getDate() + '</h5>' +
                        '<div class="text-muted">' + getDayOfWeek(event.startDate) + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col">' +
                        '<h5 class="text-muted mt-0 mb-1 fs-13">' + event.type.code + '</h5>' +
                        '<a style="cursor: default" class="text-reset fs-14 mb-0">' + event.title + '</a>' +
                        '</div>' +
                        '<div class="col-sm-auto">' +
                        '<div class="avatar-group">' +
                        '<div class="avatar-group-item">' +
                        '<a style="cursor: default" class="d-inline-block" data-bs-toggle="tooltip" ' +
                        'data-bs-placement="top" title="" data-bs-original-title="Stine Nielsen">' +
                        '<img src="' + event.user.avatar + '" alt="" class="rounded-circle avatar-xxs">' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                })
                let showTotal = document.getElementById("showTotal");
                showTotal.innerHTML = '<div class="text-muted">Showing <span class="fw-semibold">' + data.list.length + '</span> of <span class="fw-semibold">' + data.totalRecords + '</span> Results</div>'
                eventBodyElement.innerHTML = xhtml;
                updatePagination(data, "pagination");
                $(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                })
            } else {
                console.log("Data API Error")
            }
        }, function (error) {
            console.log("Call API Error")
            console.log(error)
        })
        callAjaxByJsonWithData('/api/v1/tasks/opened/' + userCurrent.id, 'GET', null, function (rs) {
            if (rs) {
                let data = rs;
                let xhtml = "";
                data.responseList.forEach(function (task, index) {
                    xhtml += '<li class="list-group-item ps-0">' +
                        '<div class="d-flex align-items-start">' +
                        '<div class="flex-grow-1">' +
                        '<label class="form-check-label mb-0 ps-2" for="task_one"><a href="/tasks/' + task.id + '" target="_blank">' + task.title + '</a></label>' +
                        '</div>' +
                        '<div class="flex-shrink-0 ms-2">' +
                        '<p class="text-muted fs-12 mb-0">' + task.dueOrCloseDate + '</p>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                })
                $(".counter-opened-task").text(getTaskCountByCode(data.statusTaskCounts, T_OPENED));
                $(".counter-reopened-task").text(getTaskCountByCode(data.statusTaskCounts, T_REOPENED));
                taskBodyElement.innerHTML = xhtml;
            }
        }, function (error) {
            console.log("Call API Error")
            console.log(error)
        })
        htmlElement.setAttribute("data-preloader", "disable");
    })
</script>
</body>
</html>
