package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface TaskMapper {

    List<Task> findAll( String statusTask,
                        String search,
                       RowBounds rowBounds);
    long getTotalItem( String statusTask,
                       String search);
    int registerTask(Task task);
    int updateTask(Task task);
    int changeStatusTask( String id,
                          String status);
    List<Map<String, Object>> getStatusTaskCounts();
    Task findById(String id);
    List<Map<String, Object>> getTaskByHashtag( String userId,
                                                String hashtag);
    int changeStatusTasks( String[] ids,
                           String status);

    List<Task> getOpenedTask( String userId);
    List<Map<String, Object>> getOpenedStatusTaskCounts( String userId);

}