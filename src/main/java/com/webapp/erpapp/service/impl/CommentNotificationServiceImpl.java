package com.webapp.erpapp.service.impl;


import com.webapp.erpapp.converter.CommentNotificationConverter;
import com.webapp.erpapp.entity.CommentNotification;
import com.webapp.erpapp.entity.Notification;
import com.webapp.erpapp.enums.Notification.StatusNotificationEnum;
import com.webapp.erpapp.mapper.CommentNotificationMapper;
import com.webapp.erpapp.mapper.NotificationMapper;
import com.webapp.erpapp.model.request.commentnotification.CreateCommentNotificationRequest;
import com.webapp.erpapp.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.webapp.erpapp.model.response.commentnotification.CommentNotificationResponse;
import com.webapp.erpapp.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentNotificationServiceImpl implements CommentNotificationService {

    @Autowired
    CommentNotificationMapper commentNotificationMapper;

    @Autowired
    CommentNotificationConverter commentNotificationConverter;

    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public CommentNotificationResponse findById(String id) {
        CommentNotification commentNotification = commentNotificationMapper.findById(id);
        return commentNotificationConverter.toResponse(commentNotification);
    }

    @Override
    public CommentNotificationResponse createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest){
        Notification notificationDb = notificationMapper.getNotificationById(createCommentNotificationRequest.getNotificationId());
        if(notificationDb == null || notificationDb.getStatus().equals(StatusNotificationEnum.INACTIVE)){
            return new CommentNotificationResponse();
        }
        CommentNotification commentNotification = commentNotificationConverter.toEntity(createCommentNotificationRequest);
        commentNotificationMapper.createCommentNotification(commentNotification);
        return commentNotificationConverter.toResponse(commentNotification);
    }

    @Override
    public CommentNotificationResponse updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest){
        if(commentNotificationMapper.findById(updateCommentNotificationRequest.getId()) == null){
            return new CommentNotificationResponse();
        }
        CommentNotification commentNotification = commentNotificationConverter.toEntity(updateCommentNotificationRequest);
        int rs = commentNotificationMapper.updateCommentNotification(commentNotification);
        if(rs>0){
            return commentNotificationConverter.toResponse(commentNotification);
        }
        return new CommentNotificationResponse();
    }

    @Override
    public int deleteCommentNotification(String id){
        if(commentNotificationMapper.findById(id) == null)
            return 0;
        return commentNotificationMapper.deleteById(id);
    }
}
