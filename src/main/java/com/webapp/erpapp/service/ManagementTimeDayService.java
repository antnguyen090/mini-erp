package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.managementtime.day.DayCreateRequest;
import com.webapp.erpapp.model.request.managementtime.day.DayUpdateRequest;
import com.webapp.erpapp.model.response.managementtime.day.DayResponse;
import com.webapp.erpapp.model.response.managementtime.day.WeeklyManagementTimeDayResponse;

import java.util.List;

public interface ManagementTimeDayService {
    DayResponse createDay(DayCreateRequest dayCreateRequest);
    DayResponse updateDay(DayUpdateRequest dayUpdateRequest);
    DayResponse findById(String id);
    DayResponse findByDay(String userId, String day);
    DayResponse findDayResponse(String userId, String day, String id);
    List<WeeklyManagementTimeDayResponse> getDays(String userId, String startDate, String endDate);
}
