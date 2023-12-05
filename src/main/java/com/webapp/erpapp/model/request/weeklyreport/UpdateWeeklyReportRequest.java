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
public class UpdateWeeklyReportRequest {

    @NotBlank
    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field currentWeeklyContent is not filled")
    private String currentWeeklyContent;

    @NotBlank(message = "Field nextWeeklyContent is not filled")
    private String nextWeeklyContent;
}
