package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.WeeklyManagementTimeDayConverter;
import com.webapp.erpapp.entity.WeeklyManagementTimeDay;
import com.webapp.erpapp.mapper.WeeklyManagementTimeDayMapper;
import com.webapp.erpapp.model.request.managementtime.weekly.WeeklyManagementTimeDayUpdateRequest;
import com.webapp.erpapp.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.webapp.erpapp.service.WeeklyManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WeeklyManagementTimeDayServiceImpl implements WeeklyManagementTimeDayService {

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;

    @Override
    public int updateWeekly(WeeklyManagementTimeDayUpdateRequest weeklyManagementTimeDayUpdateRequest) {

        try{
            WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayConverter.toUpdateWeeklyManagementTimeDay(
                    weeklyManagementTimeDayUpdateRequest.getId(), weeklyManagementTimeDayUpdateRequest.getContent()
            );
            weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyManagementTimeDay);
            return 1;
        } catch (Exception e){

        }
        return 0;
    }

    @Override
    public WeeklyManagementTimeDayResponse getWeekly(String id){
        return weeklyManagementTimeDayConverter.toResponse(weeklyManagementTimeDayMapper.findById(id));
    }
}
