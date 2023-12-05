package com.webapp.erpapp.model.request.managementtime.day;

import com.webapp.erpapp.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayUpdateRequest {
    private String id;
    private DataOfDayDto data;
}
