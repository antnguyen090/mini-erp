package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.commentnotification.CreateCommentNotificationRequest;
import com.webapp.erpapp.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.webapp.erpapp.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/comment-notification")
public class CommentNotificationApi {

    @Autowired
    CommentNotificationService commentNotificationService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getComment(@PathVariable("id") String id){
        return ResponseEntity.ok(commentNotificationService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> commentNotification(@Valid @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest){
        return ResponseEntity.ok(commentNotificationService.createCommentNotification(createCommentNotificationRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateComment(@Valid @RequestBody UpdateCommentNotificationRequest updateCommentNotificationRequest){
        return ResponseEntity.ok(commentNotificationService.updateCommentNotification(updateCommentNotificationRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable("id") String id){
        return ResponseEntity.ok(commentNotificationService.deleteCommentNotification(id));
    }
}
