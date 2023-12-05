package com.webapp.erpapp.model.request.task;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    private String action;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field priority is not filled")
    private String priority;

    @Min(value = 0, message = "Field progress must >= 0")
    @Max(value = 100, message = "Field progress must <= 100")
    private Integer progress;

    @NotBlank(message = "Field content is not filled")
    private String content;

    private Date dueDate;
}
