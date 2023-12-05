package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.ManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManagementTimeDayMapper {

    int createDayInfo(ManagementTimeDay day);
    int updateDayInfo(ManagementTimeDay day);
    ManagementTimeDay findById(String id);
    ManagementTimeDay findByDay(String userId, String day);
    List<ManagementTimeDay> findAllByMonthYear(String userId,
                                               String startDate,
                                               String endDate);
}