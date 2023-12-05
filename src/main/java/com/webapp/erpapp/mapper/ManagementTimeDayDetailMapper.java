package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.ManagementTimeDayDetail;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManagementTimeDayDetailMapper {
    int createTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
    int updateTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
    ManagementTimeDayDetail findByManagementTimeDayId(String dayId);
}
