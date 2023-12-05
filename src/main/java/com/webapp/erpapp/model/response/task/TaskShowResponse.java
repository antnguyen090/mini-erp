package com.webapp.erpapp.model.response.task;

import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskShowResponse {

    private String id;
    private EnumDto statusTask;
    private String title;
    private IdAndFullnameUserResponse user;
    private String startDate;
    private String dueOrCloseDate;
    private Integer progress;
    private EnumDto priority;
}