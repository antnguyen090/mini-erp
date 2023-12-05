package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.ManagementTimeConvert;
import com.webapp.erpapp.converter.WeeklyManagementTimeDayConverter;
import com.webapp.erpapp.entity.ManagementTimeDay;
import com.webapp.erpapp.entity.WeeklyManagementTimeDay;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.ManagementTimeDayMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.mapper.WeeklyManagementTimeDayMapper;
import com.webapp.erpapp.model.request.managementtime.day.DayCreateRequest;
import com.webapp.erpapp.model.request.managementtime.day.DayUpdateRequest;
import com.webapp.erpapp.model.response.managementtime.day.DayResponse;
import com.webapp.erpapp.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.webapp.erpapp.service.ManagementTimeDayService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;

@Service
public class ManagementTimeDayServiceImpl implements ManagementTimeDayService {

    @Autowired
    private ManagementTimeConvert managementTimeConvert;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;

    private LocalDate getFisrtDateOfWeek(Date currentDate){
        Instant instant = currentDate.toInstant();
        LocalDate currentLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();
        return currentLocalDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
    }

    private LocalDate getLastDateOfWeek(Date currentDate){
        Instant instant = currentDate.toInstant();
        LocalDate currentLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();
        return currentLocalDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
    }

    @Override
    public DayResponse createDay(DayCreateRequest dayCreateRequest) {

        if(userMapper.findById(dayCreateRequest.getUserId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        ManagementTimeDay day = managementTimeConvert.toEntity(dayCreateRequest);
        try{
            Date currentDate = dayCreateRequest.getDay();
            LocalDate firstDayOfWeek = getFisrtDateOfWeek(currentDate);
            LocalDate lastDayOfWeek = getLastDateOfWeek(currentDate);
            String userId = dayCreateRequest.getUserId();

            WeeklyManagementTimeDay weeklyManagementTimeDay =
                    weeklyManagementTimeDayMapper.findByStartDateAndEndDateOfUser(userId, firstDayOfWeek, lastDayOfWeek);
            if(weeklyManagementTimeDay == null){

                String generateCodeWeekly = "WEEKLY_CODE_" + ApplicationUtils.generateId();

                WeeklyManagementTimeDay w = weeklyManagementTimeDayConverter.createWeeklyManagementTimeDay(
                        generateCodeWeekly,
                        firstDayOfWeek,
                        lastDayOfWeek,
                        dayCreateRequest.getUserId()
                );
                weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(w);

                day.setWeeklyCode(generateCodeWeekly);
            }else{
                day.setWeeklyCode(weeklyManagementTimeDay.getCode());
            }

            managementTimeDayMapper.createDayInfo(day);

            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse updateDay(DayUpdateRequest dayUpdateRequest) {

        if(managementTimeDayMapper.findById(dayUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        ManagementTimeDay day = managementTimeConvert.toEntity(dayUpdateRequest);
        try{
            managementTimeDayMapper.updateDayInfo(day);
            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse findById(String id) {
        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findById(id);
        if(managementTimeDay!= null){
            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
            return managementTimeConvert.toResponse(managementTimeDay);
        }
        return null;
    }

    @Override
    public DayResponse findByDay(String userId, String day) {
        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findByDay(userId, day);
        if(managementTimeDay!= null){
            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
            return managementTimeConvert.toResponse(managementTimeDay);
        }
        return null;
    }

    @Override
    public DayResponse findDayResponse(String userId, String day, String id) {
        DayResponse dayResponseId = findById(id);
        if(dayResponseId == null){
            DayResponse dayResponseDay = findByDay(userId, day);
            if(dayResponseDay == null){
                return null;
            }
            return dayResponseDay;
        }
        return dayResponseId;
    }

    @Override
    public List<WeeklyManagementTimeDayResponse> getDays(String userId, String startDate, String endDate) {

        applicationUtils.checkUserAllow(userId);

        if(userMapper.findById(userId) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        List<ManagementTimeDay> managementTimeDays = managementTimeDayMapper.findAllByMonthYear(userId, startDate, endDate);
        List<WeeklyManagementTimeDayResponse> rs = weeklyManagementTimeDayConverter.toListWeeklyResponse(userId, managementTimeDays);

        return rs;
    }
}