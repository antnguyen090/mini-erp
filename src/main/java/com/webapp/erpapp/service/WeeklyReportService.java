package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.webapp.erpapp.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.webapp.erpapp.model.response.weeklyReport.WeeklyReportDetailResponse;

import java.util.List;

public interface WeeklyReportService {
    List<WeeklyReportDetailResponse> getAllWeeklyReportByUser(String userId, int start, int pageSize);
    long getTotalWeeklyReportByUser(String userId);
    WeeklyReportDetailResponse findById(String id);
    int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest);
    WeeklyReportDetailResponse updateWeeklyReport(UpdateWeeklyReportRequest updateWeeklyReportRequest);
}
