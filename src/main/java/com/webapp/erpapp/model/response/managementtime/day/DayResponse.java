package com.webapp.erpapp.model.response.managementtime.day;

import com.webapp.erpapp.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayResponse {
    private String id;
    private String day;
    private DataOfDayDto data;
}