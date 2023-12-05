package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.managementtime.weekly.WeeklyManagementTimeDayUpdateRequest;
import com.webapp.erpapp.model.response.managementtime.day.WeeklyManagementTimeDayResponse;

public interface WeeklyManagementTimeDayService {
    int updateWeekly(WeeklyManagementTimeDayUpdateRequest content);
    WeeklyManagementTimeDayResponse getWeekly(String id);
}
