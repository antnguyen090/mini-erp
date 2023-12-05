package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.commentnotification.CreateCommentNotificationRequest;
import com.webapp.erpapp.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.webapp.erpapp.model.response.commentnotification.CommentNotificationResponse;

public interface CommentNotificationService {
    CommentNotificationResponse findById(String id);
    CommentNotificationResponse createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest);
    CommentNotificationResponse updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest);
    int deleteCommentNotification(String id);
}
