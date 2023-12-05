package com.webapp.erpapp.model.response.managementtimedetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayDetailResponse {
    private String id;
    private String[] data;
}
