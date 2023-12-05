package com.webapp.erpapp.entity;

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
public class CommentTask {
    private String id;
    private String title;
    private String content;
    private String files;
    private Date createdDate;
    private Date modifiedDate;
    private Task task;
    private User user;
    private CommentTask parentComment;
    private String modifiedBy;
    private List<CommentTask> childComments;
}

