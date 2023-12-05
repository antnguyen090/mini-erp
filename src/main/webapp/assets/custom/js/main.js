// CONSTANT
const U_DEVELOPER = 'DEVELOPER';
const U_OWNER = 'OWNER';
const U_MANAGER = 'MANAGER';

const SUCCESS_ALERT = 'SUCCESS_ALERT';
const DANGER_ALERT = 'DANGER_ALERT';

// loading
const BtnLoadRemove = () => {
    $('.btn-load').remove()
}
const BtnPrimaryLoad = '<button class="btn btn-outline-primary btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-border flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';
const BtnSuccessLoad = '<button type="button" class="btn btn-success btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-border flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';
const BtnDangerLoad = '<button type="button" class="btn btn-danger btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-grow flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';

const BtnSmPrimaryLoad = '<button class="btn btn-sm btn-outline-primary btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-border flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';
// FUNCTION

// call api
function callAjaxByDataFormWithDataForm(urlAPI, methodType, formData, callbackSuccess, callbackFail) {
    $.ajax({
        url: urlAPI,
        type: methodType,
        processData: false,
        contentType: false,
        data: formData,
        enctype: 'multipart/form-data',
        success: function(response) {
            if(callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if(callbackFail) callbackFail(xhr);
        }
    });
}
function callAjaxByJsonWithDataForm(urlAPI, methodType, formData, callbackSuccess, callbackFail) {
    var data = {};
    formData.forEach((value, key) => data[key] = value);

    $.ajax({
        url: urlAPI,
        type: methodType,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            if (callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if (callbackFail) callbackFail(xhr);
        }
    });
}
function callAjaxByJsonWithData(urlAPI, methodType, data, callbackSuccess, callbackFail) {
    $.ajax({
        url: urlAPI,
        type: methodType,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            if (callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if (callbackFail) callbackFail(xhr);
        }
    });
}

// file
function handleFiles(arrUrl, handleEachFunc) {
    arrUrl.forEach(function (url, index) {
        $.ajax({
            type: "HEAD",
            url: url,
            success: function (data, status, xhr) {
                var fileSize = xhr.getResponseHeader('Content-Length');
                var fileName = url.substring(url.lastIndexOf("/") + 1);
                if (handleEachFunc) handleEachFunc(fileName, fileSize, url);
            }
        });
    });
}
async function handleFilesAsync(arrUrl, handleEachFunc) {
    var promises = arrUrl.map(function (url) {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "HEAD",
                url: url,
                success: function (data, status, xhr) {
                    var fileSize = xhr.getResponseHeader('Content-Length');
                    var fileName = url.substring(url.lastIndexOf("/") + 1);
                    if (handleEachFunc) {
                        handleEachFunc(fileName, fileSize, url);
                    }
                    resolve();
                },
                error: function (xhr, status, error) {
                    reject(error);
                }
            });
        });
    });

    await Promise.all(promises);
}
function bytesToMB(bytes) {
    return parseInt((bytes / (1024 * 1024)).toFixed(0));
}
function convertMbToB(mb) {
    return mb * 1024 * 1024;
}
function bToKbShow(bytes) {
    return (bytes / 1024).toFixed(2);
}
function bytesToMBShow(bytes) {
    return (bytes / (1024 * 1024)).toFixed(2)
}
function checkLimitFile(count, limit) {
    return count <= limit ? true : false;
}
function checkTypeFile(type, listType) {
    if (listType.includes(type)) {
        return true;
    }
}
function checkLimitSize(size, limit) {
    if (parseInt(size) <= limit) {
        return true;
    }
}
function downloadFiles(url) {
    var link = document.createElement('a');
    link.download = "";
    link.href = url;
    link.style.display = 'none';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
function showFileUploaded(fileName, size, url, mode) {
    let html = ""

    if (mode === "edit") {
        html = "<button type='button' class='btn btn-icon text-muted btn-sm fs-18 deleteFileBtn'>"
            + " <i class='ri-delete-bin-fill' data-name='" + fileName + "'></i>"
            + " </button>"
    }

    return "<div class='col-xxl-4 col-lg-6' data-name='" + fileName + "'>"
        + " <div class='border rounded border-dashed p-2'>"
        + " <div class='d-flex align-items-center'>"
        + " <div class='flex-shrink-0 me-3'>"
        + " <div class='avatar-sm'>"
        + " <div class='avatar-title bg-light text-secondary rounded fs-24'>"
        + " <i class='ri-file-download-line'></i>"
        + " </div>"
        + " </div>"
        + " </div>"
        + " <div class='flex-grow-1 overflow-hidden'>"
        + " <h5 class='fs-13 mb-1'><a href='" + url + "' download data-toggle='tooltip' data-placement='bottom' title='" + fileName + "' class='text-body text-truncate d-block'>" + fileName + "</a></h5>"
        + " <div>" + bytesToMBShow(size) + " MB</div>"
        + " </div>"
        + " <div class='flex-shrink-0 ms-2'>"
        + " <div class='d-flex gap-1'>"
        + " <button type='button' class='btn btn-icon text-muted btn-sm fs-18 downFileBtn'>"
        + " <i class='ri-download-2-line' data-url='" + url + "'></i>"
        + " </button>"
        + html
        + " </div>"
        + " </div>"
        + " </div>"
        + " </div>"
        + "</div>";
}
function convertExtensionsList(extensions) {
    const extensionArray = extensions.split(',');
    const formattedExtensions = extensionArray.map(extension => `.${extension.trim()}`);
    return formattedExtensions.join(',');
}
function cutShortLink() {
    var fileElements = document.querySelectorAll('a.cut-file-name');

    fileElements.forEach(function (element) {
        var fileName = element.textContent;
        if (fileName.length > 0) {
            var indexOfHyphen = fileName.indexOf("-");
            if (indexOfHyphen !== -1) {
                var remainingPart = fileName.substring(indexOfHyphen + 1);
                var truncatedFileName;
                if (remainingPart.length > 14) {
                    truncatedFileName = remainingPart.substring(0, 10) + '...';
                } else {
                    truncatedFileName = remainingPart;
                }
            } else if (fileName.length > 14) truncatedFileName = fileName.substring(0, 14) + '...';
            else truncatedFileName = fileName;
            element.textContent = truncatedFileName;
        }
    });
}

// alert
function removeAlert() {
    $(".alert-danger").remove();
}
function showAlertValidate(html) {
    let xhtml = '<li class="mt-2" id=""> ' +
        html +
        '</li>'

    let check = $("#dropzone-preview-edit li").children().last()
    if (check.length > 0) {
        $("#dropzone-preview-edit li").children().last().after(xhtml)
    } else {
        $("#dropzone-preview-edit").html(xhtml)
    }
}
function showAlertValidateCreate(html) {
    let xhtml = '<li class="mt-2" id=""> ' +
        html +
        '</li>'

    let check = $("#dropzone-preview li").children().last()
    if (check.length > 0) {
        $("#dropzone-preview li").children().last().after(xhtml)
    } else {
        $("#dropzone-preview").html(xhtml)
    }

}
function alertSuccess(mess){
    Swal.fire(
        {
            title: 'Success!',
            text: mess,
            icon: 'success',
            confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
            buttonsStyling: false,
            showCloseButton: true
        }
    );
}
function showAlertLoading() {
    Swal.fire({
        title: 'Wait a minute...',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    return Swal;
}
function showAlert(type, mess){
    var className = '';
    if(type == SUCCESS_ALERT){
        className = '.alert.alert-success';
    } else if(type == DANGER_ALERT){
        className = '.alert.alert-danger';
    }
    $(className).text(mess);
    $(className).removeClass('d-none');
}


// money format
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
}

// date format
function formatDateValueToValueOfInputDate(s) {
    var dateArray = s.split('-');
    var date = new Date(Date.UTC(parseInt(dateArray[0]), parseInt(dateArray[1]) - 1, parseInt(dateArray[2])));
    return date.toISOString().slice(0, 10);
}

// string utils
function isBlank(a) {
    return a === '' || a === null;
}

// login utils
function isAdminOrUserLogin(idUser) {
    return userCurrent.role != U_DEVELOPER || userCurrent.id == idUser;
}
function isDeleveloper() {
    return userCurrent.role == U_DEVELOPER;
}
function isOwner() {
    return userCurrent.role == U_OWNER;
}

// error messsage
function getMessageLimitFile(limit) {
    return 'The number of files must be less than ' + limit;
}
function getMessageSizeFile(fileSize) {
    return 'The size of the file must be less than ' + fileSize + ' Mb';
}
function getMessageTypeFile(fileType) {
    return 'Files must be of the following types: ' + fileType;
}

// focus pointer to end element
function focusElement(element) {
    const range = document.createRange();
    const sel = window.getSelection();
    range.selectNodeContents(element[0]);
    range.collapse(false);
    sel.removeAllRanges();
    sel.addRange(range);
}

function subscribeUser(){
    navigator.serviceWorker.ready.then(function(registration) {
        try {
            if (!registration.pushManager) {
                alert('Push Unsupported');
                return;
            }
            registration.pushManager.getSubscription().then(function(subscription) {
                if (subscription) {
                    console.log('User is already subscribed:', subscription);
                } else {
                    registration.pushManager.subscribe({
                        userVisibleOnly: true,
                        applicationServerKey: urlBase64ToUint8Array("BH9v1XdUflNRCS0s7vExsPf7KPj5h2wXG3hW92S2jpXcFtbCDP4jP_nW4kFOOMV2AFfb_CTTHW8soN74VsT9u9k")
                    }).then(function(subscription) {
                        console.log('User is subscribed:', subscription);
                        localStorage.setItem("webPushEndpoint", subscription.endpoint);
                        const subscriptionJson = subscription.toJSON();
                        updateSubscriptionOnServer({
                            endpoint: subscriptionJson.endpoint,
                            p256dh: subscriptionJson.keys.p256dh,
                            auth: subscriptionJson.keys.auth
                        });
                    }).catch(function(error) {
                        console.log('Failed to subscribe', error.message);
                    });
                }
            });
        }catch (e){
            console.log(e)
            unsubscribeUser()
        }
    });
}

// Helper function
function saveIdToLocal(id, nameLocal) {
    // Get the value from Local Storage
    let storedIds = getIdFromLocal(nameLocal)
    // Check if the id already exists in the array
    if (!storedIds.includes(id)) {
        // If it doesn't exist, add the id to the array
        storedIds.push(id);

        // Save the updated array to Local Storage
        localStorage.setItem(nameLocal, JSON.stringify(storedIds));
        console.log(`Id ${id} has been added to Local Storage.`);
    } else {
        console.log(`Id ${id} already exists in Local Storage.`);
    }
}

function getIdFromLocal(nameLocal) {
    // Get the value from Local Storage
    let storedIds = JSON.parse(localStorage.getItem(nameLocal)) || [];
    return storedIds
}

function urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
        .replace(/\-/g, '+')
        .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
}

function updateSubscriptionOnServer(subscription) {
    fetch('/api/v1/subscribe/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(subscription)
    })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('Bad status code from server.');
            }
            return response.json();
        })
        .then(function(responseData) {
            console.log(responseData)
            if (responseData != 1) {
                throw new Error('Bad response from server.');
            }
            console.log('User subscription updated on server.');
        })
        .catch(function(error) {
            console.error('Error during subscription update on server:', error);
        });
}

function deleteEndPoint(endpoint){
    if(endpoint){
        fetch('/api/v1/subscribe', {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                endpoint: endpoint
            })
        }).then(function(response) {
            localStorage.removeItem("webPushEndpoint");
            console.log('Server is notified about the unsubscription.');
        }).catch(function(error) {
            console.error('Failed to notify the server about the unsubscription.', error);
        });
    }
}

function unsubscribeUser() {
    navigator.serviceWorker.ready.then(function(registration) {
        registration.pushManager.getSubscription().then(function(subscription) {
            if (subscription) {
                subscription.unsubscribe().then(function(successful) {
                    deleteEndPoint(subscription.endpoint)
                    console.log('User is unsubscribed.');
                }).catch(function(e) {
                    console.log('Failed to unsubscribe the user: ', e);
                });
            } else {
                console.log('User IS NOT subscribed.');
            }
        });
    });
}

function registerServiceWorker(){
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register("/service-worker.js")
            .then(function(registration) {
                console.log('Service Worker registered with scope:', registration.scope);
            }).catch(function(error) {
            console.log('Service Worker registration failed:', error);
        });
    }
}

function connectSocketNotification(){
    let stompClient = Stomp.over(new SockJS("/websocket"));
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/notification/createNotification", function (rs) {
            let data = JSON.parse(rs.body)
            if(data.idUser === userCurrent.id){
                return
            } else {
                Swal.fire({
                    html: '<div class="mt-3"><div class="avatar-lg mx-auto"><img src="/assets/images/icon-push.png" class="rounded-circle img-thumbnail" alt="thumbnail"></div><div class="mt-4 pt-2 fs-15"><h4 class="fs-18 fw-semibold"><span class="fw-semibold">Notifications</span></h4><p class="text-muted mb-0 fs-13">'+ data.title +'</p></div></div>',
                    showCancelButton: !1,
                    customClass: {
                        confirmButton: 'btn btn-primary mb-1'
                    },
                    confirmButtonText: 'Show Me <i class="ri-arrow-right-line ms-1 align-bottom"></i>',
                    buttonsStyling: !1,
                    showCloseButton: !0
                })
                    .then((result) => {
                        // Check if the "Show Me" button was clicked
                        if (result.isConfirmed) {
                            window.open('/notifications/'+data.id, '_blank');
                        }
                    });
            }
        })
        stompClient.subscribe("/notification/createEvent", function (rs) {
            let data = JSON.parse(rs.body)
            if(data.user.id == userCurrent.id){
                return
            } else {
                Swal.fire({
                    html: '<div class="mt-3"><div class="avatar-lg mx-auto"><img src="/assets/images/icon-event.png" class="rounded-circle img-thumbnail" alt="thumbnail"></div><div class="mt-4 pt-2 fs-15"><h4 class="fs-18 fw-semibold"><span class="fw-semibold">Events</span></h4><p class="text-muted mb-0 fs-13">'+ data.title +'</p></div></div>',
                    showCancelButton: !1,
                    customClass: {
                        confirmButton: 'btn btn-primary mb-1'
                    },
                    confirmButtonText: 'Show Me <i class="ri-arrow-right-line ms-1 align-bottom"></i>',
                    buttonsStyling: !1,
                    showCloseButton: !0
                })
                    .then((result) => {
                        // Check if the "Show Me" button was clicked
                        if (result.isConfirmed) {
                            window.open('/schedules/detail/'+ userCurrent.id, '_blank');
                        }
                    });
            }
        })

    })
}

registerServiceWorker()

// Check if notification permission has been granted
if( typeof userCurrent !== "undefined") {
    if (Notification.permission === 'granted') {
        // Permission has been granted, you can perform notification operations here
        subscribeUser()
    } else if (Notification.permission === 'default') {
        // Permission hasn't been granted, request notification permission from the user
        Notification.requestPermission().then(function(permission) {
            if (permission === 'granted') {
                // Permission has been granted, you can perform notification operations here
                subscribeUser()
            } else {
                // Permission denied, handle accordingly
                unsubscribeUser()
                let endPoint = localStorage.getItem("webPushEndpoint")
                deleteEndPoint(endPoint)
                console.log('Permission for notifications denied.');
                connectSocketNotification()
            }
        });
    } else {
        // Permission denied, handle accordingly
        unsubscribeUser()
        let endPoint = localStorage.getItem("webPushEndpoint")
        deleteEndPoint(endPoint)
        console.log('Permission for notifications denied.');
        connectSocketNotification()
    }
} else{
    unsubscribeUser()
    console.log('Must log in');
}

async function fetchNotificationsData(limit) {
    return new Promise((resolve, reject) => {
        callAjaxByJsonWithData(
            "/api/v1/notifications/latest/" + limit ,
            "GET",
            null,
            (rs) => {
                if (rs) {
                    resolve(rs);
                }
            },
            (error) => {
                console.log("Error");
                console.log(error);
                reject(error);
            }
        );
    });
}

async function fetchEventsData(limit) {
    return new Promise((resolve, reject) => {
        callAjaxByJsonWithData(
            "/api/v1/events/latest/" + limit ,
            "GET",
            null,
            (rs) => {
                if (rs) {
                    resolve(rs);
                }
            },
            (error) => {
                console.log("Error");
                console.log(error);
                reject(error);
            }
        );
    });
}

function stringToDateValid(string){
    const [datePart, timePart] = string.split(' ');
    const [day, month, year] = datePart.split('/');
    const [hour, minute, second] = timePart.split(':');
    const dateObject = new Date(year, month - 1, day, hour, minute, second);
    return dateObject
}

function countUnRead(){
    var count = $(".latestItem").filter(".active").length;
    $(".dangerCountLatest").text(count)
}

function handleLinkClick(id, process) {
    $(`.latestItem[data-id="${id}"]`).removeClass("active")
    saveIdToLocal(id, process)
    countUnRead()
    let url = ""
    if(process === "notifications"){
        url = "/notifications/" + id;
    }
    if(process === "events"){
        url = "/schedules/detail/" + userCurrent.id;
    }
    window.open(url, "_blank")
    return false;
}

function returnItemLatest(data,icon, process, active){
    if(!data) return
    return `
   <div class="text-reset notification-item d-block dropdown-item position-relative ${active===0 ? "" : "active"} latestItem" data-id="${data.id}">
                                        <div class="d-flex">
                                            <div class="avatar-xs me-3">
                                                <span class="avatar-title bg-soft-info text-info rounded-circle fs-16">
                                                    <i class="${icon}"></i>
                                                </span>
                                            </div>
                                            <div class="flex-1">
                                                <a href="javascript:void(0)" class="stretched-link" onclick="handleLinkClick('${data.id}', '${process}')">
                                                    <h6 class="mt-0 mb-2 lh-base">${data.title}</h6>
                                                </a>
                                                <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                    <span><i class="mdi mdi-clock-outline"></i> ${data.createdDate}</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
    `
}

function viewAllLatest(check){
    if(check === "Events"){
        return `
                                    <div class="my-3 text-center">
                                        <a href="/schedules/detail/${userCurrent.id}" type="button" class="btn btn-soft-success waves-effect waves-light">View
                                            All ${check} <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
        `
    }
        return `
                                    <div class="my-3 text-center">
                                        <a href="/${check.toLowerCase()}" type="button" class="btn btn-soft-success waves-effect waves-light">View
                                            All ${check} <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
        `
}

async function fetchNotifications(limit) {
    try {
        const [notificationsData, eventsData] = await Promise.all([
            fetchNotificationsData(limit),
            fetchEventsData(limit),
        ]);
        let readIdNotifications = getIdFromLocal("notifications")
        let readIdEvents = getIdFromLocal("events")
        let htmlNotification = ''
        let htmlEvent = ''
        notificationsData.forEach(e=>{
            let active = readIdNotifications.includes(e.id) ? 0 : 1
            htmlNotification+= returnItemLatest(e, "bx bx-news", "notifications", active)
        })
        eventsData.forEach(e=>{
            let active = readIdEvents.includes(e.id) ? 0 : 1
            htmlEvent+= returnItemLatest(e, "bx bx-calendar-star", "events", active)
        })
        htmlNotification+= viewAllLatest("Notifications")
        htmlEvent += viewAllLatest("Events")
        $(".notificationsLatestList .simplebar-content").html(htmlNotification)
        $(".eventsLatestList .simplebar-content").html(htmlEvent)
        let data = notificationsData.concat(eventsData)
        data.sort((a, b) => stringToDateValid(b.createdDate) - stringToDateValid(a.createdDate));
        return data
    } catch (error) {
        console.error("An error occurred:", error);
    }
}


document.addEventListener("DOMContentLoaded", function () {
    if(typeof userCurrent !== "undefined"){
        fetchNotifications(5).then(rs => {
            countUnRead()
        })
    }
})


