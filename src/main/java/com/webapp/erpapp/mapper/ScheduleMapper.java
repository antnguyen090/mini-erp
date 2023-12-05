package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.Task;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Mapper
public interface ScheduleMapper {
    List<Task> getScheduleDetail(String userId, Date startDate, Date endDate);
    List<Task> getScheduleDetailByMonth(String userId, LocalDate previousMonth,LocalDate nextMonth);
}
