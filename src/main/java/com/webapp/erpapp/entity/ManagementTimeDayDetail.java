package com.webapp.erpapp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ManagementTimeDayDetail {

    private String id;
    private ManagementTimeDay managementTimeDay;
    private String sixToTwelvePM;
    private String twelveToSixPM;
    private String sixToTwelveAM;

}
