package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.TaskConverter;
import com.webapp.erpapp.entity.Task;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.mapper.ScheduleMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.response.schedule.ScheduleListResponse;
import com.webapp.erpapp.model.response.user.IdAndFullnameUserResponse;
import com.webapp.erpapp.service.ScheduleService;
import com.webapp.erpapp.service.UserService;
import com.webapp.erpapp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {

    @Autowired
    private ScheduleMapper scheduleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private TaskConverter taskConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public ScheduleListResponse getScheduleDetail(String userId, String monthly) {
        applicationUtils.checkUserAllow(userId);
        String firstDayOfMonth = monthly + "-01";
        LocalDate currentDate = LocalDate.parse(firstDayOfMonth);
        LocalDate previousDate = currentDate.minusMonths(1);
        LocalDate lastDayOfNextMonth = currentDate.plusMonths(1).with(TemporalAdjusters.lastDayOfMonth());
        List<Task> tasks = scheduleMapper.getScheduleDetailByMonth(userId, previousDate, lastDayOfNextMonth);
        List<User> users = userMapper.getUserBirthday(previousDate,lastDayOfNextMonth,currentDate);
        List<ScheduleListResponse.TaskResponse> list = taskConverter.toListTaskResponseOfSchedule(tasks,users,firstDayOfMonth);
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        return new ScheduleListResponse(list, user);
    }
}

