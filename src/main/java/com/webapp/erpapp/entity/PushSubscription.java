package com.webapp.erpapp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PushSubscription {
    private String id;
    private String endpoint;
    private String p256dh;
    private String auth;
    private User user;
}
