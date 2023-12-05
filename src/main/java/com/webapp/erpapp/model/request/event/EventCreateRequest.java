package com.webapp.erpapp.model.request.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventCreateRequest {
    private String userId;

    @NotBlank(message = "Field is not filled")
    private String type;

    @NotBlank(message = "Field is not filled")
    private String title;

    @NotBlank(message = "Field is not filled")
    private String content;

    @NotBlank(message = "Field is not filled")
    private String startDate;

    @NotBlank(message = "Field is not filled")
    private String endDate;
}
