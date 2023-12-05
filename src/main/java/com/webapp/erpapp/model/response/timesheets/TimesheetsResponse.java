package com.webapp.erpapp.model.response.timesheets;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimesheetsResponse{

    private String id;
    private String workDate;
    private String content;
    private String timesheetsCode;
}