package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.CommentNotification;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentNotificationMapper {
    int createCommentNotification(CommentNotification commentNotification);
    int updateCommentNotification(CommentNotification commentNotification);
    int deleteById(String id);
    CommentNotification findById(String id);
}
