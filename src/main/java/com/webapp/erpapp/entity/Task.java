package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.task.PriorityTaskEnum;
import com.webapp.erpapp.enums.task.StatusDeleteTaskEnum;
import com.webapp.erpapp.enums.task.StatusTaskEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Task {

    private String id;
    private StatusTaskEnum statusTask;
    private String title;
    private String content;
    private User user;
    private Date createdDate;
    private Date startDate;
    private Date dueDate;
    private Date closeDate;
    private Integer progress;
    private PriorityTaskEnum priority;
    private StatusDeleteTaskEnum status;
    private List<CommentTask> comments;
}