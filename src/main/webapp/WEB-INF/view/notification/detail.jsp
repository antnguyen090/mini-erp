<%@ page import="com.webapp.erpapp.security.Principal" %>
<%@ page import="com.webapp.erpapp.enums.user.RoleEnum" %>
<%@ page import="com.webapp.erpapp.enums.Notification.StatusNotificationEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>

<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<html>
<head>
    <title>Notification Detail</title>
    <!-- Plugins css -->
    <link href="/assets/libs/dropzone/dropzone.css" rel="stylesheet" type="text/css">
    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
    <!-- bubble css for bubble editor-->
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
    <!-- snow css for snow editor-->
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />
    <style>
        #formEditNotification .ql-container {
            min-height: 10rem;
            height: 100%;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .ql-editor {
            height: 100%;
            flex: 1;
            overflow-y: auto;
            width: 100%;
        }

        #viewNotification .ql-bubble{
            border: none
        }

        .ql-editor p:has(> img) {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
        }
    </style>
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Notification Detail</h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/notifications">Notification</a></li>
                    <li class="breadcrumb-item active">Notification Detail</li>
                </ol>
            </div>
        </div>
    </div>
</div>
<!-- end page title -->
<div class="row position-relative notificationDetail" style="min-height: 80vh">
    <div class="col-lg-12">
        <div style="width: 3rem; height: 3rem; position: absolute; z-index: 999;top: 50%; left: 50%; transform: translate(-50%, -50%);" class="containerLoading d-flex align-items-center justify-content-center full-height">
            <div>
                <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
        </div>
        <div id="containerDetail" class="card d-none">
            <div id="viewNotification" class="card-body" data-id="${notification.id}">
                <div class="text-muted">
                    <h5 class="mb-3 fw-semibold text-uppercase titleView">
                        <strong class="fw-bolder fst-italic fs-4">${notification.title}</strong>
                    </h5>
                </div>
                <div class="text-muted">
                    <div id="contentView">
                    </div>
                    <div class="pt-3 border-top border-top-dashed mt-4">
                        <div class="row">

                            <div class="col-lg-3 col-sm-6">
                                <div>
                                    <p class="mb-2 text-uppercase fw-medium">Create Date :</p>
                                    <h5 class="fs-15 mb-0 createdDate">${notification.createdDate}</h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pt-3 border-top border-top-dashed mt-4">
                        <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                        <div class="row g-3 showFilesUploaded">
                        </div>
                        <!-- end row -->
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-end mt-2" data-id="${notification.id}">
                    <c:if test="${(userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)) && notification.status.equals(StatusNotificationEnum.ACTIVE)}">
                        <div class="editNotification">
                            <button class="btn btn-sm btn-success editNotification">Edit</button>
                        </div>
                        <div class="removeNotification">
                            <button class="btn btn-sm btn-danger removeNotification">Remove</button>
                        </div>
                    </c:if>
                    <c:if test="${notification.status.equals(StatusNotificationEnum.INACTIVE)}">
                        <div class="notificationDeleted">
                            <button class="btn btn-sm btn-danger remove-item-btn notificationDeleted" disabled>Deleted</button>
                        </div>
                    </c:if>
                    <c:if test="${notification.status.equals(StatusNotificationEnum.ACTIVE)}">
                        <div class="notificationShare">
                            <button class="btn btn-sm btn-secondary remove-item-btn notificationShare" >Share</button>
                        </div>
                    </c:if>
                    <div class="backToList">
                        <button class="btn btn-sm btn-dark backToList">Back to list</button>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header align-items-center d-flex">
                    <h4 class="card-title mb-0 flex-grow-1">Comments</h4>
                    <%--                    <div class="flex-shrink-0">--%>
                    <%--                        <div class="dropdown card-header-dropdown">--%>
                    <%--                            <a class="text-reset dropdown-btn" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                    <%--                                <span class="text-muted">Recent<i class="mdi mdi-chevron-down ms-1"></i></span>--%>
                    <%--                            </a>--%>
                    <%--                            <div class="dropdown-menu dropdown-menu-end">--%>
                    <%--                                <a class="dropdown-item" href="#">Recent</a>--%>
                    <%--                                <a class="dropdown-item" href="#">Top Rated</a>--%>
                    <%--                                <a class="dropdown-item" href="#">Previous</a>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                </div><!-- end card header -->
                <div class="card-body">
                    <div data-simplebar class="px-3 mx-n3 mb-2">
                        <div class="simplebar-wrapper" style="margin: 0px -16px;">
                            <div class="simplebar-height-auto-observer-wrapper">
                                <div class="simplebar-height-auto-observer"></div>
                            </div>
                            <div class="simplebar-mask">
                                <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                    <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                        <div class="simplebar-content listComment" data-id="${notification.id}" style="padding: 0px 16px;">
                                            <c:forEach items="${notification.comments}" var="comment">
                                                <div class="d-flex mb-2 commentParent" data-id="${comment.id}">
                                                    <div class="flex-shrink-0">
                                                        <img src="${comment.avatarUser}" alt="Avatar" class="avatar-xs rounded-circle">
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <h5 class="fs-13">${comment.fullnameUser} <small class="text-muted ms-2">${comment.createdDate}</small></h5>
                                                        <p class="text-muted comment-content" data-id="${comment.id}">${comment.content}</p>
                                                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                                            <a href="javascript: void(0);" class="badge text-muted bg-light replyCommentBtn"><i class="mdi mdi-reply"></i> Reply</a>
                                                        </c:if>
                                                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER) || comment.userId.equals(userId)}">
                                                            <a href="javascript: void(0);" class="badge text-muted bg-light editCommentBtn"><i class="mdi mdi-pencil"></i> Edit</a>
                                                            <a href="javascript: void(0);" class="badge text-muted bg-light deleteCommentBtn"><i class="mdi mdi-delete"></i> Delete</a>
                                                        </c:if>
                                                        <div id="commentChildList-${comment.id}" class="mt-2">
                                                            <c:if test="${not empty comment.childComments}">
                                                                <c:forEach items="${comment.childComments}" var="childComment">
                                                                    <div class="d-flex mb-2" data-id="${childComment.id}">
                                                                        <div class="flex-shrink-0">
                                                                            <img src="${childComment.avatarUser}" alt="avatar" class="avatar-xs rounded-circle">
                                                                        </div>
                                                                        <div  class="flex-grow-1 ms-3">
                                                                            <h5 class="fs-13">${childComment.fullnameUser} <small class="text-muted ms-2">${childComment.createdDate}</small></h5>
                                                                            <p class="text-muted comment-content" data-id="${childComment.id}">${childComment.content}</p>
                                                                            <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER) || comment.userId.equals(userId)}">
                                                                                <a href="javascript: void(0);" class="badge text-muted bg-light editCommentBtn"><i class="mdi mdi-pencil"></i> Edit</a>
                                                                                <a href="javascript: void(0);" class="badge text-muted bg-light deleteCommentBtn"><i class="mdi mdi-delete"></i> Delete</a>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="simplebar-placeholder" style="width: 0px; height: 300px">

                            </div>
                        </div>
                        <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                            <div class="simplebar-scrollbar" style="width: 0px; display: none;">

                            </div>
                        </div>
                        <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                            <div class="simplebar-scrollbar" style="height: 150px; transform: translate3d(0px, 0px, 0px); display: block;">

                            </div>
                        </div>
                    </div>
                    <div class="mt-2">
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="newCommentContent" class="form-label text-body">Leave a Comments</label>
                                <textarea class="form-control bg-light border-light" id="newCommentContent" rows="3" placeholder="Enter your comment..."></textarea>
                            </div>
                            <div class="col-12 alertComment">

                            </div>
                            <div class="col-12 text-end">
                                <button class="btn btn-sm btn-success" id="newCommentBtn">Post Comments</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end card body -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this comment?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModalFile" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalFile" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalFileLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this file?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteFileButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="deleteNotification" tabindex="-1" style="display: none;" aria-hidden="true">
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
                            Are you Sure You want to Remove this Notification?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteNotificationButton">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="deleteSuccessNotification" data-bs-backdrop="static" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Inform</h4>
                        <p class="text-muted mx-4 mb-0">
                            This notification has been deleted.
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light backToList" data-bs-dismiss="modal">Back To List</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="deleteCommentModal" tabindex="-1" style="display: none;" aria-hidden="true">
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
                            Are you Sure You want to Remove this Comment?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteCommentBtn">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade zoomIn" id="editCommentModal" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Comment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="message-text" class="col-form-label">Content:</label>
                    <textarea class="form-control" id="editContentComment" rows="4"></textarea>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-primary " id="editCommentBtn">Update</button>
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

<div id="formEditNotification" data-bs-keyboard="false" data-bs-backdrop="static" class="modal fade zoomIn bs-example-modal-xl" tabindex="-1" aria-labelledby="myExtraLargeModalLabel" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Edit Notification Form</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- start page title -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label" for="titleEdit">Notification Title</label>
                                    <input type="text" class="form-control" id="titleEdit" placeholder="Input Title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Notification Content</label>
                                    <div class="snow-editor" id="contentEdit">

                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="pt-3 border-top border-top-dashed mt-4">
                                        <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                                        <div class="row g-3 showFilesUploaded">

                                        </div>
                                        <!-- end row -->
                                    </div>
                                </div>
                            </div>
                            <!-- end card body -->
                        </div>
                        <!-- end card -->

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
                                        <td class="text-center col-6">${listTypeFile}</td>
                                        <td class="text-center col-3">${maxFileSize} MB</td>
                                        <td class="text-center col-3">${uploadFileLimit}</td>
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
                                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
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
                <a href="javascript:void(0);" class="btn btn-link link-success fw-medium" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</a>
                <button type="button" class="btn btn-primary editBtn">Update</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<div class="modal fade zoomIn" id="deleteFileModal" tabindex="-1" style="display: none;" aria-hidden="true">
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

<!-- QR Code Modal -->
<div id="qrCodeModal" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">QR Code</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center p-2">
                <!-- Container for QR Code -->
                <div id="qrCodeContainer"></div>
            </div>
            <div class="modal-footer">
                <!-- Button to Download QR Code -->
                <button type="button" class="btn btn-success" id="downloadBtn">Download</button>

                <!-- Button to Copy QR Code Content -->
                <button type="button" class="btn btn-info copy-btn" id="copyBtn">Copy</button>

                <!-- Button to Close Modal -->
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script src="/assets/libs/simplebar/simplebar.min.js"></script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<script src="/assets/custom/js/notification/notification.js"></script>
<script>
    saveIdToLocal("${notification.id}","notifications")
    function refreshPage() {
        location.reload();
    }

    function generateClientID() {
        const timestamp = new Date().getTime();
        const random = Math.floor(Math.random() * 1000);
        return 'client-' + timestamp + '-' + random
    }

    const clientID = generateClientID();
    var stompClient = Stomp.over(new SockJS("/websocket"));

    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/notification/deleteNotification", function (notification) {
            let id = notification.body;
            let notiCheck = 'div#viewNotification[data-id="'+id+'"]'
            let notificationElement = $(notiCheck)
            if(notificationElement.length>0){
                $("#deleteSuccessNotification").modal("show");
                setTimeout(backToList, 5000);
            }
        })
        stompClient.subscribe("/notification/comments", function (comment) {
            var data = JSON.parse(comment.body);
            if($('.listComment[data-id="' + data.notificationId + '"]').length <= 0){
                return false
            }else{
                if (data.id != null) {
                    var buttonHtml = ""
                    if (userCurrent.id == data.userId || ${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                        buttonHtml = '<a href="javascript: void(0);" class="badge text-muted bg-light editCommentBtn">'+
                            '<i class="mdi mdi-pencil"></i> Edit </a>' +
                            '      <a href="javascript: void(0);" class="badge text-muted bg-light deleteCommentBtn">'+
                            '<i class="mdi mdi-delete"></i> Delete </a>'
                    }
                    var buttonReply=""
                    if (${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                        buttonReply =        '<a href="javascript: void(0);" class="badge text-muted bg-light replyCommentBtn">'+
                            '<i class="mdi mdi-reply"></i> Reply </a>'
                    }
                    var html = ' <div class="d-flex mb-2 commentParent" data-id="'+data.id+'">'+
                        '<div class="flex-shrink-0">'+
                        '<img src="'+data.avatarUser+'" alt="Avatar" class="avatar-xs rounded-circle">'+
                        '</div>'+
                        '<div class="flex-grow-1 ms-3">'+
                        '<h5 class="fs-13">'+data.fullnameUser+'<small class="text-muted ms-2">'+data.createdDate+'</small></h5>'+
                        '<p class="text-muted comment-content" data-id="'+data.id+'">'+data.content+'</p>'+
                        buttonReply+
                        buttonHtml+
                        '<div id="commentChildList-'+data.id+'" class="mt-2">'+
                        '</div>'+
                        '</div>'+
                        '</div>'
                    if ($('.listComment div.commentParent').length > 0 ) {
                        $("div.listComment div.commentParent:first").before(html);
                    } else{
                        $("div.listComment").html(html);
                    }
                    if (data.clientId == clientID) {
                        $("textarea#newCommentContent").prop("disabled", false)
                        $("#newCommentBtn").removeClass("d-none")
                        BtnLoadRemove()
                        popupSuccess("Comment posted successfully")
                        $("textarea#newCommentContent").val("")
                    }
                }else if(data.clientId == clientID){
                    refreshPage()
                }
            }
        });
        stompClient.subscribe("/notification/editcomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                var $pElement = $('div.simplebar-wrapper p.comment-content[data-id="'+ data.id +'"]')
                $pElement.text(data.content)
                $("#editCommentModal").modal("hide")
                if (data.clientId == clientID) {
                    $("#editCommentBtn").removeClass("d-none")
                    BtnLoadRemove()
                    popupSuccess("Edit Comment Successfully")
                }
            }else if(data.clientId == clientID){
                refreshPage()
            }
        });
        stompClient.subscribe("/notification/deletecomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                $('div.simplebar-wrapper div[data-id="' + data.id + '"]').remove()
                if (data.clientId == clientID) {
                    popupSuccess("Delete Comment Successfully")
                    $("#deleteCommentModal").modal("hide")
                    BtnLoadRemove()
                    $("#deleteCommentBtn").removeClass("d-none")
                }
            }else {
                refreshPage()
            }
        });
        stompClient.subscribe("/notification/replycomments", function (comment) {
            var data = JSON.parse(comment.body);
            if($('div.commentParent[data-id="' + data.parentId + '"]').length <= 0){
                return false
            }else{
                if (data.id != null) {
                    var buttonHtml = ""
                    if (userCurrent.id == data.userId || ${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                        buttonHtml = '<a href="javascript: void(0);" class="badge text-muted bg-light editCommentBtn">'+
                            '<i class="mdi mdi-pencil"></i> Edit </a>' +
                            '      <a href="javascript: void(0);" class="badge text-muted bg-light deleteCommentBtn">'+
                            '<i class="mdi mdi-delete"></i> Delete </a>'
                    }
                    var html = ' <div class="d-flex mb-2" data-id="'+data.id+'">'+
                        '<div class="flex-shrink-0">'+
                        '<img src="'+data.avatarUser+'" alt="Avatar" class="avatar-xs rounded-circle">'+
                        '</div>'+
                        '<div class="flex-grow-1 ms-3">'+
                        '<h5 class="fs-13">'+data.fullnameUser+'<small class="text-muted ms-2">'+data.createdDate+'</small></h5>'+
                        '<p class="text-muted comment-content" data-id="'+data.id+'">'+data.content+'</p>'+
                        buttonHtml+
                        '</div>'+
                        '</div>'

                    let $elementReply = "div#commentChildList-" + data.parentId
                    let $elementReplyHasContainer = "div#commentChildList-" + data.parentId + " .containerReply"
                    if($($elementReplyHasContainer).children().length > 0){
                        $($elementReplyHasContainer).after(html)
                    }else if($($elementReply).children().length > 0){
                        $($elementReply).children().first().before(html)
                    }else{
                        $($elementReply).html(html)
                    }

                    if (data.clientId == clientID) {
                        popupSuccess("Reply posted successfully")
                        $(".containerReply").remove()
                    }
                }else if(data.clientId == clientID){
                    refreshPage()
                }
            }
        });
    });

    function sendComment(data) {
        stompClient.send("/app/comment", {
            clientID: clientID
        }, data)
    }

    function editComment(data) {
        stompClient.send("/app/editcomment", {
            clientID: clientID
        }, data);
    }

    function deleteComment(data) {
        stompClient.send("/app/deletecomment", {
            clientID: clientID
        }, data);
    }

    function replyComment(data) {
        stompClient.send("/app/replycomment", {
            clientID: clientID
        }, data);
    }
</script>
<script>
    const INVALID_FILES_LIMIT=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> Maximum Files is ${uploadFileLimit}'+
        '</div>'

    const INVALID_FILES_TYPE=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> File type allowed: ${listTypeFile}'+
        '</div>'

    const INVALID_FILES_SIZE=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> Maximum Size Files is ${maxFileSize}'+
        '</div>'

    let listTypeFileArr = "${listTypeFile}".split(",")
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index)=>{
        listTypeFile += "." + item
        if(index<(listTypeFileArr.length-1)){
            listTypeFile += ","
        }
    })
    let maxFileSize = "${maxFileSize}"
    let uploadFileLimit = "${uploadFileLimit}"

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
        maxFiles: parseInt(uploadFileLimit) ,
        uploadMultiple:true,
        autoProcessQueue: false,
    });

    dropzoneEdit.on("addedfile", function (file) {
        removeAlert();
        let files = dropzoneEdit.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if(!checkLimitFile(files.length, parseInt(dropzoneEdit.options.maxFiles))){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_LIMIT)
            return
        }
        if(!checkTypeFile(fileExtension, listTypeFileArr)){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_TYPE)
            return
        }
        if(!checkLimitSize(fileSize,convertMbToB(maxFileSize))){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_SIZE)
            return
        }
    });

    var quillView = new Quill("#contentView",{
        theme: 'bubble', // Specify theme in configuration
        readOnly: true,  // Set the editor to read-only mode
    });

    var quillEdit = new Quill("#contentEdit", snowEditorData);

    document.addEventListener("DOMContentLoaded", function () {
        let checkDeleted = $(".notificationDetail button.notificationDeleted")
        if(checkDeleted.length>0) {
            $(".notificationDetail button").each(function (index,item){
                if(!$(item).hasClass("backToList")){
                    $(item).prop("disabled", true)
                    $("textarea").prop("disabled", true)
                }
            })
            $(".notificationDetail .simplebar-wrapper a").addClass("d-none")
        }
        $(document).on("click","button#deleteFileBtn",function (){
            let fileName = $("#deleteFileModal").attr("data-name")
            $('#formEditNotification div.showFilesUploaded > div[data-name="' + fileName + '"]').remove();
            $("#deleteFileModal").modal("hide")
            dropzoneEdit.options.maxFiles = dropzoneEdit.options.maxFiles + 1;
        })

        $(document).on("click","button.editBtn", function(){
            removeAlert()
            $(this).addClass("d-none")
            $(this).before(BtnPrimaryLoad)
            let notificationId = $("#formEditNotification").attr("data-id")
            let title = $("#titleEdit").val()
            let contentCheck = $("div#formEditNotification .ql-editor").html().toString()
            let content = JSON.stringify(quillEdit.getContents())
            if (title.trim() === "") {
                $("input#titleEdit").parent().after(INVALID_FILLED)
                return false;
            }
            if (contentCheck.trim() == "<p><br></p>" || contentCheck.trim() == "") {
                $("div#contentEdit").parent().after(INVALID_FILLED)
                return false;
            }
            var oldFile = []
            $("#formEditNotification div.showFilesUploaded > div").each(function () {
                oldFile.push($(this).attr("data-name"));
            });
            var formData = new FormData();
            formData.append("title", title);
            formData.append("content", content);
            formData.append("oldFile", oldFile);
            if(dropzoneEdit.files.length>0) {
                for (let i = 0; i < dropzoneEdit.files.length; i++) {
                    let file = dropzoneEdit.files[i]
                    if(file.accepted){
                        formData.append("files", file);
                    }
                }
            }
            callAjaxByDataFormWithDataForm("${apiURL}${pathMain}update/" + notificationId,"POST", formData ,function (rs){
                console.log(rs)
                if(rs){
                    $("h5.titleView strong").text(rs.title)
                    let contentParse = JSON.parse(rs.content)
                    quillView.setContents(contentParse)
                    if(rs.files && rs.files.length>0){
                        loadFilesName(rs.files);
                    }
                    INFORM_SUCCESS("Notification updated successfully.")
                    $("#formEditNotification").modal("hide")
                }
                BtnLoadRemove()
                $("button.editBtn").removeClass("d-none")
            },function (error){
                console.log(error)
            })

        })

        $(document).on("click","button.editNotification",function (){
            Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
            $(this).addClass("d-none")
            $(this).before(loadingBtnSm("success"))
            let notificationId = $(this).parent().parent().attr("data-id")
            let apiUrlNotification = baseUrlNotification
            if(notificationId){
                callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null,
                    function (rs) {
                        $("#formEditNotification").attr("data-id", rs.id)
                        $("#titleEdit").val(rs.title)
                        let contentParse = JSON.parse(rs.content)
                        quillEdit.setContents(contentParse)
                        let urlFiles = rs.files ? rs.files : []
                        let fileLength = rs.files ? rs.files.length : 0
                        dropzoneEdit.options.maxFiles = parseInt(uploadFileLimit) - fileLength;
                        let html=""
                        if(fileLength>0){
                            urlFiles.forEach(function (url) {
                                $.ajax({
                                    type: "HEAD",
                                    url: url,
                                    success: function (data, status, xhr) {
                                        var contentLength = xhr.getResponseHeader('Content-Length');
                                        var fileName = url.substring(url.lastIndexOf("/") + 1);
                                        html+= showFileUploaded(fileName, contentLength, url, "edit")
                                        $("#formEditNotification .showFilesUploaded").html(html)
                                        $("#formEditNotification").modal("show")
                                    }
                                });
                            });
                        }else{
                            $("#formEditNotification").modal("show")
                        }
                        BtnLoadRemove()
                        $("button.editNotification").removeClass("d-none")
                    },
                    function (error){
                        console.log(error)
                    }
                )
            }
        })

        $(document).on("click","button.downFileBtn",function (){
            let dataUrl = $(this).children().attr("data-url")
            downloadFiles(dataUrl)
        })

        let fileNameArr = []
        function loadFilesName(fileNameArr){
            let html =""
            handleFiles(fileNameArr, function handleEachFunc (fileName, fileSize, url) {
                html += showFileUploaded(fileName, fileSize, url, "view")
                $("#viewNotification .showFilesUploaded").html(html)
            })
        }

        <c:forEach items="${notification.files}" var="value" varStatus="loop">
        fileNameArr.push('${value}');
        <c:if test="${loop.index + 1 == fn:length(notification.files)}">
        loadFilesName(fileNameArr);
        </c:if>
        </c:forEach>
        function loadContent(content){
            quillView.setContents(content)
        }
        loadContent(${notification.content})

        $(document).on("click", ".listFilesEdit button", function (e) {
            $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
        });
        $(document).on("click", "#deleteFileButton", function (e) {
            $('.listFilesEdit button[data-name="' + $(this).attr("data-name") + '"]').parent().remove()
            $("#deleteConfirmationModalFile").modal("hide");
        });

        $(document).on("click", "#deleteNotificationButton", function (e) {
            $(this).addClass("d-none")
            $(this).before(loadingBtnSm("danger"))
            var notificationId = $("#deleteNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;
            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
                BtnLoadRemove()
                $("#deleteNotificationButton").removeClass("d-none")
                $("#deleteNotification").modal("hide");
            });
        });

        $(document).on("click", "#editButtonNotification", function () {
            $(this).prop("disabled", true);
            var notificationId = $("table#tableNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;

            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null, function (rs) {
                var data = rs;
                var fileList = data.files;
                var fileListHTML = '<ul class="list-group">';
                if (fileList != null) {
                    for (var i = 0; i < fileList.length; i++) {
                        var fileName = fileList[i].trim();
                        fileListHTML += '<li class="list-group-item listFilesEdit" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<a href="' + fileName + '" class="btn btn-link" download>' +
                            fileName.split("-")[1] +
                            '</a>' +
                            '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModalFile" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<span>×</span>' +
                            '</button>' +
                            '</li>';
                    }
                }
                fileListHTML += '<label for="file">Attached Files:</label>'
                    + '<input type="file" id="editNotificationFile" name="files" class="form-control-file" multiple>'
                    + '</ul>'
                    + '<table class="table table-bordered text-center">'
                    + '<thead>'
                    + '<tr>'
                    + ' <th class="text-center col-6">File Format</th>'
                    + ' <th class="text-center col-3">Maximum Size</th>'
                    + ' <th class="text-center col-3">Maximum Files</th>'
                    + '</tr>'
                    + '</thead>'
                    + '<tbody>'
                    + '<tr>'
                    + '<td class="text-center col-6">${listTypeFile}</td>'
                    + '<td class="text-center col-3">${maxFileSize} MB</td>'
                    + '<td class="text-center col-3">${uploadFileLimit}</td>'
                    + '</tr>'
                    + '</tbody>'
                    + ' </table>';
                var xhtml = '<div id="editNotificationForm">'
                    + '<div class="form-group">'
                    + '<label for="title">Title:</label>'
                    + '<input type="text" id="editNotificationTitle" name="title" value="' + data.title + '" class="form-control">'
                    + '</div>'
                    + '<div class="form-group">'
                    + '<label for="content">Content:</label>'
                    + '<textarea id="editNotificationContent" name="content" class="form-control">' + data.content + '</textarea>'
                    + '</div>'
                    + '<div class="form-group">'
                    + fileListHTML
                    + '</div>'
                    + '</div>';
                $("#popupFormEditNotification div.modal-body").html(xhtml)
                $("#popupFormEditNotification").modal("show");

                $('div.custom-spinner').parent().remove()
                $('button#editButtonNotification').prop("disabled", false);
            });
        });

        $(document).on("click", "#newReplyBtn", function (e) {
            removeAlert();
            var parentId = $(this).data("id");
            var content = $('textarea#newReplyContent').val();
            var notificationId = $("div#viewNotification").attr("data-id")
            if(checkEmptyString(content)){
                $(".alertReply").html(INVALID_FILLED)
                return false;
            }
            $(this).addClass("d-none")
            $(this).before(loadingBtnSm("success"))
            $("textarea#newReplyContent").prop("disabled", true)
            var data = {
                content: content,
                notificationId: notificationId,
                parentId: parentId,
                userId: userCurrent.id
                // Add any other data you want to send to the server
            };
            var jsonData = JSON.stringify(data);
            replyComment(jsonData)
        });
        $(document).on("click", "#newCommentBtn", function (e) {
            removeAlert();
            var notificationId = $("div#viewNotification").attr("data-id")
            var content = $("textarea#newCommentContent").val()
            if(checkEmptyString(content)){
                $(".alertComment").html(INVALID_FILLED)
                return false;
            }
            $("textarea#newCommentContent").prop("disabled", true)
            $(this).addClass("d-none")
            $(this).before(loadingBtnSm("success"))
            var data = {
                content: content,
                notificationId: notificationId,
                userId: userCurrent.id
            };
            var jsonData = JSON.stringify(data);
            sendComment(jsonData)
        });

        $(document).on("click", "#commentList button.btn-danger", function (e) {
            var commentId = $(this).data("id");
            $("#deleteConfirmationModal").attr("data-id", commentId)
        });

        $(document).on("click","a.deleteCommentBtn", function (){
            let id = $(this).parent().parent().attr("data-id")
            $("#deleteCommentModal").attr("data-id", id)
            $("#deleteCommentModal").modal("show")
        })

        $(document).on("click","#deleteCommentBtn", function (){
            var id = $("#deleteCommentModal").attr("data-id")
            var data = {
                id: id,
                userId: userCurrent.id
            };
            var jsonData = JSON.stringify(data);
            deleteComment(jsonData)
            $(this).addClass("d-none")
            $(this).before(BtnDangerLoad)
        })

        $(document).on("click","a.editCommentBtn", function (){
            removeAlert()
            let id = $(this).parent().parent().attr("data-id")
            let content = $('div.simplebar-content-wrapper p.comment-content[data-id="'+ id +'"]').text()
            $("#editCommentModal").attr("data-id", id)
            $("#editContentComment").val(content)
            $("#editCommentModal").modal("show")
        })

        $(document).on("click","a.replyCommentBtn", function (){
            $(".containerReply").remove()
            let id = $(this).parent().parent().attr("data-id")
            let html = '<div class="row g-3 containerReply">'+
                '<div class="col-12">'+
                '<label for="newReplyContent" class="form-label text-body">Leave a Reply</label>'+
                '<textarea class="form-control bg-light border-light" id="newReplyContent" rows="3" placeholder="Enter your reply..."></textarea>'+
                '</div>'+
                '<div class="alertReply">'+
                '</div>'+
                '<div class="col-12 text-end">'+
                '<button class="btn btn-sm btn-success" data-id="'+id+'" id="newReplyBtn">Post Reply</button>'+
                '</div>'+
                '</div>'
            let $elementReply = "div#commentChildList-" + id
            if($($elementReply).children().length > 0){
                $($elementReply).children().first().before(html)
            }else{
                $($elementReply).html(html)
            }
        })

        $(document).on("click","#editCommentBtn", function () {
            removeAlert()
            var contentEdit = $("#editContentComment").val()
            if(checkEmptyString(contentEdit)){
                $("#editContentComment").parent().before(INVALID_FILLED)
                return false;
            }
            $(this).addClass("d-none")
            $(this).before(BtnPrimaryLoad)
            // Define the data you want to send (if needed)
            var id = $("#editCommentModal").attr("data-id")
            var data = {
                id: id,
                content: contentEdit,
                userId: userCurrent.id
            };
            // Convert the data to JSON
            var jsonData = JSON.stringify(data);
            editComment(jsonData);
        })
        $("#containerDetail").removeClass("d-none")
        $(".containerLoading").remove()
        $(document).on("click","button.notificationShare", function () {
            if($("#qrCodeImage").length >0){
                $("#qrCodeModal").modal("show")
                return
            }
            let currentUrl = window.location.href;
            let data = new FormData()
            data.append("content", currentUrl)
            fetch('/api/v1/qrcode',
                {
                    method: 'POST',
                    body: data
                })
                .then(response => response.arrayBuffer())
                .then(buffer => {
                    const byteArray = new Uint8Array(buffer);
                    const blob = new Blob([byteArray], { type: 'image/png' });
                    const url = URL.createObjectURL(blob);
                    const imgElement = document.createElement('img');
                    imgElement.id = 'qrCodeImage';
                    imgElement.src = url;
                    document.getElementById('qrCodeContainer').appendChild(imgElement);
                    $("#qrCodeModal").modal("show")
                })
                .catch(error => console.error('Error fetching QR Code:', error));
        })
        const copyImageBtn = document.getElementById('copyBtn');
        const downImageBtn = document.getElementById('downloadBtn');
        copyImageBtn.addEventListener('click', function () {
            let imgElement = document.getElementById('qrCodeImage');
            let imageUrl = imgElement.src;
            fetch(imageUrl)
                .then(response => response.blob())
                .then(blob => {
                    navigator.clipboard.write([
                        new ClipboardItem({
                            'image/png': blob
                        })
                    ]).then(() => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Image Copied!',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }).catch((error) => {
                        console.error('Unable to copy image to clipboard:', error);
                    });
                });
        });
        downImageBtn.addEventListener('click', function () {
            let imgElement = document.getElementById('qrCodeImage');
            let imageUrl = imgElement.src;

            let link = document.createElement('a');
            link.href = imageUrl;
            link.download = imageUrl;
            link.dispatchEvent(new MouseEvent('click'));
            console.log('Image downloaded:', imageUrl);
        });
    });
</script>
</body>
</html>
