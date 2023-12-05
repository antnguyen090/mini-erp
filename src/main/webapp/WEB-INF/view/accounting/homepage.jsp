<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accounting Management</title>
    <link href="/assets/libs/dropzone/dropzone.css" rel="stylesheet" type="text/css">
    <script src="../../../assets/custom/js/accounting/accounting.js"></script>
</head>
<body>
<c:set var="totalExpense" value="0" scope="page"/>
<c:set var="totalRevenue" value="0" scope="page"/>
<div class="position-relative mb-4" style="min-height: 80vh">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">ACCOUNTING</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <li class="breadcrumb-item active">Accounting</li>
                </ol>
            </div>

        </div>
    </div>
    <div style="width: 3rem; height: 3rem; z-index: 999; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"
         class="containerLoading d-flex align-items-center justify-content-center full-height">
        <div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <div class="row d-none" id="containerAccounting">
        <div class="shadow p-3 bg-white rounded">
            <div class="row">
                <div class="col-12">
                    <h3 class="text-center">Accounting</h3>
                </div>
            </div>
            <div class="row mt-1">
                <div class="col-md-4 col-xl-6">
                    <div class="form-group">
                        <label for="account-day" class="form-label mb-0 text-muted">Filter by year: </label>
                        <div class="input-group" id="account-day">
                            <select class="form-select rounded-pill" aria-label="Default select example"
                                    id="account-year">
                                <option value="">-- Select year --</option>
                            </select>
                            <div class="d-flex justify-content-center align-items-center d-none yearLoading ms-2">
                                <span class="spinner-grow flex-shrink-0" role="status">
                                    <span class="visually-hidden"> Loading...</span>
                                </span>
                            </div>
                            <select class="form-select rounded-pill ms-2" aria-label="Default select example"
                                    id="account-month"
                                    style="display: none;">
                                <option value="">-- Select month --</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-3">
                        <label class="form-label mb-0 text-muted viewRemain">Check remain balance each month: </label>
                        <br>
                        <button type="button" class="btn btn-primary btn-label rounded-pill mt-2 viewRemain"><i
                                class="ri-equalizer-fill label-icon align-middle rounded-pill fs-16 me-2"></i> View
                        </button>
                    </div>
                </div>
                <div class="col-md-4 col-xl-6">
                    <div class="form-group">
                        <label for="datePickerStart" class="form-label mb-0 text-muted">Start Date</label>
                        <input type="text" class="form-control flatpickr-input" data-provider="flatpickr"
                               data-date-format="d M, Y" data-deafult-date="" id="datePickerStart">
                        <label for="datePickerEnd" class="form-label mb- mt-3 text-muted">End Date</label>
                        <input type="text" class="form-control flatpickr-input" data-provider="flatpickr"
                               data-date-format="d M, Y" data-deafult-date="" id="datePickerEnd">
                    </div>
                    <button type="button" class="btn btn-primary btn-label rounded-pill mt-3" onclick="loadPage(1)"><i
                            class="ri-equalizer-fill label-icon align-middle rounded-pill fs-16 me-2"></i> Filter
                    </button>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header border-0">
                            <div class="d-flex align-items-center">
                                <h5 class="card-title mb-0 flex-grow-1">Accounting Datatable</h5>
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="example_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                                <div class="row">
                                    <div class="col-sm-12 col-md-6">
                                        <div class="dataTables_length" id="example_length"><label for="pageCount"
                                                                                                  class="form-label">Show
                                            <select
                                                    name="example_length"
                                                    aria-controls="example"
                                                    class="form-select form-select-sm" id="pageCount">
                                                <option selected value="10">10</option>
                                                <option value="15">15</option>
                                                <option value="20">20</option>
                                            </select> entries</label></div>
                                    </div>
                                    <div class="col-sm-12 col-md-6">
                                        <div id="example_filter" class="dataTables_filter mb-2">
                                            <button class="btn btn-danger btn-label waves-effect waves-light"
                                                    data-bs-toggle="modal" data-bs-target="#createModal">
                                                <i class="bx bx-add-to-queue label-icon align-middle fs-16 me-2"></i>
                                                Create Account
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table
                                                class="table table-bordered dt-responsive nowrap table-striped align-middle dataTable no-footer dtr-inline collapsed"
                                                style="width: 100%;" aria-describedby="example_info">
                                            <thead>
                                            <tr>
                                                <th data-ordering="false" tabindex="0"
                                                    aria-controls="example" rowspan="1" colspan="1"
                                                    style="width: 43.4px;"
                                                    aria-label="SR No.: activate to sort column ascending">NO.
                                                </th>
                                                <th data-ordering="false" tabindex="0"
                                                    aria-controls="example" rowspan="1" colspan="1"
                                                    style="width: 34.4px;"
                                                    aria-label="ID: activate to sort column ascending">TRANSACTION ID
                                                </th>
                                                <th data-ordering="false" tabindex="0"
                                                    aria-controls="example" rowspan="1" colspan="1"
                                                    style="width: 81.4px;"
                                                    aria-label="Purchase ID: activate to sort column ascending">PAY DATE
                                                </th>
                                                <th data-ordering="false" tabindex="0"
                                                    aria-controls="example" rowspan="1" colspan="1"
                                                    style="width: 200.4px;"
                                                    aria-label="Title: activate to sort column ascending">TITLE
                                                </th>
                                                <th data-ordering="false" tabindex="0"
                                                    aria-controls="example" rowspan="1" colspan="1"
                                                    style="width: 74.4px;"
                                                    aria-label="User: activate to sort column ascending">REVENUE
                                                </th>
                                                <th tabindex="0" aria-controls="example" rowspan="1"
                                                    colspan="1" style="width: 84.4px;"
                                                    aria-label="Assigned To: activate to sort column ascending">EXPENSE
                                                </th>
                                                <th tabindex="0" aria-controls="example" rowspan="1"
                                                    colspan="1" style="width: 76.4px;"
                                                    aria-label="Created By: activate to sort column ascending">BALANCE
                                                </th>
                                                <th tabindex="0" aria-controls="example" rowspan="1"
                                                    colspan="1" style="width: 83.4px;"
                                                    aria-label="Create Date: activate to sort column ascending">CREATED
                                                    BY
                                                </th>
                                                <th tabindex="0" aria-controls="example" rowspan="1"
                                                    colspan="1" style="width: 48.4px;"
                                                    aria-label="Status: activate to sort column ascending">
                                                    NOTE
                                                </th>
                                                <th tabindex="0" aria-controls="example" rowspan="1"
                                                    colspan="1" style="width: 62.4px;"
                                                    aria-label="Priority: activate to sort column ascending">ACTION
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody id="table-body">
                                            <c:choose>
                                                <c:when test="${requestScope.list.accountResponseList != null}">
                                                    <c:forEach varStatus="loop" var="a"
                                                               items="${requestScope.list.accountResponseList}">
                                                        <tr class="odd">
                                                            <td>${(list.pageNumber - 1) * list.pageSize + loop.index + 1}</td>
                                                            <td><a href="/accounting/detail/${a.id}"><c:out
                                                                    value="${a.id}"/></a>
                                                            </td>
                                                            <td style=""><c:out value="${a.payDate}"/></td>
                                                            <td style=""><c:out value="${a.title}"/></td>
                                                            <td class="${a.revenue > 0 ? 'text-bg-success' : ''}">
                                                                <fmt:formatNumber
                                                                        type="number" value="${a.revenue}"
                                                                        pattern="#,##0 ₫"/></td>
                                                            <td class="${a.expense < 0 ? 'text-bg-danger' : ''}">
                                                                <fmt:formatNumber
                                                                        type="number" value="${a.expense}"
                                                                        pattern="#,##0 ₫"/></td>
                                                            <td class="text-bg-primary"><fmt:formatNumber
                                                                    type="number" value="${a.remain}"
                                                                    pattern="#,##0 ₫"/></td>
                                                            <td style=""><span
                                                                    class="badge badge-soft-danger">${a.user.fullname}</span>
                                                            </td>
                                                            <td style="">
                                                                <a href="javascript:void(0)"
                                                                   class="cut-file-name"
                                                                   data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                   title="${a.note}">${a.note}</a>
                                                            </td>
                                                            <td>
                                                                <div class="dropdown d-inline-block">
                                                                    <button class="btn btn-soft-secondary btn-sm dropdown"
                                                                            type="button"
                                                                            data-bs-toggle="dropdown"
                                                                            aria-expanded="false">
                                                                        <i class="ri-more-fill align-middle"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu dropdown-menu-end"
                                                                        data-id="${a.id}">
                                                                        <li><a href="/accounting/detail/${a.id}"
                                                                               target="_blank" class="dropdown-item"><i
                                                                                class="ri-eye-fill align-bottom me-2 text-muted"></i>
                                                                            View</a>
                                                                        </li>
                                                                        <li class="deleteModal">
                                                                            <a class="dropdown-item remove-item-btn"
                                                                               href="#">
                                                                                <i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                                                Delete
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <c:set var="totalExpense" value="${totalExpense + a.expense}"
                                                               scope="page"/>
                                                        <c:set var="totalRevenue" value="${totalRevenue + a.revenue}"
                                                               scope="page"/>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan='10' class='text-center fw-bold'>NOT FOUND DATA IN
                                                            THIS
                                                            DURATION
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 col-md-5">
                                    </div>
                                    <div class="col-sm-12 col-md-7">
                                        <div class="dataTables_paginate paging_simple_numbers" id="example_paginate">
                                            <ul class="pagination" id="pagination">
                                                <c:choose>
                                                    <c:when test="${list.hasPrevious}">
                                                        <li class="paginate_button page-item previous"
                                                            id="first"><a
                                                                aria-controls="example" data-dt-idx="0"
                                                                tabindex="0"
                                                                class="page-link" onclick="loadPage(1)">First</a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button page-item previous disabled"
                                                            id="first"><a
                                                                aria-controls="example" data-dt-idx="0"
                                                                tabindex="0"
                                                                class="page-link" onclick="loadPage(1)">First</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${list.hasPrevious}">
                                                        <li class="paginate_button page-item previous"
                                                            id="previous"><a
                                                                aria-controls="example" data-dt-idx="0"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.pageNumber - 1})">Previous</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button page-item previous disabled"
                                                            id="previous"><a
                                                                aria-controls="example" data-dt-idx="0"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.pageNumber - 1})">Previous</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:forEach var="page" begin="1" end="${list.totalPages}">
                                                    <c:choose>
                                                        <c:when test="${page == list.pageNumber}">
                                                            <li class="paginate_button page-item active"><a
                                                                    style="cursor: pointer"
                                                                    aria-controls="example"
                                                                    data-dt-idx="1"
                                                                    tabindex="0"
                                                                    class="page-link">${page}</a>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li class="paginate_button page-item"><a
                                                                    style="cursor: pointer"
                                                                    aria-controls="example"
                                                                    data-dt-idx="1"
                                                                    tabindex="0"
                                                                    class="page-link"
                                                                    onclick="loadPage(${page})">${page}</a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                                <c:choose>
                                                    <c:when test="${list.hasNext}">
                                                        <li class="paginate_button page-item next"
                                                            id="next"><a
                                                                style="cursor: pointer"
                                                                aria-controls="example" data-dt-idx="3"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.pageNumber + 1})">Next</a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button page-item next disabled"
                                                            id="next"><a
                                                                aria-controls="example" data-dt-idx="3"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.pageNumber + 1})">Next</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${list.hasNext}">
                                                        <li class="paginate_button page-item next" id="last"><a
                                                                style="cursor: pointer"
                                                                aria-controls="example" data-dt-idx="3"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.totalPages})">Last</a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button page-item next disabled" id="last"><a
                                                                aria-controls="example" data-dt-idx="3"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${list.totalPages})">Last</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-responsive table-card">
                <table class="table table-nowrap table-hover mb-0 mt-4">
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Total Revenue</th>
                        <th scope="col">Total Expense</th>
                        <th scope="col">Ending Balance</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr id="total">
                        <th>Page ${list.pageNumber}</th>
                        <td class="text-success"><fmt:formatNumber type="number" value="${totalRevenue}"
                                                                   pattern="#,##0 ₫"/></td>
                        <td class="text-danger"><fmt:formatNumber type="number" value="${totalExpense}"
                                                                  pattern="#,##0 ₫"/></td>
                        <td class="text-primary"><fmt:formatNumber type="number" value="${totalRevenue + totalExpense}"
                                                                   pattern="#,##0 ₫"/></td>
                    </tr>
                    <tr>
                        <th>Total in Month</th>
                        <td class="text-success" id="totalRevenue"><fmt:formatNumber type="number"
                                                                                     value="${list.totalList.totalRevenue}"
                                                                                     pattern="#,##0 ₫"/></td>
                        <td class="text-danger" id="totalExpense"><fmt:formatNumber type="number"
                                                                                    value="${list.totalList.totalExpense}"
                                                                                    pattern="#,##0 ₫"/></td>
                        <td class="text-primary" id="totalRemain"><fmt:formatNumber type="number"
                                                                                    value="${list.totalList.totalRemain}"
                                                                                    pattern="#,##0 ₫"/></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createModalLabel">Create Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <!-- Your create form content goes here -->
                                <form enctype="multipart/form-data">
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="createTitle" class="form-label">Title</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="createTitle" required
                                                   placeholder="Enter title">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="createPayDate" class="form-label">Pay Date</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="date" class="form-control" id="createPayDate" required>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="transactionType" class="form-label">Transaction Type</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <select class="form-control" id="transactionType" required>
                                                <option value="">--Select Option--</option>
                                                <option value="revenue">Revenue</option>
                                                <option value="expense">Expense</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3" id="amountGroup" style="display: none;">
                                        <div class="col-lg-3">
                                            <label for="amount" class="form-label">Amount</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="amount" value="0" step="1"
                                                   required
                                                   pattern="[0-9]+">
                                        </div>
                                    </div>

                                    <script>
                                        var amount = $('input#amount').val()
                                        $('input#amount').val(formatNumberToVND(amount));

                                        function formatNumberToVND(number) {
                                            var parts = number.toString().split('.');

                                            var integerPart = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                                            var formattedNumber = integerPart;
                                            if (parts.length > 1) {
                                                formattedNumber += '.' + parts[1];
                                            }
                                            return formattedNumber;
                                        }

                                        $(document).ready(function () {
                                            $(document).ready(function () {
                                                var input = $('#amount');
                                                input.on('keydown', function (event) {
                                                    var value = input.val();
                                                    var charCode = event.which;
                                                    if (charCode === 190 || charCode === 110) {
                                                        if (value.indexOf('.') !== -1) {
                                                            event.preventDefault();
                                                        }
                                                    }
                                                    if ((charCode < 48 || charCode > 57) && (charCode < 96 || charCode > 105) && charCode !== 190 && charCode !== 110) {
                                                        if (charCode !== 8 && charCode !== 46) {
                                                            event.preventDefault();
                                                        }
                                                    }
                                                });

                                                input.on('keyup', function () {
                                                    var value = input.val().replace(/[^0-9.]/g, '');
                                                    input.val(formatNumberToVND(value));
                                                });
                                            });
                                        })
                                    </script>
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="createNote" class="form-label">Note</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="createNote" required>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Attached files</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered text-center">
                                    <thead>
                                    <tr>
                                        <th class="text-center col-6">File Format</th>
                                        <th class="text-center col-3">Maximum Size</th>
                                        <th class="text-center col-3">Maximum Files</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="text-center col-6">${setting.listTypeFile},${setting.listTypeImage}</td>
                                        <td class="text-center col-3">${setting.maxFileSize} MB</td>
                                        <td class="text-center col-3">${setting.uploadFileLimit}</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div>
                                    <p class="text-muted">Add Attached files here.</p>

                                    <div class="dropzone" id="dropzoneCreate">
                                        <div class="fallback">
                                            <input name="file" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>

                                            <h5>Drop files here or click to upload.</h5>
                                        </div>
                                    </div>

                                    <ul class="list-unstyled mb-0" id="dropzone-preview">
                                        <li class="mt-2" id="dropzone-preview-list">
                                            <!-- This is used as the file preview template -->
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="d-flex p-2">
                                                        <div class="flex-shrink-0 me-3">
                                                            <div class="avatar-sm">
                                                                <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                    <i class="ri-file-upload-line"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger"
                                                                    data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3 pt-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- end dropzon-preview -->
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-primary createBtn" type="button">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal HTML -->
<div class="modal zoomIn" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Inform!</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                The request has been completed successfully.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal zoomIn" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-center" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Bad Request</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                An error occurred while sending the request. Please try again.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="remainModal" tabindex="-1" role="dialog" aria-labelledby="remainModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-center" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="remainModalLabel">Remain Balance Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body" id="generate-remain">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <!-- Your edit form content goes here -->
                                <form enctype="multipart/form-data">
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="editTitle">Title</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="editTitle"
                                                   value="${account.title}" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="transactionType">Transaction Type</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <select class="form-control" id="transactionEditType" required>
                                                <option value="">--Select Option--</option>
                                                <option value="revenue" ${account.revenue > 0 ? 'selected' : ''}>
                                                    Revenue
                                                </option>
                                                <option value="expense" ${account.expense < 0 ? 'selected' : ''}>
                                                    Expense
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row mb-3" id="amountEditGroup">
                                        <div class="col-lg-3">
                                            <label for="amountEdit">Amount</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="amountEdit" step="1"
                                                   value="${account.revenue > 0 ? account.revenue : -account.expense}"
                                                   required
                                                   pattern="[0-9]+">
                                        </div>
                                    </div>
                                    <script>
                                        var amount = $('input#amount').val()
                                        $('input#amount').val(formatNumberToVND(amount));

                                        function formatNumberToVND(number) {
                                            var parts = number.toString().split('.');
                                            var formattedNumber = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                                            if (parts.length > 1) {
                                                formattedNumber += '.' + parts[1];
                                            }
                                            return formattedNumber;
                                        }

                                        $(document).ready(function () {
                                            $(document).ready(function () {
                                                var input = $('#amount');
                                                input.on('keydown', function (event) {
                                                    var value = input.val();
                                                    var charCode = event.which;
                                                    if (charCode === 190 || charCode === 110) {
                                                        if (value.indexOf('.') !== -1) {
                                                            event.preventDefault();
                                                        }
                                                    }
                                                    if ((charCode < 48 || charCode > 57) && (charCode < 96 || charCode > 105) && charCode !== 190 && charCode !== 110) {
                                                        if (charCode !== 8 && charCode !== 46) {
                                                            event.preventDefault();
                                                        }
                                                    }
                                                });

                                                input.on('keyup', function () {
                                                    var value = input.val().replace(/[^0-9.]/g, '');
                                                    input.val(formatNumberToVND(value));
                                                });
                                            });
                                        })
                                    </script>
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="editNote">Note</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <textarea class="form-control" id="editNote"
                                                      required>${account.note}</textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="pt-3 border-top border-top-dashed mt-4">
                                            <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                                            <div class="row g-3 showFilesUploaded">
                                            </div>
                                            <!-- end row -->
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Attached files</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered text-center">
                                    <thead>
                                    <tr>
                                        <th class="text-center col-6">File Format</th>
                                        <th class="text-center col-3">Maximum Size</th>
                                        <th class="text-center col-3">Maximum Files</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="text-center col-6">${setting.listTypeFile},${setting.listTypeImage}</td>
                                        <td class="text-center col-3">${setting.maxFileSize} MB</td>
                                        <td class="text-center col-3">${setting.uploadFileLimit}</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div>
                                    <p class="text-muted">Add Attached files here.</p>

                                    <div class="dropzone" id="dropzoneEdit">
                                        <div class="fallback">
                                            <input name="file" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>

                                            <h5>Drop files here or click to upload.</h5>
                                        </div>
                                    </div>

                                    <ul class="list-unstyled mb-0" id="dropzone-preview-edit">
                                        <li class="mt-2" id="dropzone-preview-list-edit">
                                            <!-- This is used as the file preview template -->
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="d-flex p-2">
                                                        <div class="flex-shrink-0 me-3">
                                                            <div class="avatar-sm">
                                                                <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                    <i class="ri-file-upload-line"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger"
                                                                    data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3 pt-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- end dropzon-preview -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class=" modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-primary editBtn" type="submit">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

<script src="/assets/custom/js/notification/notification.js"></script>
<script>
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
    var htmlElement = document.documentElement;
    cutShortLink();
    const baseUrlAccount = "/api/v1/accounts/";
    const INVALID_FILLED_TEXT = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> This field is not filled' +
        '</div>'
    const INVALID_FILES_LIMIT = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> Maximum Files is ${setting.uploadFileLimit}' +
        '</div>'

    const INVALID_FILES_TYPE = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> File type allowed: ${setting.listTypeFile}' + ' and ${setting.listTypeImage}' +
        '</div>'

    const INVALID_FILES_SIZE = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> Maximum Size Files is ${setting.maxFileSize}' +
        '</div>'
    window.onload = function () {
        var defaultDate = new Date();
        var currentYear = defaultDate.getFullYear();
        var currentMonth = defaultDate.getMonth() + 1;
        var formattedTextStartDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-01';
        document.getElementById("datePickerStart").value = formattedDateToText(formattedTextStartDate);
        localStorage.setItem("selectedDateStart", formattedDateToText(formattedTextStartDate));

        var lastDay = new Date(currentYear, currentMonth, 0);
        var lastDayOfMonth = lastDay.getDate();
        var formattedTextEndDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-' + lastDayOfMonth;
        document.getElementById("datePickerEnd").value = formattedDateToText(formattedTextEndDate);
        localStorage.setItem("selectedDateEnd", formattedDateToText(formattedTextEndDate));
    }

    document.getElementById("pageCount").addEventListener("change", function () {
        loadPage(1);
    });

    window.addEventListener("beforeunload", function () {
        localStorage.removeItem("selectedPageSize");
        localStorage.removeItem("selectedDateStart");
        localStorage.removeItem("selectedDateEnd");
        document.getElementById("datePickerStart").value = "";
        document.getElementById("datePickerEnd").value = "";
    });

    document.getElementById("datePickerStart").addEventListener("input", function () {
        localStorage.setItem("selectedDateStart", this.value);
    });

    document.getElementById("datePickerEnd").addEventListener("input", function () {
        localStorage.setItem("selectedDateEnd", this.value);
    });

    var url = window.location.href;
    var segments = url.split("/");
    var month = segments[segments.length - 1];

    document.addEventListener("DOMContentLoaded", function () {
        if (!isDeleveloper()) {
            var yearSelect = document.getElementById('account-year');
            var monthSelect = document.getElementById('account-month');
            var data;
            callAjaxByJsonWithData('/api/v1/accounts/total-month', 'GET', null, function (rs) {
                data = rs;
                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
                data.monthList.forEach(function (entry) {
                    let option = document.createElement('option');
                    option.value = entry.year;
                    option.textContent = entry.year;
                    yearSelect.appendChild(option);
                });
                $("#containerAccounting").removeClass("d-none")
                $("div.containerLoading").addClass("d-none");
            });

            yearSelect.addEventListener('change', function () {
                $("div.yearLoading").removeClass("d-none");
                callAjaxByJsonWithData('/api/v1/accounts/total-month', 'GET', null, function (rs) {
                    var dataMonth = rs;
                    monthSelect.innerHTML = '<option value="">-- Select Month --</option>';
                    dataMonth.monthList.forEach(function (entry) {
                        if (yearSelect.value === entry.year) {
                            entry.month.forEach(function (target) {
                                var option = document.createElement('option');
                                option.value = target;
                                option.textContent = target;
                                monthSelect.appendChild(option);
                            })
                        }
                    });
                    if (yearSelect.value !== "") {
                        monthSelect.style.display = 'block';
                    } else {
                        monthSelect.style.display = 'none';
                    }
                    $("div.yearLoading").addClass("d-none");
                });

            });

            monthSelect.addEventListener('change', function () {
                month = yearSelect.value + "-" + monthSelect.value;
                let defaultDate = new Date(month);
                let pickYear = defaultDate.getFullYear();
                let pickMonth = defaultDate.getMonth() + 1;
                let formattedTextStartDate = pickYear + '-' + (pickMonth < 10 ? '0' : '') + pickMonth + '-01';
                localStorage.setItem("selectedDateStart", formattedDateToText(formattedTextStartDate));
                document.getElementById("datePickerStart").value = formattedDateToText(formattedTextStartDate);

                let lastDay = new Date(pickYear, pickMonth, 0);
                let lastDayOfMonth = lastDay.getDate();
                let formattedTextEndDate = pickYear + '-' + (pickMonth < 10 ? '0' : '') + pickMonth + '-' + lastDayOfMonth;
                localStorage.setItem("selectedDateEnd", formattedDateToText(formattedTextEndDate));
                document.getElementById("datePickerEnd").value = formattedDateToText(formattedTextEndDate);
                loadPage(1);
            });
        }
    });

    $(document).on("click", "button.viewRemain", function () {
        $(this).addClass("d-none")
        $(this).before(BtnPrimaryLoad);
        callAjaxByJsonWithData(baseUrlAccount + "balance", 'GET', null,
            function (rs) {
                let xhtml = "";
                let result = 0;
                rs.forEach(data => {
                    let remainAsNumber = parseFloat(data.remain);
                    if (!isNaN(remainAsNumber)) {
                        result += remainAsNumber;
                        xhtml += '<div class="row mb-3">' +
                            '<div class="col-lg-6">' +
                            '<label>' + data.yearMonth + '</label>' +
                            '</div>' +
                            '<div class="col-lg-6">' +
                            '<p class="float-end">' + formatCurrency(remainAsNumber) + '</p></div></div>';

                    }
                })
                xhtml += '<hr>' + '<div class="row mb-3">' +
                    '<div class="col-lg-6">' +
                    '<label>Total remains</label>' +
                    '</div>' +
                    '<div class="col-lg-6">' +
                    '<p class="float-end">' + formatCurrency(result) + '</p></div></div>'
                let remainList = document.getElementById("generate-remain");
                remainList.innerHTML = xhtml;
                BtnLoadRemove()
                $("button.viewRemain").removeClass("d-none")
                $("#remainModal").modal("show")
            },
            function (error) {
                console.log(error)
            })
    })

    function loadPage(page) {
        $("div.containerLoading").removeClass("d-none");
        var selectedPageSize = document.getElementById("pageCount").value;
        var selectedDateStart = localStorage.getItem("selectedDateStart") || null;
        var selectedDateEnd = localStorage.getItem("selectedDateEnd") || null;

        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var responseData = JSON.parse(xhr.responseText);

                    var tableBody = document.getElementById("table-body");

                    var totalSpend = document.getElementById("total");

                    var totalExpense = 0;
                    var totalRevenue = 0;
                    var totalRemain = 0;

                    if (responseData.accountResponseList === null || responseData.accountResponseList.length === 0) {
                        tableBody.innerHTML = "";
                        let row = tableBody.insertRow();
                        row.innerHTML = "<td colspan='10' class='text-center fw-bold'>NOT FOUND DATA IN THIS DURATION</td>";
                    } else {
                        tableBody.innerHTML = "";
                        responseData.accountResponseList.forEach((account, index) => {
                            var row = tableBody.insertRow();
                            row.innerHTML = "<td>" + ((page - 1) * selectedPageSize + index + 1) + "</td>" +
                                "<td><a href='/accounting/detail/" + account.id + "'>" + account.id + "</a></td>" +
                                "<td style=''>" + account.payDate + "</td>" +
                                "<td style=''>" + account.title + "</td>" +
                                "<td class='" + (account.revenue > 0 ? 'text-bg-success' : '') + "'>" + formatCurrency(account.revenue) + "</td>" +
                                "<td class='" + (account.expense < 0 ? 'text-bg-danger' : '') + "'>" + formatCurrency(account.expense) + "</td>" +
                                "<td class='text-bg-primary'>" + formatCurrency(account.remain) + "</td>" +
                                "<td style=''><span class='badge badge-soft-danger'> " + account.user.fullname + "</span></td>" +

                                "<td style=''><a href='javascript:void(0)' class='cut-file-name' data-toggle='tooltip' data-bs-placement='bottom' title='" + account.note + "'>" + account.note + "</a></td>" +
                                "<td style=''><div class='dropdown d-inline-block'>" +
                                "<button class='btn btn-soft-secondary btn-sm dropdown' type='button' data-bs-toggle='dropdown' aria-expanded='false'>" +
                                "<i class='ri-more-fill align-middle'></i></button><ul class='dropdown-menu dropdown-menu-end' data-id='" + account.id + "'>" +
                                "<li><a href='/accounting/detail/" + account.id + "' target='_blank' class='dropdown-item'><i class='ri-eye-fill align-bottom me-2 text-muted'></i>View</a></li>" +
                                "<li class='deleteModal'><a href='javascript: void(0);' class='dropdown-item remove-item-btn'><i class='ri-delete-bin-fill align-bottom me-2 text-muted'></i>Delete</a>" +
                                "</li></ul></div>" +
                                "</td>";
                            totalExpense += account.expense;
                            totalRevenue += account.revenue;
                            totalRemain = account.remain;
                        });
                        $("#totalRevenue").text(formatCurrency(responseData.totalList.totalRevenue))
                        $("#totalExpense").text(formatCurrency(responseData.totalList.totalExpense))
                        $("#totalRemain").text(formatCurrency(responseData.totalList.totalRemain))
                        cutShortLink();
                        $(function () {
                            $('[data-toggle="tooltip"]').tooltip();
                        })
                    }

                    updatePagination(responseData);

                    totalSpend.innerHTML = '<th>Page ' + page + '</th>' + '<td class="text-success">' + formatCurrency(totalRevenue) + '</td>'
                        + '<td class="text-danger">' + formatCurrency(totalExpense) + '</td>'
                        + '<td class="text-primary">' + formatCurrency(totalRemain) + '</td>';
                    $("div.containerLoading").addClass("d-none")
                } else {
                    $('#errorModal').modal('show');
                    $("div.containerLoading").addClass("d-none")
                }
            }
        };
        xhr.open("GET", "/api/v1/accounts/" + "?page=" + page + "&size=" + selectedPageSize + "&startDate=" + formattedDate(selectedDateStart) + "&endDate=" + formattedDate(selectedDateEnd), true);
        xhr.send();
    }

    function updatePagination(responseData) {
        var pagination = document.getElementById("pagination");
        var totalPages = responseData.totalPages;
        var currentPage = responseData.pageNumber;

        var paginationHTML = "";

        function createListItem(text, pageNumber, isDisabled) {
            return '<li class="paginate_button page-item ' + (isDisabled ? 'disabled' : '') + '">' +
                '<a style="cursor: pointer" aria-controls="example" data-dt-idx="0" tabindex="0" class="page-link" ' +
                'onclick="loadPage(' + pageNumber + ')">' + text + '</a></li>';
        }

        paginationHTML += createListItem('First', 1, !responseData.hasPrevious);
        paginationHTML += createListItem('Previous', currentPage - 1, !responseData.hasPrevious);

        for (var page = 1; page <= totalPages; page++) {
            paginationHTML += '<li class="paginate_button page-item ' + (page === currentPage ? 'active' : '') + '">' +
                '<a style="cursor: pointer" aria-controls="example" data-dt-idx="1" tabindex="0" class="page-link" ' +
                'onclick="loadPage(' + page + ')">' + page + '</a></li>';
        }

        paginationHTML += createListItem('Next', currentPage + 1, !responseData.hasNext);
        paginationHTML += createListItem('Last', totalPages, !responseData.hasNext);

        pagination.innerHTML = paginationHTML;

    }


    var validFileUpload = "${setting.listTypeFile}" + "," + "${setting.listTypeImage}";
    var validExtensions = validFileUpload.split(',');
    var spanElement = $("#createModal #validFileText");
    spanElement.text("*File must be " + validFileUpload + ", file not over " + "${setting.maxFileSize}" + " and below " + "${setting.uploadFileLimit}" + " files");

    document.getElementById('transactionType').addEventListener('change', function () {
        var selectedOption = this.value;
        var amountGroup = document.getElementById('amountGroup');
        var amountInput = document.getElementById('amount');

        if (selectedOption === 'revenue') {
            amountGroup.style.display = 'flex';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        } else if (selectedOption === 'expense') {
            amountGroup.style.display = 'flex';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        } else {
            amountGroup.style.display = 'none';
        }
    });
</script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>

<script>
    $(function () {
        $('[data-bs-toggle="tooltip"]').tooltip();
    })

    let listTypeFileArr = validExtensions
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index) => {
        listTypeFile += "." + item
        if (index < listTypeFileArr.length) {
            listTypeFile += ","
        }
    })
    let maxFileSize = "${setting.maxFileSize}"
    let uploadFileLimit = "${setting.uploadFileLimit}"

    var dropzonePreviewNode = document.querySelector("#dropzone-preview-list");
    dropzonePreviewNode.id = "";
    var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
    dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
    var dropzone = new Dropzone("#dropzoneCreate", {
        url: 'https://httpbin.org/post',
        method: "post",
        previewTemplate: previewTemplate,
        previewsContainer: "#dropzone-preview",
        acceptedFiles: listTypeFile,
        maxFilesize: parseInt(maxFileSize),
        maxFiles: parseInt(uploadFileLimit),
        uploadMultiple: true,
        autoProcessQueue: false,
    });

    dropzone.on("addedfile", function (file) {
        removeAlert();
        let files = dropzone.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if (!checkLimitFile(files.length, parseInt(uploadFileLimit))) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_LIMIT)
            return
        }
        if (!checkTypeFile(fileExtension, listTypeFileArr)) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_TYPE)
            return
        }
        if (!checkLimitSize(bytesToMB(fileSize), parseInt(maxFileSize))) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_TYPE)
        }
    });

    $(document).on("click", "button.createBtn", function () {
        removeAlert();
        let title = $("#createTitle").val()
        let note = $("#createNote").val()
        let transaction = $("#transactionType").val()
        var payDate = $("#createPayDate").val();
        let input = document.getElementById("amount").value;
        let amount = Number(input.replace(/[^0-9.]/g, ''))
        if (transaction === 'expense') {
            amount = -amount;
        }
        if (title.trim() === "") {
            $("input#createTitle").parent().after(INVALID_FILLED_TEXT)
            return false;
        }
        if (!payDate) {
            $("input#createPayDate").parent().after(INVALID_FILLED_TEXT)
            return false;
        }
        if (!transaction) {
            $("select#transactionType").parent().after(INVALID_FILLED_TEXT)
            return false;
        }
        if (!amount) {
            $("input#amount").parent().after(INVALID_FILLED_TEXT)
            return false;
        }
        var formData = new FormData();
        formData.append("title", title);
        formData.append("note", note);
        formData.append("userId", userCurrent.id);
        formData.append("expense", amount);
        formData.append("payDate", payDate);
        if (dropzone.files.length > 0) {
            for (let i = 0; i < dropzone.files.length; i++) {
                let file = dropzone.files[i]
                if (file.accepted) {
                    formData.append("bill", file);
                }
            }
        }
        $(this).addClass("d-none")
        $(this).before(BtnPrimaryLoad)
        callAjaxByDataFormWithDataForm(baseUrlAccount, "POST", formData, function (rs) {
            BtnLoadRemove()
            $("button.createBtn").removeClass("d-none")
            $("#createModal").modal("hide");
            rsSuccess("Created")
            let yearSelect = document.getElementById('account-year');
            callAjaxByJsonWithData('/api/v1/accounts/total-month', 'GET', null, function (rs) {
                let data = rs;
                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
                data.monthList.forEach(function (entry) {
                    let option = document.createElement('option');
                    option.value = entry.year;
                    option.textContent = entry.year;
                    yearSelect.appendChild(option);
                });
            });
            loadPage(1);
        }, function (error) {
            rsUnSuccess();
            console.log(error)
        })
    })

    $(document).on('click', '.deleteModal', function () {
        let accountId = $(this).parent().attr("data-id")
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel!',
            confirmButtonClass: 'btn btn-primary w-xs ms-2 mt-2',
            cancelButtonClass: 'btn btn-danger w-xs mt-2',
            buttonsStyling: false,
            showCloseButton: true,
            reverseButtons: true
        }).then(function (result) {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Loading',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    showConfirmButton: false,
                    willOpen: () => {
                        Swal.showLoading();
                    }
                });
                let xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Your accounting has been deleted.',
                                icon: 'success',
                                confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                buttonsStyling: false
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    loadPage(1);
                                }
                            });
                        } else {
                            $('#deleteModal').modal('hide');
                            $('#errorModal').modal('show');
                        }
                    }
                }
                xhr.open("DELETE", "/api/v1/accounts/" + accountId, true);
                xhr.send();
            } else if (
                // Read more about handling dismissals
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire({
                    title: 'Cancelled',
                    text: 'Your information is remained :)',
                    icon: 'error',
                    confirmButtonClass: 'btn btn-primary mt-2',
                    buttonsStyling: false
                })
            }
        });
    });

</script>
<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="/assets/js/pages/datatables.init.js"></script>
<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
</body>
</html>

