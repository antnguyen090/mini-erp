<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Task detail</title>

    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />

    <!-- dropzone css -->
    <link rel="stylesheet" href="/assets/libs/dropzone/dropzone.css" type="text/css" />
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Task Details</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks</a></li>
                    <li class="breadcrumb-item active">Task Details</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-xxl-3">
        <div class="card mb-3">
            <div class="card-body">
                <div class="table-card">
                    <table class="table mb-0">
                        <tbody>
                        <tr>
                            <td class="fw-medium">Username</td>
                            <td class="task-username"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Task id</td>
                            <td class="task-id"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Task title</td>
                            <td class="task-title"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Status</td>
                            <td><span class="task-status"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Priority</td>
                            <td><span class="task-priority"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Progress</td>
                            <td><span class="task-progress"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Register date</td>
                            <td class="task-registered-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Started date</td>
                            <td class="task-started-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Due date</td>
                            <td class="task-due-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Closed date</td>
                            <td class="task-closed-date"></td>
                        </tr>
                        </tbody>
                    </table>
                    <!--end table-->
                </div>
            </div>
        </div>
        <!--end card-->
    </div>
    <!---end col-->
    <div class="col-xxl-9">
        <div class="card">
            <div class="card-body">
                <div class="text-muted">
                    <h6 class="mb-3 fw-semibold text-uppercase">Task content</h6>
                    <div class="task-content"></div>
                </div>
            </div>
        </div>
        <!--end card-->
        <div class="card">
            <div class="card-header">
                <div>
                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#home-1" role="tab">
<%--                                Comments (5)--%>
    Comments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#messages-1" role="tab">
<%--                                Attachments File (4)--%>
    Attachments File
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#profile-1" role="tab">
<%--                                Time Entries (9 hrs 13 min)--%>
    Time Entries
                            </a>
                        </li>
                    </ul>
                    <!--end nav-->
                </div>
            </div>
            <div class="card-body">
                <div class="tab-content">
                    <div class="tab-pane active" id="home-1" role="tabpanel">
                        <h5 class="card-title">Comments</h5>
                        <div data-simplebar class="px-3 mx-n3 mb-2" id="comment-list"></div>
                        <div class="post-comment">
                            <h5 class="card-title">Leave a Comments</h5>
                            <form class="form-control post-comment-form">
                                <div class="row g-3">
                                    <div class="col-lg-12">
                                        <div>
                                            <label class="form-label">Title</label>
                                            <input type="text" name="title" class="title-post-comment form-control" placeholder="Title"/>
                                            <small class="form-message"></small>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <label class="form-label">Content</label>
                                        <div class="content-post-comment snow-editor h-auto"></div>
                                        <small class="form-message"></small>
                                    </div>
                                    <div class="col-lg-12">
                                        <label class="form-label">Attach file</label>
                                        <div class="card-body attach-file-container">
                                            <div class="dropzone">
                                                <div class="fallback">
                                                    <input name="fileList" type="file" multiple="multiple">
                                                </div>
                                                <div class="dz-message needsclick">
                                                    <div class="mb-3">
                                                        <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                                    </div>
                                                    <h4>Drop files here or click to upload.</h4>
                                                </div>
                                            </div>
                                            <ul class="list-unstyled mb-0" id="dropzone-preview">
                                                <li class="mt-2" id="dropzone-preview-list">
                                                    <div class="border rounded">
                                                        <div class="d-flex p-2">
                                                            <div class="flex-shrink-0 me-3">
                                                                <div class="avatar-sm bg-light rounded">
                                                                    <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                        <i class="ri-file-upload-line"></i>
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
                                            <div class="message-error-file"></div>
                                        </div>
                                    </div>
                                    <div class="hstack gap-2 justify-content-start">
                                        <button type="submit" class="btn btn-success btn-load">
                                            <span class="d-flex align-items-center">
                                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                                <span class="flex-grow-1">Comment</span>
                                            </span>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="messages-1" role="tabpanel">
                        <div class="table-responsive table-card">
                            <table class="table table-borderless align-middle mb-0">
                                <thead class="table-light text-muted">
                                <tr>
                                    <th scope="col">File Name</th>
                                    <th scope="col">Type</th>
                                    <th scope="col">Size</th>
                                    <th scope="col">Upload Date</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-primary text-primary rounded fs-20">
                                                    <i class="ri-file-zip-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0)">App pages.zip</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Zip File</td>
                                    <td>2.22 MB</td>
                                    <td>21 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink1" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink1" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle text-muted"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle text-muted"></i>Download</a></li>
                                                <li class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle text-muted"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-danger text-danger rounded fs-20">
                                                    <i class="ri-file-pdf-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Velzon admin.ppt</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>PPT File</td>
                                    <td>2.24 MB</td>
                                    <td>25 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink2" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink2" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle text-muted"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle text-muted"></i>Download</a></li>
                                                <li class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle text-muted"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-info text-info rounded fs-20">
                                                    <i class="ri-folder-line"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Images.zip</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>ZIP File</td>
                                    <td>1.02 MB</td>
                                    <td>28 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink3" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink3" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle"></i>Download</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-danger text-danger rounded fs-20">
                                                    <i class="ri-image-2-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Bg-pattern.png</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>PNG File</td>
                                    <td>879 KB</td>
                                    <td>02 Nov 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink4" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink4" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle"></i>Download</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!--end table-->
                        </div>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="profile-1" role="tabpanel">
                        <h6 class="card-title mb-4 pb-2">Time Entries</h6>
                        <div class="table-responsive table-card">
                            <table class="table align-middle mb-0">
                                <thead class="table-light text-muted">
                                <tr>
                                    <th scope="col">Member</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Duration</th>
                                    <th scope="col">Timer Idle</th>
                                    <th scope="col">Tasks Title</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-8.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Thomas Taylor</a>
                                            </div>
                                        </div>
                                    </th>
                                    <td>02 Jan, 2022</td>
                                    <td>3 hrs 12 min</td>
                                    <td>05 min</td>
                                    <td>Apps Pages</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Tonya Noble</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td>28 Dec, 2021</td>
                                    <td>1 hrs 35 min</td>
                                    <td>-</td>
                                    <td>Profile Page Design</td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Tonya Noble</a>
                                            </div>
                                        </div>
                                    </th>
                                    <td>27 Dec, 2021</td>
                                    <td>4 hrs 26 min</td>
                                    <td>03 min</td>
                                    <td>Ecommerce Dashboard</td>
                                </tr>
                                </tbody>
                            </table>
                            <!--end table-->
                        </div>
                    </div>
                    <!--edn tab-pane-->

                </div>
                <!--end tab-content-->
            </div>
        </div>
        <!--end card-->
    </div>
    <!--end col-->
</div>
<!--end row-->

<div class="modal fade" id="inviteMembersModal" tabindex="-1" aria-labelledby="inviteMembersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header p-3 ps-4 bg-soft-success">
                <h5 class="modal-title" id="inviteMembersModalLabel">Team Members</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="search-box mb-3">
                    <input type="text" class="form-control bg-light border-light" placeholder="Search here...">
                    <i class="ri-search-line search-icon"></i>
                </div>

                <div class="mb-4 d-flex align-items-center">
                    <div class="me-2">
                        <h5 class="mb-0 fs-13">Members :</h5>
                    </div>
                    <div class="avatar-group justify-content-center">
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Tonya Noble">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Thomas Taylor">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-8.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Nancy Martino">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                    </div>
                </div>
                <div class="mx-n4 px-4" data-simplebar style="max-height: 225px;">
                    <div class="vstack gap-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Nancy Martino</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <div class="avatar-title bg-soft-danger text-danger rounded-circle">
                                    HB
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Henry Baird</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-3.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Frank Hook</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-4.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Jennifer Carter</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <div class="avatar-title bg-soft-success text-success rounded-circle">
                                    AC
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Alexis Clarke</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-7.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Joseph Parker</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                    </div>
                    <!-- end list -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light w-xs" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success w-xs">Assigned</button>
            </div>
        </div>
        <!-- end modal-content -->
    </div>
    <!-- modal-dialog -->
</div>
<!-- end modal -->

<div class="modal fade flip" id="deleteCommentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a task comment ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task comment will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger btn-load" id="delete-comment" data-id="">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Yes, Delete It</span>
                            </span>
                        </button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<div class="modal fade flip" id="deleteFileCommentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a file ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger" id="delete-file-comment" data-name="">Yes, Delete It</button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<!-- ckeditor -->
<script src="/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>

<!-- dropzone min -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>

<script src="/assets/custom/js/task/task.js"></script>



<!-- https://cdnjs.com/libraries/sockjs-client -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<!-- https://cdnjs.com/libraries/stomp.js/ -->
<script  src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
    $(document).ready(function() {
        var idTask = ${id};
        var swal = showAlertLoading();
        callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {
            $('.task-username').text(rs.user.fullname);
            $('.task-id').text(rs.id);
            $('.task-title').text(rs.title);
            $('.task-status').replaceWith(`<span class="badge ` + getStatusColor(rs.statusTask.code) + `">` + rs.statusTask.code + `</span>`);
            $('.task-priority').replaceWith(`<span class="badge ` + getPriorityColor(rs.priority.code) + ` text-uppercase">` + rs.priority.code + `</span>`);
            $('.task-progress').replaceWith(rs.progress + '%' + getProgressE(rs.progress));
            $('.task-registered-date').text(rs.createdDate);
            $('.task-started-date').text(rs.startDate);
            $('.task-due-date').text(rs.dueDate);
            $('.task-closed-date').text(rs.closeDate);

            $('.task-content').html(getContentViewOfEditorSnow(rs.content));

            // LIST OF COMMENT
            var commentPromises = rs.comments.map(function (comment) {
                return createCommentForm(comment).then(function (commentHTML) {
                        $('#comment-list').append(commentHTML);
                    }).catch(function (error) {
                        console.error(error);
                });
            });
            Promise.all(commentPromises).then(function () {
                    swal.close();
                }).catch(function (error) {
                    console.error(error);
            });

            // Post a comment
            activeEditor('.post-comment-form');
            var dropzone = '';
            callAjaxByJsonWithData('/api/v1/settings/code?code='+ S_TASK_COMMENT, 'GET', null, function (setting) {
                dropzone = activeFile('.post-comment-form', setting);
                Validator({
                    form:'.post-comment-form',
                    errorSelector: '.form-message',
                    rules:[
                        Validator.isRequired('.post-comment-form .title-post-comment'),
                        Validator.isRequired('.post-comment-form .content-post-comment')
                    ],
                    onSubmit: function (formData) {
                        formData.append('taskId', idTask);
                        formData.append('content', $('.post-comment-form .content-post-comment').html());
                        formData.append('userId', userCurrent.id);
                        dropzone.files.forEach((file) => {
                            formData.append('fileList', file);
                        });

                        $('.post-comment-form .spinner-border').removeClass('d-none');
                        callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {
                            $('.post-comment-form .spinner-border').addClass('d-none');
                            resetFormPostComment();
                            dropzone = activeFile('.post-comment-form', setting);
                        });
                    }
                });
            });
        });
    });

    $(document).on('click', '.remove-comment-btn', function (e) {
        var id = $(this).data('id');
        $('#delete-comment').attr('data-id', id);
    });

    $(document).on('click', '#delete-comment', function (e) {
        var id = $(this).attr('data-id');
        $('#deleteCommentModal .spinner-border').removeClass('d-none');
        callAjaxByJsonWithData("/api/v1/comment-task/" + id, "DELETE", null, function (rs) {
            $('#deleteCommentModal .spinner-border').addClass('d-none');
            $('#deleteCommentModal').modal('hide');
        });
    });

    $(document).on('click', '.btn-reply', function (e){
        var id = $(this).data('id');
        var replyContainer = $(".form-reply[data-id='" + id + "']");
        replyContainer.html(showReplyCommentForm(id));

        activeEditor(".form-reply[data-id='" + id + "']");

        var dropzone = '';
            callAjaxByJsonWithData('/api/v1/settings/code?code='+ S_TASK_COMMENT, 'GET', null, function (setting) {
            dropzone = activeFile(".form-reply[data-id='" + id + "']", setting);
        });

        Validator({
            form:'.reply-comment-form[data-id="'+ id+ '"]',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('.reply-comment-form[data-id="'+ id+ '"] .title-reply'),
                Validator.isRequired('.reply-comment-form[data-id="'+ id+ '"] .content-reply')
            ],
            onSubmit: function (formData) {
                formData.append('taskId', ${id});
                formData.append('content', $('.reply-comment-form[data-id="'+ id+ '"] .content-reply').html());
                formData.append('userId', userCurrent.id);
                formData.append('parentId', id);
                dropzone.files.forEach((file) => {
                    formData.append('fileList', file);
                });

                $('.reply-comment-form[data-id="'+ id+ '"] .spinner-border').removeClass('d-none');
                callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {
                    replyContainer.html('');
                });
            }
        });
    });

    $(document).on('click', '.close-reply-form', function (e){
        var parentElement = $(this).closest(".reply-comment-form");
        if (parentElement.length > 0) parentElement.remove();
    });

    $(document).on('click', '.btn-edit', function (e){
        var id = $(this).data('id');
        var editContainer = $(".form-edit[data-id='" + id + "']");

        var swal = showAlertLoading();
        callAjaxByJsonWithData('/api/v1/comment-task/'+id, 'GET', null, function (rs) {

            showEditCommentForm(rs)
                .then(function (commentHTML) {
                    editContainer.html(commentHTML);
                    $(".form-edit[data-id='" + id + "']" + ' .content-edit').html(rs.content);
                    activeEditor(".form-edit[data-id='" + id + "']");

                    var dropzone = '';
                    callAjaxByJsonWithData('/api/v1/settings/code?code='+ S_TASK_COMMENT, 'GET', null, function (setting) {
                        dropzone = activeFile(".form-edit[data-id='" + id + "']", setting);
                        swal.close();
                    }, function (err) {
                        swal.close();
                    });

                    Validator({
                        form:'.edit-comment-form[data-id="'+ id+ '"]',
                        errorSelector: '.form-message',
                        rules:[
                            Validator.isRequired('.edit-comment-form[data-id="'+ id+ '"] .title-edit'),
                            Validator.isRequired('.edit-comment-form[data-id="'+ id+ '"] .content-edit')
                        ],
                        onSubmit: function (formData) {
                            formData.append('id', id);
                            formData.append('content', $('.edit-comment-form[data-id="'+ id+ '"] .content-edit').html());

                            var oldFiles = $('.edit-comment-form[data-id="'+ id+ '"]').find('a.file-name-item').map(function() {
                                return $(this).text();
                            }).get().join(',');
                            formData.append('remainFiles', oldFiles);

                            dropzone.files.forEach((file) => {
                                formData.append('newFiles', file);
                            });

                            $('.edit-comment-form[data-id="'+ id+ '"] .spinner-border').removeClass('d-none');
                            callAjaxByDataFormWithDataForm('/api/v1/comment-task/updation', 'POST', formData, function (rs){
                                $('.edit-comment-form[data-id="' + id + '"]').remove();
                            });
                        }
                    });
                }).catch(function (error) {
                console.error(error);
            });
        });
    });

    $(document).on('click', '.delete-file', function (e){
        var name = $(this).data('name');
        $('#delete-file-comment').attr('data-name', name);
    });

    $(document).on('click', '#delete-file-comment', function (e) {
        var name = $(this).attr('data-name');
        $(".file-container-item[data-name='" + name + "']").remove();
        $('#deleteFileCommentModal').modal('hide');
    });

    $(document).on('click', '.close-edit-form', function (e){
        var parentElement = $(this).closest(".edit-comment-form");
        if (parentElement.length > 0) parentElement.remove();
    });
</script>

<script>
    $(document).ready(function() {

        function connect() {
            var socket = new SockJS('/websocket');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, onConnected, onError);
        }

        connect();

        function onConnected() {
            stompClient.subscribe('/task-comment/create', function (payload) {
                var newComment = JSON.parse(payload.body);
                if(newComment!=null){
                    createCommentForm(newComment)
                        .then(function (commentHTML) {
                            $('#comment-list').append(commentHTML);
                        }).catch(function (error) {
                        console.error(error);
                    });
                }
            });
            stompClient.subscribe('/task-comment/delete', function (payload) {
                var id = JSON.parse(payload.body);
                if(id){
                    $(".comment-container[data-id='" + id + "']").remove();
                }
            });
            stompClient.subscribe('/task-comment/edit', function (payload) {
                var comment = JSON.parse(payload.body);
                var id = comment.id;
                if(comment!=null){
                    createCommentForm(comment)
                        .then(function (commentHTML) {
                            $('.comment-container[data-id="' + id + '"]').replaceWith(commentHTML);
                        }).catch(function (error) {
                        console.error(error);
                    });
                }
            });
            stompClient.subscribe('/task-comment/reply', function (payload) {
                var comment = JSON.parse(payload.body);
                var id = comment.parentId;
                var replyContainer = $(".form-reply[data-id='" + id + "']");
                if(comment!=null){
                    createCommentForm(comment)
                        .then(function (commentHTML) {
                            replyContainer.after(commentHTML);
                        }).catch(function (error) {
                        console.error(error);
                    });
                }
            });
        }

        function onError(error) {
            console.log('connect fail');
        }
    });
</script>
</body>
</html>
