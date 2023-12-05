package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;

@Mapper
public interface WeeklyManagementTimeDayMapper {

    WeeklyManagementTimeDay findByStartDateAndEndDateOfUser(String userId,
                                                            LocalDate firstDayOfWeek,
                                                            LocalDate lastDayOfWeek);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findByCodeOfUser( String userId,
                                              String code);

    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findById(String id);
}
