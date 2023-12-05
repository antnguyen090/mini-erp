<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>User detail</title>
    <%-------------------- Css table -------------------%>

    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    <!--datatable css-->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css"/>

    <!--datatable responsive css-->
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">

    <!-- Filepond css -->
    <link rel="stylesheet" href="/assets/libs/filepond/filepond.min.css" type="text/css"/>
    <link rel="stylesheet" href="/assets/libs/filepond-plugin-image-preview/filepond-plugin-image-preview.min.css">
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Profile</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Human management</a></li>
                    <li class="breadcrumb-item active">Profile</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>

<form id="formUpdateUser">
    <%--==========================================New Code======================================================--%>
    <div class="position-relative mx-n4 mt-n4">
        <div class="profile-wid-bg profile-setting-img">
            <img src="/assets/images/profile-bg.jpg" class="profile-wid-img" alt="">
            <div class="overlay-content">
                <div class="text-end p-3">
                    <div class="p-0 ms-auto rounded-circle profile-photo-edit">
                        <%--                        <input id="profile-foreground-img-file-input" type="file"--%>
                        <%--                               class="profile-foreground-img-file-input">--%>
                        <%--                        <label for="profile-foreground-img-file-input" class="profile-photo-edit btn btn-light">--%>
                        <%--                            <i class="ri-image-edit-line align-bottom me-1"></i> Change Cover--%>
                        <%--                        </label>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-bottom: 60px;">
        <div class="col-xxl-3">
            <div class="card mt-n5">
                <div class="card-body p-4">
                    <div class="text-center">
                        <div class="profile-user position-relative d-inline-block mx-auto  mb-4">
                            <img src="${user.getAvatar()}" id="avatar-user"
                                 class="rounded-circle avatar-xl img-thumbnail user-profile-image"
                                 alt="user-profile-image">
                            <div class="avatar-xs p-0 rounded-circle profile-photo-edit">
                                <input id="profile-img-file-input" type="file" class="profile-img-file-input"
                                       name="avatar"
                                       accept="image/*" id="avatar">
                                <label for="profile-img-file-input" class="profile-photo-edit avatar-xs">
                                                    <span class="avatar-title rounded-circle bg-light text-body">
                                                        <i class="ri-camera-fill"></i>
                                                    </span>
                                </label>
                            </div>
                            <div id="delete-avatar-button"
                                 style="position: absolute; top: -8px; right: -8px; color: black; padding: 0px; cursor: pointer; display: none;">
                                <i class="ri-close-line" style="font-size: 15px"></i>
                            </div>
                        </div>
                        <h5 class="fs-16 mb-1">${user.fullname}</h5>
                        <p class="text-muted mb-0">${user.position.name} / ${user.department.name}</p>
                    </div>
                </div>
            </div>
            <!--end card-->
            <%--========================== Working Day =================================--%>
            <div class="card permission d-none">
                <div class="card-body" style="text-align: center">
                    <div class="d-flex align-items-center mb-4">
                        <div class="flex-grow-1">
                            <h5 class="card-title mb-0">Total Working Day</h5>
                        </div>
                    </div>
                    <div id="workingDaySession" style="display: none">
                        <div class="input-group">
                            <select class="form-control" id="working-year">
                                <option value="">-- Select year --</option>
                            </select>
                            <select class="form-control" id="working-month" style="display: none;">
                                <option>-- Select month --</option>
                            </select>
                        </div>
                        <div class="input-group mt-2">
                            <input type="text" class="form-control" id="totalWorkingDay" readonly
                                   placeholder="Result" disabled>
                        </div>
                    </div>
                    <div class="spinner-border text-primary" role="status" id="loadingWorking" style="display: none">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
            </div>
            <div class="card">
                <button type="button" class="btn btn-danger d-none" id="del-user-button">Delete User</button>
            </div>
        </div>
        <!--end col-->
        <div class="col-xxl-9">
            <div class="card mt-xxl-n5">
                <div class="card-header">
                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#basicInformationSession" role="tab">
                                <i class="fas fa-home"></i> Basic Information
                            </a>
                        </li>
                        <li class="nav-item permission d-none">
                            <a class="nav-link" data-bs-toggle="tab" href="#detailInformationSession" role="tab">
                                <i class="far fa-user"></i> Detail Information
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#resumeSession" role="tab">
                                <i class="far fa-envelope"></i> Resume
                            </a>
                        </li>
                        <li class="nav-item permission d-none">
                            <a class="nav-link" data-bs-toggle="tab" href="#contractSession" role="tab">
                                <i class="far fa-envelope"></i> Contract
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="card-body p-4">
                    <div class="tab-content">
                        <%--========================== Basic Information =================================--%>
                        <div class="tab-pane active" id="basicInformationSession" role="tabpanel">
                            <div class="row">
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">Username</label>
                                        <input type="text" class="form-control" placeholder="Enter Username"
                                               id="userName" name="fullname" value="${user.fullname}" required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <input type="number" class="form-control"
                                               id="phone" name="phone" placeholder="0123456789"
                                               value="${user.phone}" oninput="this.value = this.value.slice(0, 10)"
                                               required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="emergencyPhone" class="form-label">Emergency Phone</label>
                                        <input type="number" class="form-control"
                                               id="emergencyPhone" name="emergencyPhone" placeholder="0123456789"
                                               value="${user.emergencyPhone}"
                                               oninput="this.value = this.value.slice(0, 10)" required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="address1ControlTextarea" class="form-label">Address</label>
                                        <input type="text" class="form-control" placeholder="Address"
                                               id="address1ControlTextarea" name="address" value="${user.address}"
                                               required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="dateOfBirth" class="form-label">Date of birth</label>
                                        <input type="date" class="form-control" id="dateOfBirth"
                                               value="${user.dateOfBirth}" required>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="timeSheetsCode" class="form-label">TimeSheets Code</label>
                                        <input type="text" class="form-control"
                                               id="timeSheetsCode" name="timesheetsCode" value="${user.timesheetsCode}"
                                               readonly disabled>
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Gender</label>
                                        <select id="gender" class="form-select" name="gender" required>
                                            <option value="" selected>Choose...</option>
                                            <option value="MALE"
                                                    <c:if test="${user.gender.code.equals('MALE')}">selected</c:if>
                                            >Male
                                            </option>
                                            <option value="FEMALE"
                                                    <c:if test="${user.gender.code.equals('FEMALE')}">selected</c:if>
                                            >Female
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="hstack gap-2 justify-content-end">
                                        <button type="submit" class="btn btn-primary" id="updateBasic">
                                            Updates
                                        </button>
                                        <a class="btn btn-soft-success cancle-button">Cancel</a>
                                    </div>
                                </div>
                            </div><!--end row-->
                        </div>
                        <!--end tab-pane-->
                        <%--========================== Detail Information =================================--%>
                        <div class="tab-pane" id="detailInformationSession" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-6">
                                    <label for="type" class="form-label">Type</label>
                                    <select id="type" class="form-select" name="type">
                                        <option value="" selected>Choose...</option>
                                        <option value="OFFICIAL"
                                                <c:if test="${user.type.code.equals('OFFICIAL')}">selected</c:if>
                                        >Official
                                        </option>
                                        <option value="PROBATION"
                                                <c:if test="${user.type.code.equals('PROBATION')}">selected</c:if>
                                        >Probation
                                        </option>
                                        <option value="PARTTIME"
                                                <c:if test="${user.type.code.equals('PARTTIME')}">selected</c:if>
                                        >Parttime
                                        </option>
                                    </select>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="department" class="form-label">Department</label>
                                        <select id="department" class="form-select" name="department">
                                            <option value="" selected>Choose...</option>
                                            <option value="ADMINISTRATION"
                                                    <c:if test="${user.department.code.equals('ADMINISTRATION')}">selected</c:if>>
                                                Administration
                                            </option>
                                            <option value="MANAGEMENT"
                                                    <c:if test="${user.department.code.equals('MANAGEMENT')}">selected</c:if>>
                                                Management
                                            </option>
                                            <option value="UI_UX"
                                                    <c:if test="${user.department.code.equals('UI_UX')}">selected</c:if>>
                                                UI/UX
                                            </option>
                                            <option value="DEV1"
                                                    <c:if test="${user.department.code.equals('DEV1')}">selected</c:if>>
                                                Dev1
                                            </option>
                                            <option value="DEV2"
                                                    <c:if test="${user.department.code.equals('DEV2')}">selected</c:if>>
                                                Dev2
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label for="userId" class="form-label">User ID</label>
                                        <input type="email" class="form-control" id="userId"
                                               placeholder="Enter User Id" name="email" value="${user.email}">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label for="change-password-button" class="form-label">Password: </label>
                                        <a id="change-password-button" class="text-primary text-decoration-none"
                                           style="cursor: pointer;">Change password</a>
                                    </div>
                                </div>
                                <div class="col-6 hide" style="display: none">
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password*</label>
                                        <div class="position-relative auth-pass-inputgroup mb-3">
                                            <input type="password" class="form-control" placeholder="Enter new password"
                                                   id="newPassword" name="password">
                                            <small id="formatPassword" class="text-danger"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 hide" style="display: none;">
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password*</label>
                                        <div class="position-relative auth-pass-inputgroup mb-3">
                                            <input type="password" class="form-control" placeholder="Confirm password"
                                                   id="confirmPassword">
                                            <small id="messageErrorConfirm" class="text-danger"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="atm" class="form-label">ATM</label>
                                        <input type="text" class="form-control" placeholder="ATM" id="atm" name="atm"
                                               value="${user.atm}">
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="role" class="form-label">Role</label>
                                    <select id="role" class="form-select" name="role">
                                        <option selected>Choose...</option>
                                        <option value="OWNER"
                                                <c:if test="${user.role.code.equals('OWNER')}">selected</c:if>>
                                            Owner
                                        </option>
                                        <option value="MANAGER"
                                                <c:if test="${user.role.code.equals('MANAGER')}">selected</c:if>>
                                            Manager
                                        </option>
                                        <option value="DEVELOPER"
                                                <c:if test="${user.role.code.equals('DEVELOPER')}">selected</c:if>>
                                            Developer
                                        </option>
                                    </select>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="position" class="form-label">Position</label>
                                        <select id="position" class="form-select" name="position">
                                            <option value="" selected>Choose...</option>
                                            <option value="INTERN"
                                                    <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                                                Intern
                                            </option>
                                            <option value="JUNIOR"
                                                    <c:if test="${user.position.code.equals('JUNIOR')}">selected</c:if>>
                                                Junior
                                            </option>
                                            <option value="SENIOR"
                                                    <c:if test="${user.position.code.equals('SENIOR')}">selected</c:if>>
                                                Senior
                                            </option>
                                            <option value="MANAGER"
                                                    <c:if test="${user.position.code.equals('MANAGER')}">selected</c:if>>
                                                Manager
                                            </option>
                                            <option value="SENIOR_MANAGER"
                                                    <c:if test="${user.position.code.equals('SENIOR_MANAGER')}">selected</c:if>>
                                                Senior manager
                                            </option>
                                            <option value="OWNER"
                                                    <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                                                Owner
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="hstack gap-2 justify-content-end">
                                        <div id="error-message" class="text-danger text-xl-end"
                                             style="font-size: 15px"></div>
                                        <button type="submit" class="btn btn-primary" id="updateDetail">Updates
                                        </button>
                                        <a class="btn btn-soft-success cancle-button">Cancel</a>
                                    </div>

                                </div>
                            </div>
                            <!--end row-->
                        </div>
                        <!--end tab-pane-->
                        <%--========================== Resume =================================--%>
                        <div class="tab-pane" id="resumeSession" role="tabpanel">
                            <div class="row">
                                <c:forEach var="resume" items="${resumes}">
                                    <div class="col-md-2 mt-2 text-center delete-fileResume" style="position: relative">
                                                    <span class="custom-icon">
                                                        <i class="ri-file-3-line"
                                                           style="font-size: 75px; color: #4A86E8"></i>
                                                    </span>
                                        <br>
                                        <div class="resume-link">
                                            <a href="/upload/user/${resume}"
                                               class="cut-file-name fileName-Resume" data-bs-toggle="tooltip"
                                               data-bs-placement="bottom" title="${resume}">${resume}</a>
                                        </div>
                                        <div class="delete-fileResume-button"
                                             style="position: absolute;top: -8px;right: 40px;color: black;padding: 5px;cursor: pointer;display: block;">
                                            <i class="ri-close-circle-line" style="font-size: 20px; color: red"></i>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="row mt-2 border-top" id="uploadFileResume">
                                <div class="col-lg-12">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h4 class="card-title mb-0">Resume File Upload</h4>
                                                </div>
                                                <div class="card-body">
                                                    <input type="file" id="resumeFile"
                                                           class="filepond filepond-input-multiple"
                                                           data-allow-reorder="true" multiple>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2" id="alertFileType" style="display: none">
                                <!-- Alert Type File -->
                                <div class="alert alert-danger alert-border-left alert-dismissible fade show"
                                     role="alert">
                                    <%--Show Message Error--%>
                                </div>
                            </div>
                            <div class="hstack gap-2 justify-content-end">
                                <button type="submit" class="btn btn-primary" id="saveFileResume"
                                        onclick="addLoadingPrimary(this)" disabled>Save
                                </button>
                                <a class="btn btn-soft-success cancle-button" id="cancelFileResume">Cancel</a>
                            </div>
                        </div>
                        <!--end tab-pane-->
                        <%--========================== Contract =================================--%>
                        <div class="tab-pane" id="contractSession" role="tabpanel">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div id="customerList">
                                        <div class="row g-4 mb-3">
                                            <div class="col-sm-auto">
                                                <div>
                                                    <button type="button" class="btn btn-success add-btn"
                                                            id="add-contract-button"><i
                                                            class="ri-add-line align-bottom me-1"></i> Add
                                                    </button>
                                                </div>
                                            </div>

                                        </div>
                                        <table class="table align-middle table-nowrap table-striped-columns"
                                               id="contractTable">
                                            <thead class="table-light">
                                            <tr>
                                                <th>Basic Salary</th>
                                                <th width="200">Allowance</th>
                                                <th>Insurance</th>
                                                <th>File Contract</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody class="list form-check-all">
                                            <c:forEach var="contract" items="${contracts}">
                                                <tr>
                                                    <td>${contract.basicSalary}đ</td>
                                                    <td class="format-allowance" data-simplebar
                                                        style="max-height: 200px;">${contract.allowance}</td>
                                                    <td class="format-insurance">${contract.insurance}</td>
                                                    <td>
                                                        <c:set var="contractPath" value="${contract.getContract()}"/>
                                                        <c:set var="fileNameContract"
                                                               value="${contractPath.substring(contractPath.lastIndexOf('/') + 1)}"/>
                                                        <a href="${contractPath}" download target="_blank"
                                                           class="contractLink" data-bs-toggle="tooltip"
                                                           data-bs-placement="bottom" title="${fileNameContract}">
                                                                ${fileNameContract}
                                                        </a>
                                                    </td>

                                                    <td style="max-width: 125px">
                                                        <div class="row">
                                                            <div class="col-lg-12 text-center">
                                                                <button value="${contract.id}"
                                                                        class="btn btn-success edit-contract-btn">
                                                                    Edit
                                                                </button>
                                                                <button value="${contract.id}"
                                                                        class="btn btn-danger del-contract-btn"
                                                                >Remove
                                                                </button>
                                                            </div>
                                                            <div class="col-lg-12 mt-2 text-center">
                                                                <button value="${contract.id}"
                                                                        class="btn btn-warning w-lg history-contract-button"
                                                                >History Update
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!--end col-->
    </div>

    <%--Modal Delete File Resume--%>
    <div class="modal fade zoomIn show" id="deleteResumeModal" tabindex="-1" aria-modal="true" role="dialog"
         style="display: none;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                    ></button>
                </div>
                <div class="modal-body">
                    <div class="mt-2 text-center">
                        <i class="ri-file-reduce-line" style="font-size: 100px; color: red"></i>
                        <div class="mt-2 pt-2 fs-15 mx-4 mx-sm-5">
                            <h4>Are you Sure Remove this File ?</h4>
                        </div>
                    </div>
                    <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                        <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn w-sm btn-primary" id="confirm-del-resume"
                                onclick="addLoadingPrimary(this)">Yes, Delete It!
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<%--Modal Add Contract--%>
<form id="formAddContract">
    <div class="modal fade" id="addContractModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-light p-3">
                    <h5 class="modal-title" id="exampleModalLabel">Add Contract</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                            id="close-modal"></button>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="addBasicSalary" class="form-label">Basic Salary:</label>
                            <input type="text" class="form-control" id="addBasicSalary" name="basicSalary"
                                   oninput="formatNumber(this)" required/>
                        </div>
                        <div class="mb-3">
                            <label id="valAllowance">Allowance:</label>
                            <div id="additionalFields" class="p-3 border">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="telephone" class="form-label">Telephone:</label>
                                            <input type="text" class="form-control" id="telephone"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="meal" class="form-label">Meal:</label>
                                            <input type="text" class="form-control" id="meal"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="gasoline" class="form-label">Gasoline:</label>
                                            <input type="text" class="form-control" id="gasoline"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="uniform" class="form-label">Uniform:</label>
                                            <input type="text" class="form-control" id="uniform"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="attendance" class="form-label">Attendance:</label>
                                            <input type="text" class="form-control" id="attendance"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label for="other" class="form-label">Other:</label>
                                            <input type="text" class="form-control" id="other"
                                                   oninput="formatNumber(this)" required>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-2" id="additionalInputs">


                                </div>
                                <div class="row mt-2">
                                    <div class="col">
                                        <div class="form-group">
                                            <button type="button" id="addAllowanceButton"
                                                    class="btn btn-success waves-effect waves-light"
                                                    onclick="addInput()">
                                                <i class="ri-add-line align-bottom me-1"></i> Allowance
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container">
                            <div class="mb-3">
                                <label class="form-label">Insurance Type</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="addHealthInsuranceCheckbox"
                                           value="HEALTH_INSURANCE">
                                    <label class="form-check-label" for="addHealthInsuranceCheckbox">Health
                                        insurance</label>
                                    <input type="text" class="form-control d-none" id="addHealthInsuranceInput"
                                           placeholder="Enter Value Health Insurance" oninput="formatNumber(this)"
                                    >
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="addSocialInsuranceCheckbox"
                                           value="SOCIAL_INSURANCE">
                                    <label class="form-check-label" for="addSocialInsuranceCheckbox">Social
                                        insurance</label>
                                    <input type="text" class="form-control d-none" id="addSocialInsuranceInput"
                                           placeholder="Enter Value Social Insurance" oninput="formatNumber(this)"
                                    >
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="newContract">Contract</label>
                            <input type="file" class="form-control mt-2" id="newContract" name="contract">
                            <small class="text-muted ml-2">Choose Contract File</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="hstack gap-2 justify-content-end">
                            <button type="submit" class="btn btn-success" id="add-btn">Add
                                Contract
                            </button>
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</form>

<%--Modal Edit Contract--%>
<form id="editContractForm">
    <div class="modal fade" id="editContractModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-light p-3">
                    <h5 class="modal-title">Edit Contract</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                    ></button>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editBasicSalary" class="form-label">Basic Salary:</label>
                            <input type="text" class="form-control" id="editBasicSalary" name="basicSalary"
                                   oninput="formatNumber(this)" required/>
                        </div>
                        <div class="mb-3">
                            <label>Allowance:</label>
                            <button type="button" class="btn btn-primary waves-effect waves-light"
                                    id="edit-allowance-btn">Edit Allowance
                            </button>
                            <div class="p-3 mt-2 border bg-light" id="editAllowanceSession"
                                 style="display: none; max-height: 255px" data-simplebar>
                                <div id="exitElement">

                                </div>
                                <div class="row mt-2" id="editionalInputs">


                                </div>
                                <div class="row mt-2">
                                    <div class="col">
                                        <div class="form-group">
                                            <button type="button" id="editAllowanceButton"
                                                    class="btn btn-success waves-effect waves-light"
                                                    onclick="editInput()">
                                                <i class="ri-add-line align-bottom me-1"></i> Allowance
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Insurance Type</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="HEALTH_INSURANCE"
                                       id="editHealthInsuranceCheckbox"
                                >
                                <label class="form-check-label" for="editHealthInsuranceCheckbox">Health
                                    insurance</label>
                                <input type="text" class="form-control d-none" id="editHealthInsuranceInput"
                                       placeholder="Enter Value Health Insurance" oninput="formatNumber(this)">
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="SOCIAL_INSURANCE"
                                       id="editSocialInsuranceCheckbox"
                                >
                                <label class="form-check-label" for="addSocialInsuranceCheckbox">Social
                                    insurance</label>
                                <input type="text" class="form-control d-none" id="editSocialInsuranceInput"
                                       placeholder="Enter Value Social Insurance" oninput="formatNumber(this)">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="editContract">Contract</label>
                            <input type="file" class="form-control mt-2" id="editContract" name="contract">
                            <small class="text-muted ml-2">Choose Contract File</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="hstack gap-2 justify-content-end">
                            <button type="submit" class="btn btn-success" id="edit-confirm-btn"
                                    onclick="addLoadingSuccess(this)">
                                Confirm
                            </button>
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</form>

<%--Modal History Contract--%>
<div class="modal fade" id="contractHistoryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light p-3">
                <h5 class="modal-title">History Contract</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                ></button>
            </div>
            <form>
                <div class="modal-body border" data-simplebar style="max-height: 650px">
                    <table class="table align-middle table-nowrap table-striped-columns"
                           id="table-history-contract" style="width: 100%;">
                        <thead class="table-light">
                        <tr>
                            <th>Basic Salary</th>
                            <th>Allowance</th>
                            <th>Insurance Type</th>
                            <th>Contract</th>
                            <th>Create Date</th>
                        </tr>
                        </thead>
                    </table>
                </div>
                <div class="modal-footer">
                    <div class="hstack gap-2 justify-content-end">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Modal Delete Contract --%>
<div class="modal fade zoomIn" id="deleteRecordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                        id="btn-close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                               colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you Sure ?</h4>
                        <p class="text-muted mx-4 mb-0">Are you Sure You want to Remove this Record ?</p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="delete-record">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--Modal Delete User--%>
<div class="modal fade zoomIn show" id="deleteUserModal" tabindex="-1" aria-modal="true" role="dialog"
     style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                               colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you sure delete this user?</h4>
                        <p class="text-muted mx-4 mb-0">You won't be able to revert this!</p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger" id="deleteUser" value="${user.id}">Yes, Delete
                        It!
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>
<script src="/assets/js/pages/profile-setting.init.js"></script>

<%-------------------------------------------- Table JAVASCRIPT--------------------------------------------%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="/assets/js/pages/datatables.init.js"></script>
<!-- List js -->
<%--<script src="/assets/libs/list.js/list.min.js"></script>--%>
<!-- Pagination js -->
<script src="/assets/libs/list.pagination.js/list.pagination.min.js"></script>
<!-- listjs init -->
<%--<script src="/assets/js/pages/listjs.init.js"></script>--%>

<%-------------------------------------------- Alerts JAVASCRIPT--------------------------------------------%>
<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<!-- Sweet alert init js-->
<%--<script src="/assets/js/pages/sweetalerts.init.js"></script>--%>

<%-------------------------------------------- Files JAVASCRIPT--------------------------------------------%>
<!-- filepond js -->
<script src="/assets/libs/filepond/filepond.min.js"></script>
<script src="/assets/libs/filepond-plugin-image-preview/filepond-plugin-image-preview.min.js"></script>
<script src="/assets/libs/filepond-plugin-file-validate-size/filepond-plugin-file-validate-size.min.js"></script>
<script src="/assets/libs/filepond-plugin-image-exif-orientation/filepond-plugin-image-exif-orientation.min.js"></script>
<script src="/assets/libs/filepond-plugin-file-encode/filepond-plugin-file-encode.min.js"></script>
<!-- File upload js -->
<%--<script src="/assets/js/pages/form-file-upload.init.js"></script>--%>

<%-------------------------------------------- Custom JAVASCRIPT--------------------------------------------%>

<%--Handle User--%>
<script>
    // Handle button 'X' Delete Resume
    document.addEventListener("DOMContentLoaded", function () {
        cutShortLink();
        var selectedDeleteFileResume = null;

        var viewFilesResumeButton = document.querySelectorAll('.delete-fileResume-button');
        viewFilesResumeButton.forEach(function (button) {
            button.addEventListener('click', function () {
                selectedDeleteFileResume = button.closest('.delete-fileResume');
                $('#deleteResumeModal').modal('show');
            });
        });

        // When user confirm delete file resume
        document.getElementById('confirm-del-resume').addEventListener('click', function () {
            if (selectedDeleteFileResume) {
                selectedDeleteFileResume.remove();
            }
            sessionStorage.setItem('result2', 'delResumeSuccess');
        });
    });

    document.getElementById('saveFileResume').addEventListener('click', function () {
        sessionStorage.setItem('result2', 'saveResumeSuccess');
    });

    // Click button 'X' to delete avatar
    document.getElementById("profile-img-file-input").addEventListener("change", function (e) {
        document.getElementById("delete-avatar-button").style.display = "block";
    });
    document.getElementById("delete-avatar-button").addEventListener("click", function () {
        document.getElementById("avatar-user").src = userCurrent.avatar;
        document.getElementById("delete-avatar-button").style.display = "none";
        document.getElementById("profile-img-file-input").value = "";
    });

    // Handle Password
    var isNewPassword = false;
    var isFormValid = false;

    // Handle user click on "Change Password"
    document.getElementById('change-password-button').addEventListener('click', function (e) {
        var elements = document.querySelectorAll('.hide');
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const errorFormatPassword = document.getElementById('formatPassword');
        const errorConfirm = document.getElementById('messageErrorConfirm');
        for (var i = 0; i < elements.length; i++) {
            if (elements[i].style.display == 'none') {
                elements[i].style.display = 'block';
                isNewPassword = true;
                newPasswordInput.value = "";
                newPasswordInput.setAttribute('required', 'true');
                confirmPasswordInput.setAttribute('required', 'true');

                let confirmBlurred = false;
                let newPasswordBlurred = false;

                // Add blur event listener to the "Confirm Password" field
                confirmPasswordInput.addEventListener('blur', function () {
                    confirmBlurred = true;
                    validatePassword();
                });

                // Add blur event listener to the "New Password" field
                newPasswordInput.addEventListener('blur', function () {
                    newPasswordBlurred = true;
                    validatePassword();
                });

                function validatePassword() {
                    const newPassword = newPasswordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    const newPasswordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+=!])([A-Za-z\d@#$%^&+=!]){6,}$/;

                    if (newPasswordBlurred) {
                        if (newPasswordPattern.test(newPassword)) {
                            newPasswordInput.classList.remove("is-invalid");
                            newPasswordInput.classList.add("is-valid");
                            errorFormatPassword.textContent = '';
                            isFormValid = true;
                        } else {
                            newPasswordInput.classList.remove("is-valid");
                            newPasswordInput.classList.add("is-invalid");
                            errorFormatPassword.textContent = "Password must have at least 6 characters and include letters, numbers and special characters!";
                            isFormValid = false;
                        }
                    }

                    if (confirmBlurred) {
                        if (newPassword === confirmPassword) {
                            confirmPasswordInput.classList.remove("is-invalid");
                            confirmPasswordInput.classList.add("is-valid");
                            errorConfirm.textContent = "";
                        } else {
                            confirmPasswordInput.classList.remove("is-valid");
                            confirmPasswordInput.classList.add("is-invalid");
                            errorConfirm.textContent = "Passwords do not match!";
                            isFormValid = false;
                        }
                    }
                }
            } else {
                newPasswordInput.removeAttribute('required');
                confirmPasswordInput.removeAttribute('required');
                elements[i].style.display = 'none';
                isNewPassword = false;
            }
        }
    });

    // Check Basic Information on Button Update Detail User
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById('formUpdateUser');
        const requiredFields = form.querySelectorAll("[required]");

        requiredFields.forEach(function (field) {
            if (!field.value) {
                $('#saveFileResume').remove();
                $('#uploadFileResume').remove();
                $('#cancelFileResume').remove();
            }

            field.addEventListener('blur', function () {
                if (!field.value) {
                    field.classList.add("is-invalid");
                    field.classList.remove("is-valid");
                } else if (field.validity.valid) {
                    field.classList.remove("is-invalid");
                    field.classList.add("is-valid");
                } else {
                    field.classList.remove("is-valid");
                    field.classList.add("is-invalid");
                }
            });
        });

        // Hand user click button update User Detail
        document.getElementById('updateDetail').addEventListener('click', function () {
            let hasEmptyFields = false;
            let hasInvalidFields = false;

            requiredFields.forEach(function (field) {
                if (!field.value) {
                    hasEmptyFields = true;
                    field.classList.add("is-invalid");
                    field.classList.remove("is-valid");
                } else if (!field.validity.valid) {
                    hasInvalidFields = true;
                    field.classList.remove("is-valid");
                    field.classList.add("is-invalid");
                }
            });

            const errorMessage = document.getElementById("error-message");
            if (hasEmptyFields) {
                errorMessage.textContent = "Basic information has not been filled in yet!";
            } else if (hasInvalidFields) {
                errorMessage.textContent = "Some fields are incorrect!";
            } else {
                errorMessage.textContent = "";
            }
        });
    });


    // Validate Date of birth
    document.addEventListener("DOMContentLoaded", function () {
        var dateInput = document.getElementById("dateOfBirth");
        var today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute("max", today);
    });

    // File Resume
    FilePond.registerPlugin(
        FilePondPluginFileEncode
    );

    var inputMultipleElements = document.querySelectorAll('input.filepond-input-multiple');
    var alertFileType = document.getElementById('alertFileType');

    callAjaxByJsonWithData('/api/v1/settings/code?code=USER', 'GET', null, function (rs) {
        var setting = rs;
        var allowedFile = setting.fileType.split(',');

        Array.from(inputMultipleElements).forEach(function (inputElement) {
            const pond = FilePond.create(inputElement);

            pond.on('addfile', (error, file) => {
                const fileExtensions = file.filename.split('.').pop();

                if (error) {
                    console.error(error);
                    return;
                }

                if (file.fileSize > convertMbToB(setting.fileSize)) {
                    alertFileType.querySelector('.alert').innerHTML = '<i class="ri-error-warning-line me-3 align-middle"></i> <strong>Danger</strong> - You can upload files larger than 100MB';
                    alertFileType.style.display = 'block';
                    pond.removeFile(file.id);
                }

                if (!(allowedFile.includes(fileExtensions))) {
                    alertFileType.style.display = 'block';
                    alertFileType.querySelector('.alert').innerHTML = '<i class="ri-error-warning-line me-3 align-middle"></i> <strong>Danger</strong> - You cannot upload that file';
                    pond.removeFile(file.id);
                }

                if (!(file.fileSize > convertMbToB(setting.fileSize)) && allowedFile.includes(fileExtensions)) {
                    alertFileType.style.display = 'none';
                }

                var saveBtn = document.getElementById('saveFileResume');

                if (pond.getFiles().length > 0) {
                    saveBtn.disabled = false;
                } else saveBtn.disabled = true;

                pond.on('removefile', (file) => {
                    if (pond.getFiles().length > 0) {
                        saveBtn.disabled = false;
                    } else saveBtn.disabled = true;
                });

            });
        })
    });

    Validator({
        form: '#formUpdateUser',
        errorSelector: '.form-message',
        rules: [],
        onSubmit: function (formData) {
            addLoadingPrimary(document.getElementById('updateDetail'));
            addLoadingPrimary(document.getElementById('updateBasic'));
            disableBtn();

            // ADD dateOfBirth after format
            var dobString = document.getElementById('dateOfBirth').value;

            var jsDate = new Date(dobString);
            var dateOfBirth = new Date(jsDate.getTime());
            formData.append('dateOfBirth', dateOfBirth);

            // ADD all file resume
            var filesResume = document.querySelectorAll('.fileName-Resume');
            var filenamesResume = [];
            filesResume.forEach(function (element) {
                var href = element.getAttribute('href');
                var parts = href.split('/');
                var fileName = parts[parts.length - 1];
                filenamesResume.push(fileName);
            });

            inputMultipleElements.forEach(function (inputElement) {
                var filePondInstance = FilePond.find(inputElement);

                if (filePondInstance.getFiles().length > 0) {
                    filePondInstance.getFiles().forEach(function (file) {
                        formData.append('newResumeFiles', file.file);
                    });
                }
            });

            var result = filenamesResume.join(",");
            formData.append('remainResumeFiles', result);
            formData.append('id', '${user.id}');
            if (isNewPassword) {
                var newPassword = document.getElementById('newPassword').value;
                if (newPassword != '' && isFormValid == true) {
                    callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                        localStorage.setItem('result', 'updateUserSuccess');
                        location.href = "/users/" + '${user.id}';
                    }, function () {
                        enableBtn();
                        $('.d-flex.align-items-center').remove();
                        $('#updateDetail').removeClass('btn-load').text('Update');
                        $('#updateBasic').removeClass('btn-load').text('Update');

                        Swal.fire(
                            {
                                title: 'Email or TimeSheets Code exists',
                                confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                buttonsStyling: false,
                                showCloseButton: true
                            }
                        )
                    });
                }
            } else {
                formData.delete('password');
                callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                    localStorage.setItem('result', 'updateUserSuccess');
                    location.href = "/users/" + '${user.id}';
                }, function () {
                    enableBtn();
                    $('.d-flex.align-items-center').remove();
                    $('#updateDetail').removeClass('btn-load').text('Update');
                    $('#updateBasic').removeClass('btn-load').text('Update');

                    Swal.fire(
                        {
                            title: 'Email or TimeSheets Code exists',
                            confirmButtonClass: 'btn btn-primary w-xs mt-2',
                            buttonsStyling: false,
                            showCloseButton: true
                        }
                    )
                });
            }
        }
    });

    // Show modal Delete User
    document.getElementById('del-user-button').addEventListener('click', function () {
        $('#deleteUserModal').modal('show');
    });

    // Handle when user click button "Confirm Delete User"
    document.addEventListener("DOMContentLoaded", function () {

        var deleteUserButtons = document.getElementById('deleteUser');
        var userId = deleteUserButtons.value;


        // Handler button Delete in modal Delete
        deleteUserButtons.addEventListener("click", function () {
            disableBtn();
            $('#deleteUserModal').modal('hide');
            showAlertLoading();
            if (userId) {
                callAjaxByJsonWithData('/api/v1/users/' + userId, 'DELETE', null, function (rs) {
                    sessionStorage.setItem('result', 'delUserSuccess');
                    window.location.href = "/users";
                });
            }
        });
    });

    function addSpinnerAfterClass(className) {
        const elements = document.getElementsByClassName(className);

        for (let i = 0; i < elements.length; i++) {
            const spinnerDiv = document.createElement("div");
            spinnerDiv.className = "spinner-border text-primary";
            spinnerDiv.setAttribute("role", "status");

            const spinnerSpan = document.createElement("span");
            spinnerSpan.className = "sr-only";
            spinnerSpan.innerText = "Loading...";

            spinnerDiv.appendChild(spinnerSpan);
            elements[i].insertAdjacentElement('beforebegin', spinnerDiv);
        }
    }
</script>

<%--Handle WorkingDay--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        if (!(userCurrent.role == 'DEVELOPER')) {
            var loadingWorking = document.getElementById('loadingWorking');
            var workingSession = document.getElementById('workingDaySession');
            loadingWorking.style.display = 'inline-block';
            // Lấy tham chiếu đến các phần tử HTML
            var yearSelect = document.getElementById('working-year');
            var monthSelect = document.getElementById('working-month');
            var totalWorkingDayInput = document.getElementById('totalWorkingDay');

            var data;
            callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.id}', 'GET', null, function (rs) {
                loadingWorking.style.display = 'none';
                workingSession.style.display = 'block';
                data = rs;
                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
                data.forEach(function (entry) {
                    var option = document.createElement('option');
                    option.value = entry.year;
                    option.textContent = entry.year;
                    yearSelect.appendChild(option);
                });
            });

            // Thêm sự kiện nghe cho việc thay đổi lựa chọn năm
            yearSelect.addEventListener('change', function () {
                loadingWorking.style.display = 'inline-block';
                workingSession.style.display = 'none';
                callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.id}' + "?year=" + yearSelect.value, 'GET', null, function (rs) {
                    loadingWorking.style.display = 'none';
                    workingSession.style.display = 'block';
                    var dataMonth = rs;
                    // Xóa các option cũ trong dropdown year
                    monthSelect.innerHTML = '<option value="">-- Select Month --</option>';

                    // Thêm các option mới từ dữ liệu API
                    dataMonth.forEach(function (entry) {
                        var option = document.createElement('option');
                        option.value = entry.month;
                        option.textContent = entry.month;
                        monthSelect.appendChild(option);
                    });
                    monthSelect.addEventListener('change', function () {
                        var selectedMonth = monthSelect.value;
                        var selectedData = dataMonth.find(function (entry) {
                            return entry.month === parseInt(selectedMonth);
                        });
                        totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                    });

                });

                if (yearSelect.value != "") {
                    var selectedYear = yearSelect.value;
                    var selectedData = data.find(function (entry) {
                        return entry.year === parseInt(selectedYear);
                    });
                    totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                    monthSelect.style.display = 'block';
                } else {
                    totalWorkingDayInput.value = null;
                    monthSelect.style.display = 'none';
                }
            });
        }
    });
</script>

<%--Handle Contract--%>
<script>
    // Format File Name Contract
    document.addEventListener("DOMContentLoaded", function () {
        var elementContract = document.querySelectorAll('a.contractLink');
        elementContract.forEach(function (link) {
            var href = link.getAttribute('href');
            var fileName = href.split('/').pop();
            var truncatedFileName;
            if (fileName.length > 0) {
                truncatedFileName = fileName.substring(0, 14) + '...';
            }
            link.textContent = truncatedFileName;
        });
    });

    // Format Allowance
    document.addEventListener("DOMContentLoaded", function () {
        var tdElements = document.getElementsByClassName('format-allowance');
        for (var i = 0; i < tdElements.length; i++) {
            var tdElement = tdElements[i];
            var jsonText = tdElement.textContent;

            tdElement.innerHTML = allowanceFormat(jsonText);
        }
    });

    // Format Insurance
    document.addEventListener("DOMContentLoaded", function () {
        $('.format-insurance').each(function () {
            var insuranceData = $(this).text();
            var formattedInsurance = insuranceFormat(insuranceData);

            $(this).html(formattedInsurance);
        });
    });

    // Handle when user click button "+ Allowance"
    let addedInputCount = 0;
    let editInputCount = 0;

    // Add input allowance
    function addInput() {
        if (addedInputCount < 4) {
            const additionalInputs = document.getElementById("additionalInputs");
            const newInput = document.createElement("div");
            newInput.classList.add('row', 'mt-2', 'newAllowance');
            newInput.innerHTML = `
                   <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control title" required>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label for="value">Value</label>
                                <div class="input-group">
                                    <input type="text" class="form-control value" oninput="formatNumber(this)" required>
                                    <div class="input-group-append ml-2">
                                        <i class="ri-close-circle-line deleteBtnAllowance" style="font-size: 25px; color: red; margin-left: 8px; cursor: pointer" onclick="delInput(this)"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            `;

            additionalInputs.appendChild(newInput);
            addedInputCount++;
            var btnDelAllowance = document.querySelectorAll('.deleteBtnAllowance');

            btnDelAllowance.forEach(function (button, i) {
                button.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            });

            if (addedInputCount === 4) {
                document.getElementById('addAllowanceButton').style.display = 'none';
            }
        }
    }

    function editInput() {
        if (editInputCount < 4) {
            const edititionalInputs = document.getElementById("editionalInputs");
            const newInput = document.createElement("div");
            newInput.classList.add('row', 'mt-2', 'newAllowance');
            newInput.innerHTML = `
                   <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control newTitle" required>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label for="value">Value</label>
                                <div class="input-group">
                                    <input type="text" class="form-control newValue" oninput="formatNumber(this)" required>
                                    <div class="input-group-append ml-2">
                                        <i class="ri-close-circle-line deleteBtnAllowance" style="font-size: 25px; color: red; margin-left: 8px; cursor: pointer" onclick="delInput2(this)"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            `;

            edititionalInputs.appendChild(newInput);
            editInputCount++;
            var btnDelAllowance = document.querySelectorAll('.deleteBtnAllowance');

            btnDelAllowance.forEach(function (button, i) {
                button.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            });

            if (editInputCount == 4) {
                document.getElementById('editAllowanceButton').style.display = 'none';
            }
        }
    }

    // Delete input Allowance when click 'X'
    function delInput(element) {
        addedInputCount--;
        element.closest('.newAllowance').remove();
        if (addedInputCount < 4) document.getElementById('addAllowanceButton').style.display = 'inline-block';
    }

    // Delete input Allowance when click 'X'
    function delInput2(element) {
        editInputCount--;
        element.closest('.newAllowance').remove();
        if (editInputCount < 4) document.getElementById('editAllowanceButton').style.display = 'inline-block';
    }

    // Function Format Allowance
    function allowanceFormat(data) {
        var data = JSON.parse(data);
        var keyValueString = '';
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                keyValueString += '<strong>' + key + '</strong>' + ' : ' + data[key] + 'đ' + '<br><br>';
            }
        }
        keyValueString = keyValueString.slice(0, -2);

        return keyValueString;
    }

    // Function Format money is number
    function formatNumber(input) {
        let value = input.value.replace(/,/g, '');

        // Only Number
        value = value.replace(/\D/g, '');

        // insert ',' after every 3 digits
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');

        input.value = value;
    }

    // Function Format Insurance
    function insuranceFormat(data) {
        var jsonArray = JSON.parse(data);
        var resultArray = [];
        var keyValueString = '';

        jsonArray.forEach(item => {
            const key = item.code;
            const value = item.money;
            resultArray.push({key, value});
        });

        for (var i = 0; i < resultArray.length; i++) {
            if (resultArray[i].value != null && resultArray[i].value !== "") {
                keyValueString += '<strong>' + resultArray[i].key + '</strong>' + ' : ' + resultArray[i].value + 'đ' + '<br><br>';
            }
        }
        return keyValueString;
    }

    // Click checkbox ADD Insurance Type
    document.addEventListener("DOMContentLoaded", function () {
        $('#addHealthInsuranceCheckbox').change(function () {
            if ($(this).is(':checked')) {
                $('#addHealthInsuranceInput').removeClass('d-none');
            } else {
                $('#addHealthInsuranceInput').addClass('d-none');
            }
        });

        $('#addSocialInsuranceCheckbox').change(function () {
            if ($(this).is(':checked')) {
                $('#addSocialInsuranceInput').removeClass('d-none');
            } else {
                $('#addSocialInsuranceInput').addClass('d-none');
            }
        });
    });

    // Show modal Add Contract
    document.getElementById('add-contract-button').addEventListener('click', function (e) {
        $('#addContractModal').modal('show');
        var fileAddContract = document.getElementById('newContract');
        fileAddContract.addEventListener('change', function () {
            callAjaxByJsonWithData('/api/v1/settings/code?code=USER', 'GET', null, function (rs) {
                var setting = rs;
                var allowedFile = setting.fileType.split(',');
                var fileName = fileAddContract.files[0].name.split('.').pop();
                var fileSize = fileAddContract.files[0].size;

                if (fileSize > convertMbToB(setting.fileSize)) {
                    Swal.fire(
                        {
                            title: 'Oops...',
                            text: 'You cannot upload this file!',
                            icon: 'error',
                            confirmButtonClass: 'btn btn-primary w-xs mt-2',
                            buttonsStyling: false,
                            showCloseButton: true
                        }
                    )
                    fileAddContract.value = null;
                }

                if (!(allowedFile.includes(fileName))) {
                    Swal.fire(
                        {
                            title: 'Oops...',
                            text: 'You cannot upload this file!',
                            icon: 'error',
                            confirmButtonClass: 'btn btn-primary w-xs mt-2',
                            buttonsStyling: false,
                            showCloseButton: true
                        }
                    )
                    fileAddContract.value = null;
                }
            });
        });
    });

    Validator({
        form: '#formAddContract',
        errorSelector: '.form-message',
        rules: [],
        onSubmit: function (formData) {
            disableBtn();

            var telPhone = document.getElementById('telephone').value;
            var meal = document.getElementById('meal').value;
            var gasoline = document.getElementById('gasoline').value;
            var uniform = document.getElementById('uniform').value;
            var attendance = document.getElementById('attendance').value;
            var other = document.getElementById('other').value;
            var titles = document.querySelectorAll('.title');
            var values = document.querySelectorAll('.value');
            var formDataObject = {
                "Telephone": telPhone,
                "Meal": meal,
                "Gasoline": gasoline,
                "Uniform": uniform,
                "Attendance": attendance,
                "Other": other
            };

            if (titles.length === values.length && titles.length > 0 && values.length > 0) {
                for (var i = 0; i < titles.length; i++) {
                    formDataObject[titles[i].value] = values[i].value;
                }
            }

            var codeInsurance = document.getElementById('addHealthInsuranceCheckbox').value;
            var moneyInsurance = document.getElementById('addHealthInsuranceInput').value;
            var codeSocialInsurance = document.getElementById('addSocialInsuranceCheckbox').value;
            var moneySocialInsurance = document.getElementById('addSocialInsuranceInput').value;
            var strings = [codeInsurance, moneyInsurance, codeSocialInsurance, moneySocialInsurance];

            var objects = [];
            for (var i = 0; i < strings.length; i += 2) {
                if (i + 1 < strings.length) {
                    var obj = {code: strings[i], money: strings[i + 1]};
                    objects.push(obj);
                }
            }

            var insurance = JSON.stringify(objects);

            formData.append('insurance', insurance);
            formData.append('userId', '${user.id}');
            formData.set('allowance', JSON.stringify(formDataObject));

            var addContractBtn = document.getElementById('add-btn');
            addContractBtn.disabled = true;
            addLoadingSuccess(addContractBtn);
            callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {
                setTimeout(function () {
                    formData.append('parentId', rs.id);
                    callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs2) {
                        localStorage.setItem('result', 'addContractSuccess');
                        location.reload();
                    }, 'formAddContract');
                }, 1000);
            }, 'formAddContract');
        }
    });

    // Handle when user click 'Edit Contract' button
    document.addEventListener("DOMContentLoaded", function () {
        // Hand button Edit Allowance
        document.getElementById('edit-allowance-btn').addEventListener('click', function () {
            var elementAllowance = document.getElementById('editAllowanceSession');
            if (elementAllowance.style.display == 'none') elementAllowance.style.display = 'block';
            else elementAllowance.style.display = 'none';
        });

        $('#editContractModal').on('shown.bs.modal', function () {
            var editHealth = document.getElementById('editHealthInsuranceInput');
            var editSocial = document.getElementById('editSocialInsuranceInput');

            if (editHealth.value == null || editHealth.value == '') {
                $("#editHealthInsuranceCheckbox").prop("checked", false);
                $('#editHealthInsuranceInput').addClass('d-none');
            } else {
                $("#editHealthInsuranceCheckbox").prop("checked", true);
                $('#editHealthInsuranceInput').removeClass('d-none');
            }

            if (editSocial.value == null || editSocial.value == '') {
                $("#editSocialInsuranceCheckbox").prop("checked", false);
                $('#editSocialInsuranceInput').addClass('d-none');
            } else {
                $("#editSocialInsuranceCheckbox").prop("checked", true);
                $('#editSocialInsuranceInput').removeClass('d-none');
            }

            // Click checkbox EDIT Insurance Type
            $('#editHealthInsuranceCheckbox').change(function () {
                if ($(this).is(':checked')) {
                    $('#editHealthInsuranceInput').removeClass('d-none');
                } else {
                    $('#editHealthInsuranceInput').addClass('d-none');
                }
            });

            $('#editSocialInsuranceCheckbox').change(function () {
                if ($(this).is(':checked')) {
                    $('#editSocialInsuranceInput').removeClass('d-none');
                } else {
                    $('#editSocialInsuranceInput').addClass('d-none');
                }
            });
        });

        var editContractBtn = document.querySelectorAll('.edit-contract-btn');
        editContractBtn.forEach(function (button) {
            button.addEventListener('click', function (e) {
                var editContractId = this.value;
                e.preventDefault();
                $('#editContractModal').modal('show');

                // Call Api get Data Contract Detail
                callAjaxByJsonWithData('/api/v1/contracts/' + editContractId, 'GET', null, function (rs) {
                    document.getElementById("editBasicSalary").value = rs.basicSalary;

                    var allowance = JSON.parse(rs.allowance);
                    var divRow;
                    var count = 0;
                    var exitElement = document.getElementById('exitElement');

                    if (exitElement.querySelectorAll('.row').length > 0) $('#exitElement').empty();

                    for (var key in allowance) {
                        if (allowance.hasOwnProperty(key)) {
                            var value = allowance[key];

                            if (count % 2 === 0) {
                                divRow = document.createElement("div");
                                divRow.className = "row";
                            }

                            var divCol = document.createElement("div");
                            divCol.className = "col";

                            var formGroupLabel = document.createElement("div");
                            formGroupLabel.className = "form-group";

                            var label = document.createElement("label");
                            label.setAttribute("for", "edit" + key);
                            label.classList.add("form-label", "mt-2", "title");
                            label.textContent = key;

                            var input = document.createElement("input");
                            input.setAttribute("type", "text");
                            input.classList.add("form-control", "value");
                            input.id = "edit" + key;
                            input.value = value;
                            input.setAttribute("oninput", "formatNumber(this)");
                            input.required = true;

                            var small = document.createElement("small");
                            small.className = "form-message";

                            small.appendChild(document.createTextNode(""));
                            formGroupLabel.appendChild(label);
                            formGroupLabel.appendChild(input);
                            formGroupLabel.appendChild(small);
                            divCol.appendChild(formGroupLabel);
                            divRow.appendChild(divCol);

                            if (count % 2 === 1 || count === Object.keys(allowance).length - 1) {
                                document.getElementById("exitElement").appendChild(divRow);
                            }
                            count++;
                        }
                    }

                    var insurance = JSON.parse(rs.insurance);
                    var editHealth = document.getElementById('editHealthInsuranceInput');
                    var editSocial = document.getElementById('editSocialInsuranceInput');
                    var editHealthCheckBox = document.getElementById('editHealthInsuranceCheckbox');
                    var editSocialCheckBox = document.getElementById('editSocialInsuranceCheckbox');

                    for (var i = 0; i < insurance.length; i++) {
                        if (insurance[i].code === editHealthCheckBox.value) {
                            editHealth.value = insurance[i].money
                        } else if (insurance[i].code === editSocialCheckBox.value) {
                            editSocial.value = insurance[i].money
                        }
                    }
                });

                var fileEditContract = document.getElementById('editContract');
                fileEditContract.addEventListener('change', function () {
                    callAjaxByJsonWithData('/api/v1/settings/code?code=USER', 'GET', null, function (rs) {
                        var setting = rs;
                        var allowedFile = setting.fileType.split(',');
                        var fileName = fileEditContract.files[0].name.split('.').pop();
                        var fileSize = fileEditContract.files[0].size;

                        if (fileSize > convertMbToB(setting.fileSize)) {
                            Swal.fire(
                                {
                                    title: 'Oops...',
                                    text: 'You cannot upload this file!',
                                    icon: 'error',
                                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                    buttonsStyling: false,
                                    showCloseButton: true
                                }
                            )
                            fileEditContract.value = null;
                        }

                        if (!(allowedFile.includes(fileName))) {
                            Swal.fire(
                                {
                                    title: 'Oops...',
                                    text: 'You cannot upload this file!',
                                    icon: 'error',
                                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                    buttonsStyling: false,
                                    showCloseButton: true
                                }
                            )
                            fileEditContract.value = null;
                        }
                    });
                });

                // Click button Confirm edit Contract
                if (editContractId) {
                    Validator({
                        form: '#editContractForm',
                        errorSelector: '.form-message',
                        rules: [],
                        onSubmit: function (formData) {
                            disableBtn();

                            var formUpdateContract = document.getElementById('editContractForm');
                            var titles = formUpdateContract.querySelectorAll('.title');
                            var values = formUpdateContract.querySelectorAll('.value');
                            var newTitles = formUpdateContract.querySelectorAll('.newTitle');
                            var newValues = formUpdateContract.querySelectorAll('.newValue');
                            var formDataObject = {};

                            if (titles.length === values.length && titles.length > 0 && values.length > 0) {
                                for (var i = 0; i < titles.length; i++) {
                                    formDataObject[titles[i].textContent] = values[i].value;
                                }
                            }
                            if (newTitles.length === newValues.length && newTitles.length > 0 && newValues.length > 0) {
                                for (var j = 0; j < newTitles.length; j++) {
                                    formDataObject[newTitles[j].value] = newValues[j].value;
                                }
                            }

                            var codeInsurance = document.getElementById('editHealthInsuranceCheckbox');
                            var moneyInsurance = document.getElementById('editHealthInsuranceInput');
                            var codeSocialInsurance = document.getElementById('editSocialInsuranceCheckbox');
                            var moneySocialInsurance = document.getElementById('editSocialInsuranceInput');

                            if (!codeInsurance.checked) moneyInsurance.value = '';
                            if (!codeSocialInsurance.checked) moneySocialInsurance.value = '';

                            var strings = [codeInsurance.value, moneyInsurance.value, codeSocialInsurance.value, moneySocialInsurance.value];

                            var objects = [];
                            for (var i = 0; i < strings.length; i += 2) {
                                if (i + 1 < strings.length) {
                                    var obj = {code: strings[i], money: strings[i + 1]};
                                    objects.push(obj);
                                }
                            }

                            var insurance = JSON.stringify(objects);

                            formData.append('insurance', insurance);
                            formData.append('allowance', JSON.stringify(formDataObject));
                            formData.append('userId', '${user.id}');
                            formData.append('parentId', editContractId);
                            document.getElementById('edit-confirm-btn').disabled = true;

                            callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {

                            }, 'formAddContract');

                            formData.delete('parentId');
                            formData.delete('userId');
                            formData.append('id', editContractId);
                            callAjaxByDataFormWithDataForm('/api/v1/contracts/updation', 'POST', formData, function (rs) {
                                localStorage.setItem("result", "updateContractSuccess");
                                location.reload();
                            }, 'editContractForm');
                        }
                    });
                }
            })
        });
    });

    // Handle when user Delete Contract
    document.addEventListener("DOMContentLoaded", function () {
        var delContractBtn = document.querySelectorAll('.del-contract-btn');
        delContractBtn.forEach(function (button) {
            button.addEventListener('click', function (e) {
                var delContractId = this.value;
                e.preventDefault();
                Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                    cancelButtonClass: 'btn btn-danger w-xs mt-2',
                    confirmButtonText: "Yes, delete it!",
                    buttonsStyling: false,
                    showCloseButton: true
                }).then(function (result) {
                    if (result.value) {
                        Swal.close();

                        showAlertLoading();
                        disableBtn();
                        callAjaxByJsonWithData('/api/v1/contracts/' + delContractId, 'DELETE', null, function (rs) {
                            localStorage.setItem('result', 'delContractSuccess');
                            location.reload();
                        });
                    }
                });
            })
        });
    });

    // Handle when user click 'History Update' button
    document.addEventListener("DOMContentLoaded", function () {

        var historyButtons = document.querySelectorAll('.history-contract-button');
        var contractIdHistory;

        historyButtons.forEach(function (button) {
            button.addEventListener('click', function (e) {
                contractIdHistory = button.value;
                $('#contractHistoryModal').modal('show');
                e.preventDefault();
                if ($.fn.DataTable.isDataTable('#table-history-contract')) {
                    $('#table-history-contract').DataTable().destroy();
                }

                if (contractIdHistory) {
                    var table = $('#table-history-contract').DataTable({
                        ajax: {
                            url: '/api/v1/contracts/' + contractIdHistory,
                            contentType: 'application/json',
                            method: 'GET',
                            dataSrc: 'historyContract'
                        },
                        columns: [
                            {data: 'basicSalary'},
                            {
                                data: 'allowance',
                                render: function (data, type, row) {
                                    return allowanceFormat(data);
                                }
                            },
                            {
                                data: 'insurance',
                                render: function (data, type, row) {
                                    return insuranceFormat(data);
                                }
                            },
                            {
                                data: 'contract',
                                render: function (data, type, row) {
                                    if (data != null) {
                                        var fileName = data.substring(data.lastIndexOf('/') + 1);
                                        return '<a class="cut-file-name" href="' + data + '" data-toggle="tooltip" data-bs-placement="bottom" title="' + fileName + '">' + data + '</a>';
                                    }
                                    return '';
                                }
                            },
                            {data: 'createdDate'}
                        ],
                        ordering: false,
                        searching: false,
                        lengthChange: false,
                        paging: false,
                        info: false,
                        initComplete: function () {
                            cutShortLink();
                            $(function () {
                                $('[data-toggle="tooltip"]').tooltip();
                            })
                        }
                    });
                }

            });
        });
    });
</script>

<%--Data Table--%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        let table = new DataTable('#contractTable', {
            "pagingType": "full_numbers",
            "pageLength": 3,
            "lengthMenu": [3, 5, 10],
            "ordering": false
        });
    });
</script>

<%--Notification--%>
<script>
    // Show modal notification
    document.addEventListener("DOMContentLoaded", function () {
        var result = localStorage.getItem('result');
        var result2 = sessionStorage.getItem('result2');
        if (result2 != null) notificationSuccess(sessionStorage.getItem('result2'));
        else if (result != null) notificationSuccess(localStorage.getItem('result'));

        localStorage.clear();
        sessionStorage.clear();
    });

    // Notification Success
    function notificationSuccess(result) {
        var title;
        var text;
        var contractTab = document.querySelector('a[data-bs-toggle="tab"][href="#contractSession"]');
        var resumeTab = document.querySelector('a[data-bs-toggle="tab"][href="#resumeSession"]');
        switch (result) {
            case 'saveResumeSuccess':
                title = 'Save Success';
                resumeTab.click();
                break;
            case 'delResumeSuccess':
                title = 'Deleted!';
                text = 'Your file has been deleted.';
                resumeTab.click();
                break;
            case 'updateUserSuccess':
                title = 'Update Success';
                break;
            case 'addContractSuccess':
                title = 'Add Success';
                contractTab.click();
                break;
            case 'updateContractSuccess':
                title = 'Update Success';
                contractTab.click();
                break;
            case 'delContractSuccess':
                title = 'Deleted!';
                text = 'Your file has been deleted.';
                contractTab.click();
                break;
        }
        Swal.fire(
            {
                title: title,
                text: text,
                icon: 'success',
                confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                cancelButtonClass: 'btn btn-danger w-xs mt-2',
                buttonsStyling: false,
                showCloseButton: true
            }
        )
    }
</script>

<%--Handle Role--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var linkCancle = '/users';
        if (isDeleveloper()) linkCancle = '/home';
        $('.cancle-button').attr('href', linkCancle);

        if (!isDeleveloper()) {
            $('.permission').removeClass('d-none');
            $('#del-user-button').removeClass('d-none');
            $('#timeSheetsCode').prop('readonly', false);
            $('#timeSheetsCode').prop('disabled', false);
        }
    });
</script>

<%--Loading Button--%>
<script>
    // Loading Success Button
    function addLoadingSuccess(element) {
        element.classList.add("btn-load");
        var content = element.textContent;
        element.innerHTML = `
            <span class="d-flex align-items-center">
                <span class="spinner-border flex-shrink-0" role="status">
                    <span class="visually-hidden">Loading...</span>
                </span>
                <span class="flex-grow-1 ms-2 loading-success">

                </span>
            </span>
        `;

        document.querySelector('.loading-success').textContent = content;
    }

    // Loading Primary
    function addLoadingPrimary(element) {
        element.classList.add("btn-load");
        var content = element.textContent;
        element.innerHTML = `
            <span class="d-flex align-items-center">
                <span class="spinner-border flex-shrink-0" role="status">
                    <span class="visually-hidden">Loading...</span>
                </span>
                <span class="flex-grow-1 ms-2 loading-primary">

                </span>
            </span>
        `;

        document.querySelector('.loading-primary').textContent = content;
    }

    // Loading Danger
    // function addLoadingDanger(element) {
    //     element.classList.add("btn-load");
    //     var content = element.textContent;
    //     element.innerHTML = `
    //         <span class="d-flex align-items-center">
    //             <span class="spinner-border flex-shrink-0" role="status">
    //                 <span class="visually-hidden">Loading...</span>
    //             </span>
    //             <span class="flex-grow-1 ms-2 loading-da">
    //
    //             </span>
    //         </span>
    //     `;
    //
    //     document.querySelector('.loading-primary').textContent = content;
    // }
</script>

<%--Disable Button--%>
<script>
    function disableBtn() {
        document.querySelectorAll('.btn-primary').forEach(function (e) {
            e.disabled = true;
        });

        document.querySelectorAll('.btn-success').forEach(function (e) {
            e.disabled = true;
        });

        document.querySelectorAll('.btn-warning').forEach(function (e) {
            e.disabled = true;
        });

        document.querySelectorAll('.btn-danger').forEach(function (e) {
            e.disabled = true;
        });
    }

    function enableBtn() {
        document.querySelectorAll('.btn-primary').forEach(function (e) {
            e.disabled = false;
        });

        document.querySelectorAll('.btn-success').forEach(function (e) {
            e.disabled = false;
        });

        document.querySelectorAll('.btn-warning').forEach(function (e) {
            e.disabled = false;
        });

        document.querySelectorAll('.btn-danger').forEach(function (e) {
            e.disabled = false;
        });
    }
</script>
</body>
</html>