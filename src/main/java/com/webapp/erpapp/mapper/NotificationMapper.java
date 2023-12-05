package com.webapp.erpapp.mapper;


import com.webapp.erpapp.entity.Notification;
import com.webapp.erpapp.enums.Notification.StatusNotificationEnum;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(int start,
                                  int pageSize,
                                  String search,
                                  StatusNotificationEnum status
    );

    List<Notification> getInactiveNoti(int start,
                                  int pageSize,
                                  StatusNotificationEnum status
    );
    List<Notification> getNotificationLatest(int limit);
    Notification createNoti(Notification notification);
    boolean delNoti(String id, StatusNotificationEnum status);
    Notification findById(String id);
    int countAll(String search, StatusNotificationEnum status);
    int updateNotification(Notification notification);
    Notification getNotificationById(String id);
}