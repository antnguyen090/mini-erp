package com.webapp.erpapp.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OneThingCalendarDto {
    private ItemDto theSingleMostImportantThing;
    private ItemDto lecture;
    private ItemDto dailyEvaluation;
    private ItemDto work;
    private ItemDto reading;
}
