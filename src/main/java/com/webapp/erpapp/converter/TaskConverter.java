package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.Task;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.enums.task.ActionChangeStatusTaskEnum;
import com.webapp.erpapp.enums.task.PriorityTaskEnum;
import com.webapp.erpapp.enums.task.StatusDeleteTaskEnum;
import com.webapp.erpapp.enums.task.StatusTaskEnum;
import com.webapp.erpapp.mapper.TaskMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.model.request.task.TaskRegisterRequest;
import com.webapp.erpapp.model.request.task.TaskUpdateRequest;
import com.webapp.erpapp.model.response.schedule.ScheduleListResponse;
import com.webapp.erpapp.model.response.task.StatusTaskCountsResponse;
import com.webapp.erpapp.model.response.task.TaskDetailResponse;
import com.webapp.erpapp.model.response.task.TaskShowResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.EnumUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class TaskConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommentTaskConverter commentTaskConverter;

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private UserConverter userConverter;

    public TaskShowResponse toResponse(Task task) {

        if (task == null) return null;

        Date dueDate = task.getDueDate();
        String dueOrCloseDate = null;
        if (dueDate != null) {
            if (!task.getStatusTask().equals(StatusTaskEnum.CLOSED))
                dueOrCloseDate = "~ " + DateUtils.formatDate(task.getDueDate());
            else dueOrCloseDate = DateUtils.formatDate(task.getCloseDate());
        }

        return TaskShowResponse.builder()
                .id(task.getId())
                .statusTask(EnumUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .user(userConverter.toIdAndFullnameUserResponse(task.getUser()))
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueOrCloseDate(dueOrCloseDate)
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .build();
    }

    public List<ScheduleListResponse.TaskResponse> toListTaskResponseOfSchedule(List<Task> tasks, List<User> users, String monthly) {
        List<ScheduleListResponse.TaskResponse> rs = new ArrayList<>();

        String createdOrStartDate = null;
        String dueOrCloseDate = null;
        for (Task task : tasks) {
            if (task != null) {

                Date createdDate = task.getCreatedDate();
                Date startDate = task.getStartDate();
                if (startDate == null) createdOrStartDate = DateUtils.formatDate(createdDate);
                else createdOrStartDate = DateUtils.formatDate(startDate);

                Date dueDate = task.getDueDate();
                if (!task.getStatusTask().equals(StatusTaskEnum.CLOSED)) {
                    if (dueDate == null) {
                        dueOrCloseDate = createdOrStartDate;
                    } else dueOrCloseDate = "~ " + DateUtils.formatDate(task.getDueDate());
                } else dueOrCloseDate = DateUtils.formatDate(task.getCloseDate());

                ScheduleListResponse.TaskResponse taskResponse = ScheduleListResponse.TaskResponse.builder()
                        .id(task.getId())
                        .title(task.getTitle())
                        .startDate(createdOrStartDate)
                        .dueOrCloseDate(dueOrCloseDate)
                        .statusTask(EnumUtils.instance(task.getStatusTask())).build();
                rs.add(taskResponse);
            }
        }
        SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date monthlyDate = monthFormat.parse(monthly);

            for (User user : users) {
                if (user != null) {
                    try {
                        String startDate = DateUtils.formatDate(user.getDateOfBirth());
                        String currentYear = getYearFromDate(monthFormat, monthlyDate);
                        String newStartDate = getUpdatedStartDate(startDate, monthly, currentYear);

                        ScheduleListResponse.TaskResponse taskResponse = ScheduleListResponse.TaskResponse.builder()
                                .id(user.getId())
                                .title("Happy Birthday to " + user.getFullname())
                                .startDate(newStartDate)
                                .dueOrCloseDate(newStartDate)
                                .statusTask(new EnumDto("BIRTHDAY", "Birthday"))
                                .build();

                        rs.add(taskResponse);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return rs;
    }
    private static String getYearFromDate(SimpleDateFormat format, Date date) {
        return format.format(date).substring(0, 4);
    }

    private static String getUpdatedStartDate(String startDate, String monthly, String currentYear) {
        int birthMonth = LocalDate.parse(monthly).getMonthValue();
        int userBirthMonth = LocalDate.parse(startDate).getMonthValue();

        if (birthMonth == 12 && userBirthMonth == 1) {
            int nextYear = Integer.parseInt(currentYear) + 1;
            return startDate.replace(startDate.split("-")[0], String.valueOf(nextYear));
        } else if (birthMonth == 1 && userBirthMonth == 12) {
            int previousYear = Integer.parseInt(currentYear) - 1;
            return startDate.replace(startDate.split("-")[0], String.valueOf(previousYear));
        } else {
            return startDate.replace(startDate.split("-")[0], currentYear);
        }
    }

    public Task toEntity(TaskRegisterRequest taskRegisterRequest) {

        return Task.builder()
                .id(ApplicationUtils.generateId())
                .statusTask(StatusTaskEnum.REGISTERED)
                .title(taskRegisterRequest.getTitle())
                .content(taskRegisterRequest.getContent())
                .user(userMapper.findById(taskRegisterRequest.getUserId()))
                .createdDate(new Date())
                .dueDate(taskRegisterRequest.getDueDate())
                .priority(EnumUtils.getEnumFromValue(PriorityTaskEnum.class,
                        taskRegisterRequest.getPriority()))
                .progress(0)
                .status(StatusDeleteTaskEnum.ACTIVE)
                .build();
    }

    public List<StatusTaskCountsResponse> toListStatusTaskCountsResponse(List<Map<String, Object>> statusTaskCounts) {
        return statusTaskCounts.stream()
                .map(statusTaskCount -> {
                    String statusTask = (String) statusTaskCount.get("statusTask");
                    if (!statusTask.equals("")) {
                        StatusTaskEnum statusEnum = EnumUtils.getEnumFromValue(StatusTaskEnum.class, statusTask);
                        long taskCount = (long) statusTaskCount.get("taskCount");
                        return new StatusTaskCountsResponse(EnumUtils.instance(statusEnum), taskCount);
                    } else {
                        long taskCount = (long) statusTaskCount.get("taskCount");
                        return new StatusTaskCountsResponse(new EnumDto("", "All"), taskCount);
                    }
                })
                .collect(Collectors.toList());
    }

    public TaskDetailResponse toDetailResponse(Task task) {

        if (task == null) return null;

        return TaskDetailResponse.builder()
                .id(task.getId())
                .statusTask(ApplicationUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .user(userConverter.toIdAndFullnameUserResponse(task.getUser()))
                .createdDate(DateUtils.formatDate(task.getCreatedDate()))
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueDate(DateUtils.formatDate(task.getDueDate()))
                .closeDate(DateUtils.formatDate(task.getCloseDate()))
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .content(task.getContent())
                .comments(commentTaskConverter.toListResponse(task.getComments()))
                .build();
    }

    public Task toEntity(TaskUpdateRequest taskUpdateRequest) {

        String id = taskUpdateRequest.getId();
        String action = taskUpdateRequest.getAction();
        Integer progress = taskUpdateRequest.getProgress();
        Date dueDate = taskUpdateRequest.getDueDate();

        Task task = taskMapper.findById(id);

        Date startDate = task.getStartDate();
        if (action.equals(ActionChangeStatusTaskEnum.OPEN.toString()) && startDate == null) {
            startDate = new Date();
        }

        StatusTaskEnum statusTaskCurrent = task.getStatusTask();
        StatusTaskEnum statusTaskNew = ApplicationUtils.getNextStatusTaskEnum(statusTaskCurrent, action);

        Date closeDate = task.getCloseDate();

        if (task.getStatusTask().equals(StatusTaskEnum.OPENED) || task.getStatusTask().equals(StatusTaskEnum.REOPENED)) {
            if (progress == 100) {
                statusTaskNew = StatusTaskEnum.CLOSED;
                closeDate = new Date();
            }
            if (statusTaskNew.equals(StatusTaskEnum.CLOSED)) {
                progress = 100;
                closeDate = new Date();
            }
        } else if (!task.getStatusTask().equals(StatusTaskEnum.REOPENED) && statusTaskNew.equals(StatusTaskEnum.REOPENED)) {
            progress = 0;
            closeDate = null;
        }

        return Task.builder()
                .id(id)
                .user(userMapper.findById(taskUpdateRequest.getUserId()))
                .statusTask(statusTaskNew)
                .title(taskUpdateRequest.getTitle())
                .content(taskUpdateRequest.getContent())
                .startDate(startDate)
                .priority(EnumUtils.getEnumFromValue(PriorityTaskEnum.class, taskUpdateRequest.getPriority()))
                .progress(progress)
                .closeDate(closeDate)
                .dueDate(dueDate)
                .build();
    }
}