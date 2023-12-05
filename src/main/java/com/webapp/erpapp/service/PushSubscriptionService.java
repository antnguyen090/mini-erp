package com.webapp.erpapp.service;

import com.webapp.erpapp.entity.PushSubscription;
import com.webapp.erpapp.model.request.subscribe.CreatePushSubscriptionRequest;

public interface PushSubscriptionService {
    int createPushSubscription(CreatePushSubscriptionRequest createPushSubscriptionRequest);
    void sendNotification(PushSubscription subscription, String payload) throws Exception;
    void sendNotificationAll(String payload, String userId);
    int deletePushSubscription(String endpoint);
}
