package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.commenttask.CreateCommentTaskRequest;
import com.webapp.erpapp.model.request.commenttask.UpdateCommentTaskRequest;
import com.webapp.erpapp.model.response.commenttask.CommentTaskResponse;
import com.webapp.erpapp.service.CommentTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/comment-task")
public class CommentTaskApi {

    @Autowired
    CommentTaskService commentTaskService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(commentTaskService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> createCommentTask(@Valid CreateCommentTaskRequest createCommentTaskRequest) {
        CommentTaskResponse commentTaskResponse = commentTaskService.createCommentTask(createCommentTaskRequest);
        if(commentTaskResponse != null){
            if(createCommentTaskRequest.getParentId() == null){
                messagingTemplate.convertAndSend("/task-comment/create", commentTaskResponse);
            } else{
                messagingTemplate.convertAndSend("/task-comment/reply", commentTaskResponse);
            }
            return ResponseEntity.ok(commentTaskResponse);
        } else{
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateCommentTask(@Valid UpdateCommentTaskRequest updateCommentTaskRequest) {
        CommentTaskResponse commentTaskResponse = commentTaskService.updateCommentTask(updateCommentTaskRequest);
        if(commentTaskResponse != null){
            messagingTemplate.convertAndSend("/task-comment/edit", commentTaskResponse);
            return ResponseEntity.ok(commentTaskResponse);
        } else{
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable("id") String id){
        int deletedComment = commentTaskService.deleteCommentTask(id);
        if (deletedComment > 0) {
            messagingTemplate.convertAndSend("/task-comment/delete", id);
            return ResponseEntity.ok(deletedComment);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
