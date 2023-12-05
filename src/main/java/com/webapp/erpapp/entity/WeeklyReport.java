package com.webapp.erpapp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyReport {
    private String id;
    private String title;
    private String currentWeeklyContent;
    private String nextWeeklyContent;
    private Date createdDate;
    private User user;
}
