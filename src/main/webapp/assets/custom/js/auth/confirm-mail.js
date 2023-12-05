$(document).ready(function () {
    Validator({
        form:'#confirmForm',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#code'),
        ],
        onSubmit: function (formData) {
            $('#confirmForm .spinner-border').removeClass('d-none');
            callAjaxByDataFormWithDataForm("/api/v1/auth/register/confirm", "POST", formData, function (rs) {
                window.location.href = "/login?registerSuccess";
            }, function (err) {
                window.location.href = "/register/confirm-mail?codeInvalid";
            });
        }
    });
});