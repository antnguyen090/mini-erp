package com.webapp.erpapp.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DataOfDayDto {
    private OneThingCalendarDto oneThingCalendar;
    private ToDoListDto toDoList;
    private List<String> gratitudeDiary;
    private String affirmation;
}
