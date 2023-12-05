package com.webapp.erpapp.model.response.weeklyReport;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyReportShowResponse {
    private String id;
    private String title;
    private String fullnameUser;
    private String createdDate;
}
