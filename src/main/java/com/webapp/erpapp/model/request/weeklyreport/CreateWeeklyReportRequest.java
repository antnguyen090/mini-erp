package com.webapp.erpapp.model.request.weeklyreport;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateWeeklyReportRequest {

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field currentWeeklyContent is not filled")
    private String currentWeeklyContent;

    @NotBlank(message = "Field nextWeeklyContent is not filled")
    private String nextWeeklyContent;

    @NotBlank(message = "Field userId is not filled")
    private String userId;
}
