<%@ page import="com.webapp.erpapp.security.Principal" %>
<%@ page import="com.webapp.erpapp.enums.user.RoleEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<html>
<head>
    <title>Schedule Detail</title>
    <!-- fullcalendar css -->
    <link href="/assets/libs/fullcalendar/main.min.css" rel="stylesheet" type="text/css" />
    <style>
        #calendar .fc-event {
            cursor: pointer;
        }
        .full-height {
            min-height: 80vh;
        }
    </style>
</head>
<body>
<div class="row position-relative">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Schedule Detail</h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks management</a></li>
                    <li class="breadcrumb-item active">Schedule Detail</li>
                </ol>
            </div>
        </div>
    </div>
    <div style="width: 3rem; height: 3rem; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);" class="containerLoading d-flex align-items-center justify-content-center full-height">
        <div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <div id="containerSchedule" class="row" style="visibility: hidden">
        <div class="col-12">
            <div class="row">
                <div class="col-xl-3">
                    <div>
                        <h5 class="mb-2">Filter Status</h5>
                        <div class="card">
                            <!-- end card header -->
                            <div class="card-body">
                                <div class="table-responsive table-card">
                                    <table class="table table-sm table-borderless table-nowrap table-centered align-middle mb-0 filterStatus">
                                        <thead class="table-light text-muted">
                                        </thead>
                                        <!-- end thead -->
                                        <tbody>
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter allFilter" type="checkbox" value="ALL">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-dark">ALL</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter" type="checkbox" checked value="OPENED">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-warning">OPENED</span>
                                            </td>
                                        </tr>
                                        <!-- end -->
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter" type="checkbox" checked value="REOPENED">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-info">REOPENED</span>
                                            </td>
                                        </tr>
                                        <!-- end -->
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter" type="checkbox" value="REGISTERED">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-secondary">REGISTERED</span>
                                            </td>
                                        </tr>
                                        <!-- end -->
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter" type="checkbox" value="POSTPONED">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-danger">POSTPONED</span>
                                            </td>
                                        </tr>
                                        <!-- end -->
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15 checkFilter" type="checkbox" value="CLOSED">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-soft-success">CLOSED</span>
                                            </td>
                                        </tr>
                                        <!-- end -->
                                        </tbody>
                                        <!-- end tbody -->
                                    </table>
                                    <!-- end table -->
                                </div>
                            </div>
                            <!-- end cardbody -->
                        </div>
                        <!-- end card -->
                    </div>
                    <div>
                        <h5 class="mb-1">Upcoming Events</h5>
                        <p class="text-muted">Don't miss scheduled events</p>
                        <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 400px">
                            <div id="upcoming-event-list"></div>
                        </div>
                    </div>

                    <%--                <div class="card">--%>
                    <%--                    <div class="card-body bg-soft-info">--%>
                    <%--                        <div class="d-flex">--%>
                    <%--                            <div class="flex-shrink-0">--%>
                    <%--                                <i data-feather="calendar" class="text-info icon-dual-info"></i>--%>
                    <%--                            </div>--%>
                    <%--                            <div class="flex-grow-1 ms-3">--%>
                    <%--                                <h6 class="fs-15">Welcome to your Calendar!</h6>--%>
                    <%--                                <p class="text-muted mb-0">Event that applications book will appear here. Click on an event to see the details and manage applicants event.</p>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <%--                </div>--%>
                    <!--end card-->
                </div> <!-- end col-->

                <div class="col-xl-9">
                    <div class="card card-h-100">
                        <div class="card-body">
                            <div id="calendar"></div>
                        </div>
                    </div>
                </div><!-- end col -->
            </div>
            <!--end row-->

            <div style='clear:both'></div>

            <!-- Add New Event MODAL -->
            <div class="modal fade" id="event-modal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0">
                        <div class="modal-header p-3 bg-soft-info">
                            <h5 class="modal-title" id="modal-title">Event</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                        </div>
                        <div class="modal-body p-4">
                            <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                <div class="text-end">
                                    <a href="#" class="btn btn-sm btn-soft-primary" id="edit-event-btn" data-id="edit-event" onclick="editEvent(this)" role="button">Edit</a>
                                </div>
                                <div class="event-details">
                                    <div class="d-flex mb-2">
                                        <div class="flex-grow-1 d-flex align-items-center">
                                            <div class="flex-shrink-0 me-3">
                                                <i class="ri-calendar-event-line text-muted fs-16"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="d-block fw-semibold mb-0" id="event-start-date-tag"></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="ri-time-line text-muted fs-16"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="d-block fw-semibold mb-0"><span id="event-timepicker1-tag"></span> - <span id="event-timepicker2-tag"></span></h6>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mb-2 d-none">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="ri-map-pin-line text-muted fs-16"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="d-block fw-semibold mb-0"> <span id="event-location-tag"></span></h6>
                                        </div>
                                    </div>
                                    <div class="d-flex mb-2">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="ri-flashlight-line text-muted fs-16"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="d-block text-muted mb-0" id="event-status-tag"></p>
                                        </div>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="ri-discuss-line text-muted fs-16"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="d-block text-muted mb-0" id="event-description-tag"></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="row event-form">
                                    <div class="col-12">
                                        <div class="mb-3">
                                            <label class="form-label">Type</label>
                                            <select class="form-select d-none" name="category" id="event-category" required>
                                                <option value="bg-danger text-light">Holiday</option>
                                                <option value="bg-success text-light">Seminar</option>
                                                <option value="bg-secondary text-light">Team building</option>
                                                <option value="bg-primary text-light">Meeting</option>
                                                <option value="bg-info text-light">Training</option>
                                                <option value="bg-warning text-light">Party</option>
                                                <option value="bg-dark text-light">Other</option>
                                            </select>
                                            <div class="invalid-feedback">Please select a valid event category</div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-12">
                                        <div class="mb-3">
                                            <label class="form-label">Event Title</label>
                                            <input class="form-control d-none" placeholder="Enter event name" type="text" name="title" id="event-title" required value="" />
                                            <div class="invalid-feedback">Please provide a valid event title</div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-12">
                                        <div class="mb-3">
                                            <label>Event Date</label>
                                            <div class="input-group d-none">
                                                <input type="text" id="event-start-date" class="form-control flatpickr flatpickr-input" placeholder="Select date" readonly required>
                                                <span class="input-group-text"><i class="ri-calendar-event-line"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-12" id="event-time">
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Start Time</label>
                                                    <div class="input-group d-none">
                                                        <input id="timepicker1" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select start time" readonly>
                                                        <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="mb-3">
                                                    <label class="form-label">End Time</label>
                                                    <div class="input-group d-none">
                                                        <input id="timepicker2" type="text" class="form-control flatpickr flatpickr-input" placeholder="Select end time" readonly>
                                                        <span class="input-group-text"><i class="ri-time-line"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-12 d-none">
                                        <div class="mb-3">
                                            <label for="event-location">Location</label>
                                            <div>
                                                <input type="text" class="form-control d-none" name="event-location" id="event-location" placeholder="Event location">
                                            </div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <input type="hidden" id="eventid" name="eventid" value="" />
                                    <div class="col-12">
                                        <div class="mb-3">
                                            <label class="form-label">Description</label>
                                            <textarea class="form-control d-none" id="event-description" placeholder="Enter a description" rows="3" spellcheck="false" required></textarea>
                                            <div class="invalid-feedback">Please provide a valid event description</div>
                                        </div>
                                    </div>
                                    <!--end col-->
                                </div>
                                <!--end row-->
                                <div class="hstack gap-2 justify-content-end">
                                    <button type="button" class="btn btn-primary" id="btn-link-task">Link to task</button>
                                    <button type="button" class="btn btn-soft-danger" id="btn-delete-event"><i class="ri-close-line align-bottom"></i> Delete</button>
                                    <button type="submit" class="btn btn-success" id="btn-save-event">Add Event</button>
                                </div>
                            </form>
                        </div>
                    </div> <!-- end modal-content-->
                </div> <!-- end modal dialog-->
            </div> <!-- end modal-->
            <!-- end modal-->
        </div>
    </div> <!-- end row-->
</div>
<div class="modal fade zoomIn" id="deleteSuccessEvent" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Inform</h4>
                        <p class="text-muted mx-4 mb-0">
                            The event has been deleted successfully.
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="successComment" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/tqywkdcz.json" trigger="hover" style="width:150px;height:150px">
                    </lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Successful !</h4>
                        <p class="text-muted mx-4 mb-0">
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="deleteEventModal" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you Sure?</h4>
                        <p class="text-muted mx-4 mb-0">
                            Are you Sure You want to Remove this Event?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteEventBtn">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/libs/choices.js/public/assets/scripts/choices.min.js"></script>
<script type="text/javascript" src="/assets/libs/flatpickr/flatpickr.min.js"></script>
<!-- calendar min js -->
<script src="/assets/libs/fullcalendar/main.min.js"></script>
<!-- Calendar init -->
<script src="/assets/custom/js/schedule/schedule.js"></script>
</body>
</html>
