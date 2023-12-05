package com.webapp.erpapp.service;


import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.webapp.erpapp.model.response.managementtimedetail.DayDetailResponse;

public interface ManagementTimeDayDetailService {
    int createTimeDayDetail(DayDetailCreateRequest dayDetailCreateRequest);
    int updateTimeDayDetail(DayDetailUpdateRequest dayDetailUpdateRequest);
    DayDetailResponse findByManagementTimeDayId(String id, String code);
    boolean findByManagementTimeDayId(String id);
}
