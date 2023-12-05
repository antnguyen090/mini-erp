package com.webapp.erpapp.service;

import com.webapp.erpapp.model.response.schedule.ScheduleListResponse;

public interface ScheduleService {
    ScheduleListResponse getScheduleDetail(String userId, String monthly);
}