package com.webapp.erpapp.model.request.subscribe;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatePushSubscriptionRequest {
    private String endpoint;
    private String p256dh;
    private String auth;
    private String userId;
}
