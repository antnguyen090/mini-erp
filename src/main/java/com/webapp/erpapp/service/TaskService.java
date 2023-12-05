package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.task.TaskRegisterRequest;
import com.webapp.erpapp.model.request.task.TaskUpdateRequest;
import com.webapp.erpapp.model.response.task.DashboardTaskResponse;
import com.webapp.erpapp.model.response.task.StatusTaskCountsResponse;
import com.webapp.erpapp.model.response.task.TaskDetailResponse;
import com.webapp.erpapp.model.response.task.TaskShowResponse;

import java.util.List;
import java.util.Map;

public interface TaskService {
    List<TaskShowResponse> findAll(int start, int pageSize, String statusTask, String search);
    long getTotalItem(String statusTask, String search);
    int registerTask(TaskRegisterRequest taskRegisterRequest);
    int updateTask(TaskUpdateRequest taskUpdateRequest);
    int deleteById(String id);
    List<StatusTaskCountsResponse> getStatusTaskCount();
    TaskDetailResponse findById(String id);
    List<Map<String, Object>> getTaskByHashtag(String userId, String hashtag);
    int deleteByIds(String[] ids);

    DashboardTaskResponse getOpenedTask(String userId);
}
