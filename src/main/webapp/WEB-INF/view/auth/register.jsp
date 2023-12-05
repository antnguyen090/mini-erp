<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<div class="col-md-8 col-lg-6 col-xl-5">
    <div class="card mt-4">

        <div class="card-body p-4">
            <div class="text-center mt-2">
                <h5 class="text-primary">Register</h5>
                <p class="text-muted">Welcome ERP-MINI !</p>
            </div>
            <div class="p-2 mt-4">
                <form id="registerForm" class="needs-validation" novalidate>
                    <c:if test="${param.fail=='userIdExisted'}">
                        <div class="alert alert-danger">
                            User ID is existed in system
                        </div>
                    </c:if>
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Username <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Enter username" required>
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">User ID <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter User ID" required>
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password-input">Password <span class="text-danger">*</span></label>
                        <div class="position-relative auth-pass-inputgroup">
                            <input type="password" class="form-control pe-5 password-input" onpaste="return false" placeholder="Enter password" name="password" id="password-input" aria-describedby="passwordInput" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                            <small class="form-message"></small>
                            <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon" type="button" id="password-addon"><i class="ri-eye-fill align-middle"></i></button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password-confirm-input">Confirm password <span class="text-danger">*</span></label>
                        <div class="position-relative auth-pass-inputgroup">
                            <input type="password" class="form-control pe-5 password-input" onpaste="return false" placeholder="Enter password confirm" name="confirmPassword" id="password-confirm-input" aria-describedby="passwordConfirmInput" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                            <small class="form-message"></small>
                            <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon" type="button" id="password-confirm-addon"><i class="ri-eye-fill align-middle"></i></button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-success btn-load w-100">
                            <span>
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span>Register</span>
                            </span>
                        </button>
                    </div>
                </form>

            </div>
        </div>
        <!-- end card body -->
    </div>
    <!-- end card -->

    <div class="mt-4 text-center">
        <p class="mb-0">Already have an account ? <a href="/login" class="fw-semibold text-primary text-decoration-underline"> Login </a> </p>
    </div>

</div>
<script src="/assets/custom/js/auth/register.js"></script>
</body>
</html>