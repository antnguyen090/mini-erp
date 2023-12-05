package com.webapp.erpapp.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDayResponse {
    private String weeklyId;
    private String startDate;
    private String[] weeklyContents;
    private List<DayResponse> listDayOfWeek;
}
