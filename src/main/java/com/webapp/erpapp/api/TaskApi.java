package com.webapp.erpapp.api;

import com.webapp.erpapp.constant.TaskConstant;
import com.webapp.erpapp.model.request.task.ListTaskRequest;
import com.webapp.erpapp.model.request.task.TaskRegisterRequest;
import com.webapp.erpapp.model.request.task.TaskUpdateRequest;
import com.webapp.erpapp.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/tasks")
public class TaskApi {

    @Autowired
    TaskService taskService;

    @PostMapping
    public ResponseEntity<?> findAll(@RequestBody ListTaskRequest listTaskRequest) {
        Integer page = listTaskRequest.getPage() != null?listTaskRequest.getPage():1;
        int pageSize = listTaskRequest.getPageSize() != null?listTaskRequest.getPageSize(): TaskConstant.pageSizeDefault;
        return ResponseEntity.ok(taskService.findAll(page, pageSize, listTaskRequest.getStatusTask(), listTaskRequest.getSearch()));
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerTask(@Valid @RequestBody TaskRegisterRequest taskRegisterRequest) {
        return ResponseEntity.ok(taskService.registerTask(taskRegisterRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateTask(@Valid @RequestBody TaskUpdateRequest taskUpdateRequest){
        return ResponseEntity.ok(taskService.updateTask(taskUpdateRequest));
    }

    @GetMapping("/status-task-count")
    public ResponseEntity<?> getStatusTaskCount(){
        return ResponseEntity.ok(taskService.getStatusTaskCount());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDetailTask(@PathVariable String id){
        return ResponseEntity.ok(taskService.findById(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTask(@PathVariable("id") String id){
        return ResponseEntity.ok(taskService.deleteById(id));
    }

    @DeleteMapping
    public ResponseEntity<?> deleteTasks(@RequestBody String[] ids){
        return ResponseEntity.ok(taskService.deleteByIds(ids));
    }

    @GetMapping("/hashtag/{userId}")
    public ResponseEntity<?> getTaskByHashtag(@PathVariable("userId") String userId,
                                              @RequestParam String hashtag){
        return ResponseEntity.ok(taskService.getTaskByHashtag(userId, hashtag));
    }

    @PostMapping("/count")
    public ResponseEntity<?> getTotalItem(@RequestBody ListTaskRequest listTaskRequest){
        return ResponseEntity.ok(taskService.getTotalItem(listTaskRequest.getStatusTask(), listTaskRequest.getSearch()));
    }

    @GetMapping("/opened/{userId}")
    public ResponseEntity<?> getOpenedTask(@PathVariable("userId") String userId) {
        return ResponseEntity.ok(taskService.getOpenedTask(userId));
    }
}