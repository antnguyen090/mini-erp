package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.ManagementTimeDay;
import com.webapp.erpapp.mapper.ManagementTimeDayMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.dto.management_time.DataOfDayDto;
import com.webapp.erpapp.model.dto.management_time.OneThingCalendarDto;
import com.webapp.erpapp.model.dto.management_time.ToDoListDto;
import com.webapp.erpapp.model.request.managementtime.day.DayCreateRequest;
import com.webapp.erpapp.model.request.managementtime.day.DayUpdateRequest;
import com.webapp.erpapp.model.response.managementtime.day.DayResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ManagementTimeConvert {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    public DayResponse toResponse(ManagementTimeDay day){
        if(day == null) return null;
        DataOfDayDto data = new DataOfDayDto();
        data.setOneThingCalendar(JsonUtils.jsonToObject(day.getOneThingCalendar(), OneThingCalendarDto.class));
        data.setToDoList(JsonUtils.jsonToObject(day.getToDoList(), ToDoListDto.class));
        data.setGratitudeDiary(JsonUtils.jsonToObject(day.getGratitudeDiary(), List.class));
        data.setAffirmation(day.getAffirmation());

        return DayResponse.builder()
                .id(day.getId())
                .day(DateUtils.formatDate(day.getDay()))
                .data(data)
                .build();
    }

    public ManagementTimeDay toEntity(DayCreateRequest dayCreateRequest){

        DataOfDayDto dataRequest = dayCreateRequest.getData();

        return ManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .day(dayCreateRequest.getDay())
                .oneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()))
                .toDoList(JsonUtils.objectToJson(dataRequest.getToDoList()))
                .gratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()))
                .affirmation(dataRequest.getAffirmation())
                .user(userMapper.findById(dayCreateRequest.getUserId()))
                .build();
    }

    public ManagementTimeDay toEntity(DayUpdateRequest dayUpdateRequest){

        ManagementTimeDay day = managementTimeDayMapper.findById(dayUpdateRequest.getId());

        DataOfDayDto dataRequest = dayUpdateRequest.getData();

        day.setOneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()));
        day.setToDoList(JsonUtils.objectToJson(dataRequest.getToDoList()));
        day.setGratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()));
        day.setAffirmation(dataRequest.getAffirmation());

        return day;
    }
}
