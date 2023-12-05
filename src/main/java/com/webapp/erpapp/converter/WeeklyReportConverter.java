package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.WeeklyReport;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.mapper.WeeklyReportMapper;
import com.webapp.erpapp.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.webapp.erpapp.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.webapp.erpapp.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class WeeklyReportConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private WeeklyReportMapper weeklyReportMapper;

    public WeeklyReportDetailResponse toDetailResponse(WeeklyReport weeklyReport) {
        if (weeklyReport == null) return null;
        return WeeklyReportDetailResponse.builder()
                .id(weeklyReport.getId())
                .title(weeklyReport.getTitle())
                .currentWeeklyContent(weeklyReport.getCurrentWeeklyContent())
                .nextWeeklyContent(weeklyReport.getNextWeeklyContent())
                .user(userConverter.toIdAndFullnameUserResponse(weeklyReport.getUser()))
                .createdDate(DateUtils.formatDateTime(weeklyReport.getCreatedDate()))
                .build();
    }

    public WeeklyReport toEntity(CreateWeeklyReportRequest createWeeklyReportRequest) {
        return WeeklyReport.builder()
                .id(ApplicationUtils.generateId())
                .title(createWeeklyReportRequest.getTitle())
                .currentWeeklyContent(createWeeklyReportRequest.getCurrentWeeklyContent())
                .nextWeeklyContent(createWeeklyReportRequest.getNextWeeklyContent())
                .createdDate(new Date())
                .user(userMapper.findById(createWeeklyReportRequest.getUserId()))
                .build();
    }

    public WeeklyReport toEntity(UpdateWeeklyReportRequest updateWeeklyReportRequest) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(updateWeeklyReportRequest.getId());
        weeklyReport.setTitle(updateWeeklyReportRequest.getTitle());
        weeklyReport.setCurrentWeeklyContent(updateWeeklyReportRequest.getCurrentWeeklyContent());
        weeklyReport.setNextWeeklyContent(updateWeeklyReportRequest.getNextWeeklyContent());
        return weeklyReport;
    }
}
