<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Settings</title>
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">File</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Setting system</a></li>
                    <li class="breadcrumb-item active">File</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>

<div class="row">
    <div class="col-12">
        <form id="setting-file-form">
            <div>
                <table id="datatable-setting-file" class="table">
                    <thead>
                    <tr>
                        <th>Component</th>
                        <th>Image type</th>
                        <th>File type</th>
                        <th>File limit</th>
                        <th>File size (Mb)</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="mb-1">
                <button id="update-button" type="button" class="btn btn-success btn-load">
                    <span class="d-flex align-items-center">
                        <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                        <span class="flex-grow-1">Update</span>
                    </span>
                </button>
                <span class="message-noti ml-10"></span>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function (){

        $('#datatable-setting-file').DataTable({
            ajax: {
                url: '/api/v1/settings',
                method: 'GET',
                dataSrc: ''
            },
            columns: [
                {
                    data: 'code',
                    render: function(data, type, row) {
                        return '<p data-code="' + row.code.code + '">' + data.name +'</p>';
                    }
                },
                {
                    data: 'imageType',
                    render: function(data, type, row) {
                        return '<input name="imageType" class="form-control" type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileType',
                    render: function(data, type, row) {
                        return '<input name="fileType" class="form-control" type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileLimit',
                    render: function(data, type, row) {
                        return '<input name="fileLimit" class="form-control" min="0" type="number" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileSize',
                    render: function(data, type, row) {
                        return '<input name="fileSize" class="form-control" min="0" type="number" value="' + data + '"/>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        var object = [];
        $('#update-button').on('click', function () {
            object = [];

            var isValidate = true;

            $('#datatable-setting-file tbody tr').each(function () {

                if (!isValidate) {
                    return false;
                }

                var code = $(this).find('p').data('code');
                var imageType = $(this).find('input[name="imageType"]').val();
                var fileType = $(this).find('input[name="fileType"]').val();
                var fileLimit = $(this).find('input[name="fileLimit"]').val();
                var fileSize = $(this).find('input[name="fileSize"]').val();

                if(isBlank(imageType) || isBlank(fileType) || isBlank(fileLimit) || isBlank(fileSize)){
                    isValidate = false;
                    $('.message-noti').text('All field must not empty');
                    $('.message-noti').css('color', 'red');
                    object = null;
                } else{
                    var obj = {
                        code: code,
                        imageType: imageType,
                        fileType: fileType,
                        fileLimit: fileLimit,
                        fileSize: fileSize
                    };
                    object.push(obj);
                }
            });

            if(isValidate){
                $('#setting-file-form .spinner-border').removeClass('d-none');
                callAjaxByJsonWithData('/api/v1/settings', 'PUT', object, function (rs) {
                    $('#setting-file-form .spinner-border').addClass('d-none');
                    alertSuccess('Update success');
                });
            }
        });
    });
</script>
</body>
</html>