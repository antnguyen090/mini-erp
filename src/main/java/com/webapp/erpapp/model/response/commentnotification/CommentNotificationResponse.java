package com.webapp.erpapp.model.response.commentnotification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentNotificationResponse {
    private String id;
    private String content;
    private String createdDate;
    private String modifiedBy;
    private String modifiedDate;
    private String fullnameUser;
    private String avatarUser;
    private String parentId;
    private String userId;
    private String clientId;
    private String notificationId;
    private List<CommentNotificationResponse> childComments;
}
