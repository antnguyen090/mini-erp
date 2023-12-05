<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accounting Detail</title>
    <link href="/assets/libs/dropzone/dropzone.css" rel="stylesheet" type="text/css">
    <script src="../../../assets/custom/js/accounting/accounting.js"></script>
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">ACCOUNTING DETAIL</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/accounting">Accounting</a></li>
                    <li class="breadcrumb-item active">Detail</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<div class="container">
    <div class="card shadow">
        <div class="card-header align-items-center d-flex">
            <h4 class="card-title mb-0 flex-grow-1" id="titleAccount">${account.title}</h4>
        </div>
        <div class="card-body" id="viewAccount" data-id="${account.id}">
            <div class="text-muted">
                <div class="pb-3 border-bottom border-bottom-dashed mb-4 ">
                    <div class="row">
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Create Date :</p>
                                <h5 class="fs-15 mb-0" id="createdDateAccount">${account.createdDate}</h5>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Pay Date :</p>
                                <h5 class="fs-15 mb-0" id="payDateAccount">${account.payDate}</h5>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Last user created/edited :</p>
                                <div class="badge bg-danger fs-12" id="fullnameAccount">${account.user.fullname}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-success text-success rounded-2 fs-2">
                                                <i class="bx bxs-badge-dollar"></i>
                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Revenue</p>
                                    <h4 class="fs-4 mb-3"><span id="revenueAccount"><fmt:formatNumber type="number"
                                                                                                      value="${account.revenue}"
                                                                                                      pattern="#,##0 ₫"/></span>
                                    </h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-danger text-danger rounded-2 fs-2">
                                                <i class="bx bxs-cart-download"></i>
                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Expense</p>
                                    <h4 class="fs-4 mb-3"><span id="expenseAccount"><fmt:formatNumber type="number"
                                                                                                      value="${account.expense}"
                                                                                                      pattern="#,##0 ₫"/></span>
                                    </h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-primary text-primary rounded-2 fs-2">
                                                <i class="bx bxs-box"></i>

                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Balance</p>
                                    <h4 class="fs-4 mb-3"><span id="remainAccount"><fmt:formatNumber type="number"
                                                                                                     value="${account.remain}"
                                                                                                     pattern="#,##0 ₫"/></span>
                                    </h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
            </div>

            <div class="alert alert-warning alert-dismissible alert-label-icon rounded-label fade show" role="alert">
                <i class="ri-clipboard-fill label-icon"></i><strong>Note</strong> - <span
                    id="noteAccount">${account.note}</span>
            </div>
            <div class="pt-3 border-top border-top-dashed mt-4">
                <h6 class="mb-3 fw-semibold text-uppercase">Bills</h6>
                <div class="d-flex justify-content-center align-items-center fileLoading ms-2 d-none">
                                <span class="spinner-grow flex-shrink-0" role="status">
                                    <span class="visually-hidden"> Loading...</span>
                                </span>
                </div>
                <div class="row g-3 showFilesUploaded">
                </div>
            </div>
        </div>
        <div class="card-footer" data-id="${account.id}">
            <button class="btn btn-primary editAccount" data-bs-toggle="modal" data-bs-target="#editModal">Edit
            </button>
            <button class="btn btn-danger" id="deleteModal">Delete</button>
            <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#cancelModal" onclick="goBack()">
                Cancel
            </button>
        </div>
    </div>
</div>

<!-- Edit Modal -->
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
                                            <label for="editPayDate">Pay date</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="date" class="form-control" id="editPayDate" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="transactionType">Transaction Type</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <select class="form-control" id="transactionType" required>
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
                                    <div class="row mb-3" id="amountGroup">
                                        <div class="col-lg-3">
                                            <label for="amount">Amount</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="amount" step="1"
                                                   value="${account.revenue > 0 ? account.revenue : -account.expense}"
                                                   required
                                                   pattern="[0-9]+">
                                        </div>
                                    </div>
                                    <script>
                                        convertPayDate('${account.payDate}');
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
                                            <div class="d-flex justify-content-center align-items-center fileLoading ms-2 d-none">
                                                <span class="spinner-grow flex-shrink-0" role="status">
                                                    <span class="visually-hidden"> Loading...</span>
                                                </span>
                                            </div>
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

<div class="modal zoomIn" id="deleteConfirmationModalFile" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalFile" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalFileLabel">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this file?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" id="deleteFileButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="deleteFileModal" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                               colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you Sure?</h4>
                        <p class="text-muted mx-4 mb-0">
                            Are you Sure You want to Delete this File?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteFileBtn">Yes, Delete It!</button>
                </div>
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
    var validFileUpload = "${setting.listTypeFile}" + "," + "${setting.listTypeImage}";
    var validExtensions = validFileUpload.split(',');
    var spanElement = $("#editModal #validFileText");
    spanElement.text("*File must be " + validFileUpload + ", file not over " + "${setting.maxFileSize}" + "MB and maximum " + "${setting.uploadFileLimit}" + " files");

    document.getElementById("deleteModal").addEventListener("click", function () {
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
                            Swal.close();
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Your accounting has been deleted.',
                                icon: 'success',
                                confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                buttonsStyling: false
                            }).then((result) => {
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
                                    window.location.replace(document.referrer);
                                }
                            });
                        } else {
                            rsUnSuccess();
                            $('#deleteModal').modal('hide');
                        }
                    }
                }
                xhr.open("DELETE", "/api/v1/accounts/" + "${account.id}", true);
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

    document.addEventListener("DOMContentLoaded", function () {
        let fileNameArr = [];
        <c:if test="${account.bill != null}">
        <c:forEach items="${account.bill}" var="value" varStatus="loop">
        fileNameArr.push('${value}');
        </c:forEach>
        loadFilesName(fileNameArr);
        </c:if>
    });

    $(document).on("click", "button.downFileBtn", function () {
        let dataUrl = $(this).children().attr("data-url")
        downloadFiles(dataUrl)
    })

    $(document).on("click", "button.deleteFileBtn", function () {
        let fileName = $(this).children().attr("data-name")
        $("#deleteFileModal").attr("data-name", fileName)
        $("#deleteFileModal").modal("show")
    })

    $(document).on("click", "button#deleteFileBtn", function () {
        let fileName = $("#deleteFileModal").attr("data-name")
        $('#editModal div.showFilesUploaded > div[data-name="' + fileName + '"]').remove();
        $("#deleteFileModal").modal("hide")
        dropzoneEdit.options.maxFiles = dropzoneEdit.options.maxFiles + 1;
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

    var dropzonePreviewNodeEdit = document.querySelector("#dropzone-preview-list-edit");
    var previewTemplateEdit = dropzonePreviewNodeEdit.parentNode.innerHTML;
    dropzonePreviewNodeEdit.id = "";
    dropzonePreviewNodeEdit.parentNode.removeChild(dropzonePreviewNodeEdit);
    var dropzoneEdit = new Dropzone("#dropzoneEdit", {
        url: 'https://httpbin.org/post',
        method: "post",
        previewTemplate: previewTemplateEdit,
        previewsContainer: "#dropzone-preview-edit",
        acceptedFiles: listTypeFile,
        maxFilesize: parseInt(maxFileSize),
        maxFiles: parseInt(uploadFileLimit),
        uploadMultiple: true,
        autoProcessQueue: false,
    });


    dropzoneEdit.on("addedfile", function (file) {
        removeAlert();
        let files = dropzoneEdit.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if (!checkLimitFile(files.length, parseInt(dropzoneEdit.options.maxFiles))) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_LIMIT)
            return
        }
        if (!checkTypeFile(fileExtension, listTypeFileArr)) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_TYPE)
            return
        }
        if (!checkLimitSize(bytesToMB(fileSize), parseInt(maxFileSize))) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_SIZE)
        }
    });

    $(document).on("click", "button.editAccount", function () {
        Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
        $("div.fileLoading").removeClass("d-none");
        $(this).addClass("d-none")
        $(this).before(BtnPrimaryLoad)
        let accountId = $(this).parent().attr("data-id")
        if (accountId) {
            callAjaxByJsonWithData(baseUrlAccount + "detail/" + accountId, 'GET', null,
                function (rs) {
                    $("#editModal").attr("data-id", rs.id)
                    let urlFiles = rs.bill ? rs.bill : []
                    let fileLength = rs.bill ? rs.bill.length : 0
                    dropzoneEdit.options.maxFiles = parseInt(uploadFileLimit) - fileLength;
                    let html = ""
                    if (fileLength > 0) {
                        urlFiles.forEach(function (url) {
                            $.ajax({
                                type: "HEAD",
                                url: url,
                                success: function (data, status, xhr) {
                                    var contentLength = xhr.getResponseHeader('Content-Length');
                                    var fileName = url.substring(url.lastIndexOf("/") + 1);
                                    html += showFileUploaded(fileName, contentLength, url, "edit")
                                    $("#editModal div.showFilesUploaded").html(html);
                                }
                            });
                        });
                    }
                    $("div.fileLoading").addClass("d-none");
                    BtnLoadRemove();
                    $("button.editAccount").removeClass("d-none");
                },
                function (error) {
                    console.log(error)
                }
            )
        }
    })

    $(document).on("click", "button.editBtn", function () {
        removeAlert();
        $(this).addClass("d-none")
        $(this).before(BtnPrimaryLoad)
        let accountId = $("#editModal").attr("data-id")
        let title = $("#editTitle").val()
        let payDate = $("#editPayDate").val()
        let note = $("#editNote").val()
        let transaction = $("#transactionType").val()
        let input = document.getElementById("amount").value;
        let amount = Number(input.replace(/[^0-9.]/g, ''))
        if (transaction === 'expense') {
            amount = -amount;
        }
        if (title.trim() === "") {
            $("input#editTitle").parent().after(INVALID_FILLED_TEXT)
            return false;
        }
        if (!payDate) {
            $("input#editPayDate").parent().after(INVALID_FILLED_TEXT)
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
        var oldFile = []
        $("#editModal div.showFilesUploaded > div").each(function () {
            oldFile.push($(this).attr("data-name"));
        });

        var formData = new FormData();
        formData.append("title", title);
        formData.append("note", note);
        formData.append("id", accountId);
        formData.append("payDate", payDate);
        formData.append("oldFile", oldFile);
        formData.append("userId", userCurrent.id);
        formData.append("expense", amount);

        if (dropzoneEdit.files.length > 0) {
            for (let i = 0; i < dropzoneEdit.files.length; i++) {
                let file = dropzoneEdit.files[i]
                if (file.accepted) {
                    formData.append("bill", file);
                }
            }
        }

        callAjaxByDataFormWithDataForm(baseUrlAccount + "edit", "POST", formData, function (rs) {
            if (rs) {
                $("#titleAccount").text(rs.title);
                $("#createdDateAccount").text(rs.createdDate);
                $("#payDateAccount").text(rs.payDate);
                $("#revenueAccount").text(formatCurrency(rs.revenue));
                $("#expenseAccount").text(formatCurrency(rs.expense));
                $("#remainAccount").text(formatCurrency(rs.remain));
                $("#fullnameAccount").text(rs.user.fullname);
                $("#noteAccount").text(rs.note);
                let fileNameArr = []
                rs.bill.forEach(item => {
                    fileNameArr.push(item);
                })
                loadFilesName(fileNameArr);
                $('#editModal').modal('hide');
                BtnLoadRemove()
                $("button.editBtn").removeClass("d-none")
                rsSuccess("Updated")
                $('#editBill').val("");
            }
        }, function (error) {
            if (error) {
                rsUnSuccess();
                $('#editModal').modal('hide');
            }
        })
    })
</script>
<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
</body>
</html>

