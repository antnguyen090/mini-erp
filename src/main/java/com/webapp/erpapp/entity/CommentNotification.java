package com.webapp.erpapp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentNotification {
    private String id;
    private String content;
    private Date createdDate;
    private Date modifiedDate;
    private Notification notification;
    private User user;
    private CommentNotification parentComment;
    private String modifiedBy;
    private List<CommentNotification> childComments;
}

