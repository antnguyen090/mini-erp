<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Confirm mail</title>
</head>
<body>
<div class="col-md-8 col-lg-6 col-xl-5">
    <div class="card mt-4">
        <div class="card-body p-4">
            <div class="text-center mt-2">
                <h5 class="text-primary">Confirm mail</h5>
                <p class="text-muted">Welcome ERP-MINI !</p>
            </div>
            <div class="p-2 mt-4">
                <form id="confirmForm">
                    <c:if test="${param.codeInvalid!=null}">
                        <div class="alert alert-danger">
                            The code is invalid
                        </div>
                    </c:if>
                    <div class="mb-3">
                        <label for="code" class="form-label">Code <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="code" name="code" placeholder="Enter code">
                        <small class="form-message"></small>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-success btn-load w-100">
                            <span>
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span>Confirm</span>
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
<script src="/assets/custom/js/auth/confirm-mail.js"></script>
</body>
</html>