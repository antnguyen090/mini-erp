<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Book detail</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Time management</a></li>
                    <li class="breadcrumb-item active">Book detail</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>

<div class="row">
    <div class="col-lg-12">
        <div class="card" style="padding: 50px 50px 50px 0">
            <div class="row">
                <div class="col-md-3">
                    <div class="text-center">
                        <img src="${bookDetail.book.image}" class="img-fluid" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold">${bookDetail.book.title}</h4>
                        <p class="text-muted">Author: ${bookDetail.book.author}</p>
                        <a href="${bookDetail.book.link}" class="text-decoration-none">Link To Book</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <h3 class="mt-2 font-weight-bold">Your Feelings</h3>
                        <div class="col-md-12">
                            <div class="p-3">
                                <div class="text-center loading-feeling">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>
                                <form class="d-none feeling">
                                    <div class="form-group mb-2">
                                        <label for="quotes1">Feel 1:</label>
                                        <input type="text" class="form-control quote" id="quotes1">
                                    </div>
                                    <div class="form-group mb-2">
                                        <label for="quotes2">Feel 2:</label>
                                        <input type="text" class="form-control quote" id="quotes2">
                                    </div>
                                    <div class="form-group mb-2">
                                        <label for="quotes3">Feel 3:</label>
                                        <input type="text" class="form-control quote" id="quotes3">
                                    </div>
                                    <div class="form-group mb-2">
                                        <button type="button" class="btn btn-primary btn-load submit-btn" id="submit">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none"
                                                  style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Submit</span>
                                        </span>
                                        </button>
                                        <button type="button" class="btn btn-primary btn-load submit-btn d-none"
                                                id="update" data-id="">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none"
                                                  style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Update</span>
                                        </span>
                                        </button>
                                        <button type="button" class="btn btn-danger" data-toggle="modal"
                                                data-target="#deleteFeelingModal" id="delete-btn">Delete
                                        </button>
                                        <a href="/books" type="button" class="btn btn-secondary">Back</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                        <div class="col-md-12">
                            <div class="p-3" data-simplebar style="max-height: 350px">
                                <div class="text-center loading-feeling">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>
                                <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}">
                                    <div class="row border mb-2 d-none feeling">
                                        <div class="col-md-2 d-flex flex-column justify-content-center align-items-center border-end">
                                            <img src="${feeling.avatarUser}" class="img-fluid rounded-circle"
                                                 alt="User Avatar" width="70px">
                                            <p class="m-0">${feeling.fullnameUser}</p>
                                        </div>
                                        <div class="col-md-10 d-flex flex-column justify-content-center" style="min-height: 120px">
                                            <c:forEach var="quote" items="${feeling.quotes}">
                                                <c:if test='${!quote.equals("")}'>
                                                    <p class="mt-1 mb-1">- ${quote}</p>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end col-->
</div>
<!--end row-->

<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
    $(document).ready(function () {
        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id, 'GET', null, function (rs) {
            rs.quotes.forEach(function (quote, index) {
                $('#quotes' + (index + 1)).val(quote);
            });

            $('.feeling').removeClass('d-none');
            $('.loading-feeling').addClass('d-none');
            $('#update').removeClass('d-none');
            $('#update').attr('data-id', rs.id);
            $('#submit').addClass('d-none');
        }, function (rs) {
            $('.feeling').removeClass('d-none');
            $('.loading-feeling').addClass('d-none');
        });
    });

    $('#update').click(function () {
        var id = $(this).data('id');
        var quoteElements = document.querySelectorAll('form .quote');
        var valueArray = Array.from(quoteElements).map(e => e.value);
        var isCheckUpdate = valueArray.every(item => item == '');

        if (isCheckUpdate) {
            Swal.fire(
                {
                    title: "Don't let all your feel go empty",
                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
        } else {
            var data = {
                id: id,
                quote: valueArray.join('---')

            };

            showAlertLoading();
            callAjaxByJsonWithData('/api/v1/feeling-of-book', 'PUT', data, function () {
                sessionStorage.setItem('result', 'updateSuccess');
                location.reload();
            });
        }
    });

    $('#submit').click(function () {
        var bookId = '${bookDetail.book.id}';
        var quoteElements = document.querySelectorAll('form .quote');
        var valueArray = Array.from(quoteElements).map(e => e.value);
        var isCheckUpdate = valueArray.every(item => item == '');

        if (isCheckUpdate) {
            Swal.fire(
                {
                    title: 'You must write a Feel!',
                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
        } else {
            var data = {
                userId: userCurrent.id,
                quote: valueArray.join('---'),
                bookId: bookId
            };

            showAlertLoading();
            callAjaxByJsonWithData('/api/v1/feeling-of-book', 'POST', data, function () {
                sessionStorage.setItem('result', 'addSuccess');
                location.reload();
            });
        }
    })

    $('#delete-btn').click(function () {
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
                showAlertLoading();
                var bookId = '${bookDetail.book.id}';
                var userId = userCurrent.id;
                callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userId + "&bookId=" + bookId, "DELETE", null, function (rs) {
                    sessionStorage.setItem('result', 'delSuccess');
                    location.reload();
                });
            }
        });
    });
</script>

<%--Notification--%>
<script>
    $(document).ready(function () {
        var result = sessionStorage.getItem('result');
        var title;
        switch (result) {
            case 'addSuccess':
                title = 'Add Success!'
                break;
            case 'updateSuccess':
                title = 'Update Success!'
                break;
            case 'delSuccess':
                title = 'Delete Success!'
                break;
        }
        if (result) {
            Swal.fire(
                {
                    title: title,
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                    cancelButtonClass: 'btn btn-danger w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
            sessionStorage.clear();
        }
    });
</script>
</body>
</html>