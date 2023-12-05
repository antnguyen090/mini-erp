package com.webapp.erpapp.model.response.task;

import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.model.dto.task.ActionChangeStatusTaskEnumDto;
import com.webapp.erpapp.model.response.commenttask.CommentTaskResponse;
import com.webapp.erpapp.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TaskDetailResponse {
    private String id;
    private ActionChangeStatusTaskEnumDto statusTask;
    private String title;
    private IdAndFullnameUserResponse user;
    private String createdDate;
    private String startDate;
    private String dueDate;
    private String closeDate;
    private Integer progress;
    private EnumDto priority;
    private String content;
    private List<CommentTaskResponse> comments;
}
