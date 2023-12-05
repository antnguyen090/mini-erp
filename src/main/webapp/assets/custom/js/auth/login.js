$(document).ready(function () {
    Validator({
        form:'#loginForm',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#email'),
            Validator.isEmail('#email'),
            Validator.isRequired('#password')
        ],
        isFormHaveAction: true
    });
});