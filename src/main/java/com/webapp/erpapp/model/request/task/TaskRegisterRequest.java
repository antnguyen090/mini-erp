package com.webapp.erpapp.model.request.task;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskRegisterRequest {

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    private Date dueDate;

    @NotBlank(message = "Field priority is not filled")
    private String priority;
}
