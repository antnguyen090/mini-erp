package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.CommentNotification;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.mapper.CommentNotificationMapper;
import com.webapp.erpapp.mapper.NotificationMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.commentnotification.CreateCommentNotificationRequest;
import com.webapp.erpapp.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.webapp.erpapp.model.response.commentnotification.CommentNotificationResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
public class CommentNotificationConverter {

    @Autowired
    private NotificationMapper notificationMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommentNotificationMapper commentNotificationMapper;

    public CommentNotificationResponse toResponse(CommentNotification commentNotification) {

        User user = commentNotification.getUser();
            String avatarUser = null, fullnameUser = null, userId = null,parentCommentId = null;
            if(user != null){
                avatarUser = FileUtils.getPathUpload(User.class, user.getAvatar());
                fullnameUser = user.getFullname();
                userId = user.getId();
            }
            CommentNotification parentComment = commentNotification.getParentComment();
            if(parentComment != null){
                parentCommentId = parentComment.getId();
        }
        return CommentNotificationResponse.builder()
                .id(commentNotification.getId())
                .parentId(parentCommentId)
                .content(commentNotification.getContent())
                .createdDate(DateUtils.formatDateTime(commentNotification.getCreatedDate()))
                .modifiedBy(commentNotification.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentNotification.getModifiedDate()))
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .userId(userId)
                .childComments(toListResponse(commentNotification.getChildComments()))
                .build();
    }

    public List<CommentNotificationResponse> toListResponse(List<CommentNotification> commentNotifications) {
        if(commentNotifications == null) return null;
        return commentNotifications.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }

    public CommentNotification toEntity(CreateCommentNotificationRequest createCommentNotificationRequest) {

        return CommentNotification.builder().id(ApplicationUtils.generateId())
                .content(createCommentNotificationRequest.getContent())
                .createdDate(new Date())
                .notification(notificationMapper.findById(createCommentNotificationRequest.getNotificationId()))
                .user(userMapper.findById(createCommentNotificationRequest.getUserId()))
                .parentComment(commentNotificationMapper.findById(createCommentNotificationRequest.getParentId()))
                .build();
    }

    public CommentNotification toEntity(UpdateCommentNotificationRequest updateCommentNotificationRequest) {
        return CommentNotification.builder()
                .content(updateCommentNotificationRequest.getContent())
                .id(updateCommentNotificationRequest.getId())
                .modifiedBy(userMapper.findById(updateCommentNotificationRequest.getUserId()).getFullname())
                .modifiedDate(new Date())
                .build();
    }
}
