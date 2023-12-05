const dbName = 'myDatabase';
const dbVersion = 1;
const storeName = 'users';

self.addEventListener('install', function(event) {
    event.waitUntil(
        self.skipWaiting()
    );
});

self.addEventListener('notificationclick', function(event) {
    let data = event.notification;
    let arrTag = data.tag ? data.tag.split(",") : []
    let url = "/"
    if(data.title == "Events"){
        url = "/schedules/detail/" + arrTag[0]
    }else if(data.title == "Notifications"){
        url = "/notifications/" + arrTag[1]
    }
    event.notification.close();
    event.waitUntil(
        self.clients.openWindow(url, '_blank')
    );
});


function showPushNotification(event){
    let dataEvent = JSON.parse(event.data.text())
    if(dataEvent.categoryPush === "Events"){
        let options = {
            body: dataEvent.title,
            icon: `/assets/images/icon-event.png`,
            tag: `,${dataEvent.id}`,
            renotify: true,
            requireInteraction: true,
        };
        event.waitUntil(self.registration.showNotification(dataEvent.categoryPush, options));
    } else if(dataEvent.categoryPush === "Notifications"){
        let options = {
            body: dataEvent.title,
            icon: `/assets/images/icon-push.png`,
            tag: `,${dataEvent.id}`,
            renotify: true,
            requireInteraction: true,
        };
        event.waitUntil(self.registration.showNotification(dataEvent.categoryPush, options));
    }
}

self.addEventListener('push', function(event) {
    // Check if notification permission is granted
    if (Notification.permission === 'granted') {
        // Permission is granted, display the notification
        showPushNotification(event)
    } else if (Notification.permission === 'default') {
        // Permission is not yet granted, request permission from the user
        Notification.requestPermission().then(function(permission) {
            if (permission === 'granted') {
                showPushNotification(event)
            } else {
                // Permission denied, handle accordingly
                console.log('Notification permission denied.');
            }
        });
    } else {
        // Permission denied, handle accordingly
        console.log('Notification permission denied.');
    }

});