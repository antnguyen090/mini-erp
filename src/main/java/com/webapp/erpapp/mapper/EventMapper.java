package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface EventMapper {
    List<Event> getAllEventsByMonth(LocalDate prevMonth,LocalDate nextMonth);

    Event findById(String id);

    void deleteEvent(String id);

    void createEvent(Event event);

    int editEvent(Event event);

    List<Event> getUpcomingEvents(String day, RowBounds rowBounds);

    long getTotalRecordCountUpcoming(String day);

    List<Event> getEventNotification(Integer limit);
}
