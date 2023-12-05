package com.webapp.erpapp.model.request.managementtime.day;

import com.webapp.erpapp.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayCreateRequest {
    private Date day;
    private DataOfDayDto data;
    private String userId;
}
