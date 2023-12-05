package com.webapp.erpapp.model.request.managementtime.daydetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayDetailCreateRequest {
    private String dayId;
    private String code;
    private String[] data;
}
