const baseUrlComment = "/api/v1/comment-notification";
const baseUrlNotification = "/api/v1/notifications";
const notFilled = '<span class="text-danger font-weight-bold font-italic small">This field is not filled</span>'
var snowEditorData = {};
snowEditorData.theme = 'snow'
snowEditorData.modules = {
    'toolbar': [[{ 'font': [] }, { 'size': [] }], ['bold', 'italic', 'underline', 'strike'],
        [{ 'color': [] }, { 'background': [] }], [{ 'script': 'super' }, { 'script': 'sub' }],
        [{ 'header': [false, 1, 2, 3, 4, 5, 6] }, 'blockquote', 'code-block'],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }, { 'indent': '-1' }, { 'indent': '+1' }],
        ['direction', { 'align': [] }], ['link', 'image', 'video'], ['clean']]
}

const INVALID_FILLED=' <div class="alert alert-danger" role="alert">'+
    '<strong> Invalid </strong> This field is not filled'+
    '</div>'

$(document).on("click","button.removeNotification", function (){
    let notificationId = $(this).parent().parent().attr("data-id")
    $("#deleteNotification").attr("data-id", notificationId)
    $("#deleteNotification").modal("show")
})

function loadingBtnSm(type){
    return `<button class="btn btn-sm btn-${type} btn-load">
    <span class="d-flex align-items-center">
        <span class="spinner-border flex-shrink-0" role="status">
        </span>
    </span>
    </button>`
}

function popupSuccess(text){
    var modal = `
                        <strong class="btn-success rounded-circle p-2">${text}.</strong> 
                        `
    $("#successComment div.modal-body p").html(modal)
    $("#successComment").modal("show");
}

$(document).on("click","button.deleteFileBtn",function (){
    let fileName = $(this).children().attr("data-name")
    $("#deleteFileModal").attr("data-name", fileName)
    $("#deleteFileModal").modal("show")
})

function backToList(){
    window.location.href = "/notifications"
}

$(document).on("click","button.backToList", function (){
    backToList()
})

$(document).on("click","#deleteNotificationBtn", function (){
    $(this).addClass("d-none")
    $(this).before(loadingBtnSm("danger"))
    let notificationId = $("#deleteNotification").attr("data-id")
    let apiUrlNotification = baseUrlNotification;
    if(notificationId){
        callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
            if(rs){
                loadDatabase();
                $("#deleteSuccessNotification").modal("show");
            }
            BtnLoadRemove()
            $("#deleteNotificationBtn").removeClass("d-none")
            $("#deleteNotification").modal("hide")
        });
    }
})

function checkEmptyString(text){
    if (text.trim() === "" || !text) {
        return true;
    }
}

function downloadFiles(url){
    var link = document.createElement('a');
    link.href = url;
    link.style.display = 'none';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function removeAlert(){
    $(".alert-danger").remove()
}
function checkLimitFile(count, limit){
    return count <= limit ? true : false
}

function checkTypeFile(type, listType){
    if(listType.includes(type)){
        return true
    }
}

function checkLimitSize(size, limit){
    if(parseInt(size)<= limit){
        return true
    }
}

function showAlertValidate(html){
    let xhtml =  '<li class="mt-2" id=""> '+
        html +
        '</li>'

    let check = $("#dropzone-preview-edit li").children().last()
    if(check.length>0){
        $("#dropzone-preview-edit li").children().last().after(xhtml)
    }else{
        $("#dropzone-preview-edit").html(xhtml)
    }

}

function showAlertValidateCreate(html){
    let xhtml =  '<li class="mt-2" id=""> '+
        html +
        '</li>'

    let check = $("#dropzone-preview li").children().last()
    if(check.length>0){
        $("#dropzone-preview li").children().last().after(xhtml)
    }else{
        $("#dropzone-preview").html(xhtml)
    }

}

$(function () {
    $('[data-toggle="tooltip"]').tooltip();
})

function INFORM_SUCCESS(text){
    var modal = `<strong class="btn-success rounded-circle p-2">${text}</strong>
                 `
    $("#successComment div.modal-body p").html(modal)
    $("#successComment").modal("show");
}

function convertMbToB(mb){
    return mb * 1024 * 1024;
}