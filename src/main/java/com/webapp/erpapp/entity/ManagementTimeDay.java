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
public class ManagementTimeDay {
    private String id;
    private String oneThingCalendar;
    private String toDoList;
    private String gratitudeDiary;
    private String affirmation;
    private Date day;
    private User user;
    private String weeklyCode;
}
