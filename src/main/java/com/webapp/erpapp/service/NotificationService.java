package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.notification.CreateNotificationRequest;
import com.webapp.erpapp.model.request.notification.UpdateNotificationRequest;
import com.webapp.erpapp.model.response.notification.NotificationDetailResponse;
import com.webapp.erpapp.model.response.notification.NotificationShowResponse;

import java.util.List;

public interface NotificationService {
    List<NotificationShowResponse> getAllNoti(int start, int pageSize, String search);
    List<NotificationShowResponse> getInactiveNoti(int start, int pageSize);
    NotificationDetailResponse createNoti(CreateNotificationRequest createNotificationRequest);
    NotificationDetailResponse updateNotification(UpdateNotificationRequest updateNotificationRequest, String id);
    boolean delNoti(String id);
    NotificationDetailResponse findById(String id);
    int countAll(String search);
    List<NotificationShowResponse> getNotificationLatest(int limit);
}