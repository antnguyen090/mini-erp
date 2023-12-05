package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.PushSubscription;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.subscribe.CreatePushSubscriptionRequest;
import com.webapp.erpapp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PushSubscriptionConverter {
    @Autowired
    UserMapper userMapper;
    public PushSubscription toEntity(CreatePushSubscriptionRequest createPushSubscriptionRequest) {
        return PushSubscription.builder()
                .id(ApplicationUtils.generateId())
                .endpoint(createPushSubscriptionRequest.getEndpoint())
                .p256dh(createPushSubscriptionRequest.getP256dh())
                .auth(createPushSubscriptionRequest.getAuth())
                .user(userMapper.findById(createPushSubscriptionRequest.getUserId()))
                .build();
    }
}
