package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.commenttask.CreateCommentTaskRequest;
import com.webapp.erpapp.model.request.commenttask.UpdateCommentTaskRequest;
import com.webapp.erpapp.model.response.commenttask.CommentTaskResponse;

public interface CommentTaskService {
    CommentTaskResponse findById(String id);
    CommentTaskResponse createCommentTask(CreateCommentTaskRequest createCommentTaskRequest);
    CommentTaskResponse updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest);
    int deleteCommentTask(String id);
}
