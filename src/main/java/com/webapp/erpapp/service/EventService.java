package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.event.EventCreateRequest;
import com.webapp.erpapp.model.request.event.EventEditRequest;
import com.webapp.erpapp.model.response.event.DashBoardResponse;
import com.webapp.erpapp.model.response.event.EventNotificationResponse;
import com.webapp.erpapp.model.response.event.EventResponse;

import java.util.List;

public interface EventService {
    List<EventResponse> getAllEventsByMonth(String month);

    EventResponse createEvent(EventCreateRequest request);

    int editEvent(EventEditRequest request);

    int deleteEvent(String id);

    DashBoardResponse getUpcomingEvent(String day, Integer page, Integer size);

    List<EventNotificationResponse> getEventNotification(Integer limit);
}
