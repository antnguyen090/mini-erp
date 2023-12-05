package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.Notification.StatusNotificationEnum;
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
public class Notification {

    private String id;
    private StatusNotificationEnum status;
    private String title;
    private String content;
    private String files;
    private User user;
    private Date createdDate;
    private List<CommentNotification> comments;
}
