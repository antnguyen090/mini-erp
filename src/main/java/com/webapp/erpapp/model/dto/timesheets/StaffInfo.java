package com.webapp.erpapp.model.dto.timesheets;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StaffInfo {
    private String id;
    private String name;
    private Map<String, String> dateTimes;
}
