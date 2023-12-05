package com.webapp.erpapp.entity;

import lombok.*;

import java.sql.Time;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Timesheets{

    private String id;
    private Date workDate;
    private String content;
    private String timesheetsCode;
}