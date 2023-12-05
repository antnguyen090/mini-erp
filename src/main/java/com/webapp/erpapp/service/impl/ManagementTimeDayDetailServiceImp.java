package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.ManagementTimeDayDetailConverter;
import com.webapp.erpapp.entity.ManagementTimeDayDetail;
import com.webapp.erpapp.mapper.ManagementTimeDayDetailMapper;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.webapp.erpapp.model.response.managementtimedetail.DayDetailResponse;
import com.webapp.erpapp.service.ManagementTimeDayDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagementTimeDayDetailServiceImp implements ManagementTimeDayDetailService {

    @Autowired
    ManagementTimeDayDetailConverter managementTimeDayDetailConverter;

    @Autowired
    ManagementTimeDayDetailMapper managementTimeDayDetailMapper;

    @Override
    public int createTimeDayDetail(DayDetailCreateRequest dayDetailCreateRequest) {

        ManagementTimeDayDetail dayDetail = managementTimeDayDetailConverter.toEntity(dayDetailCreateRequest);

        try{
            managementTimeDayDetailMapper.createTimeDayDetail(dayDetail);
        } catch (Exception e){
            return 0;
        }

        return 1;
    }

    @Override
    public int updateTimeDayDetail(DayDetailUpdateRequest dayDetailUpdateRequest) {
        try{
            ManagementTimeDayDetail dayDetail = managementTimeDayDetailConverter.toUpdateEntity(dayDetailUpdateRequest);
            managementTimeDayDetailMapper.updateTimeDayDetail(dayDetail);
        } catch (Exception e){
            return 0;
        }
        return 1;
    }

    @Override
    public DayDetailResponse findByManagementTimeDayId(String dayId, String code) {
        try{
            ManagementTimeDayDetail managementTimeDayDetail = managementTimeDayDetailMapper.findByManagementTimeDayId(dayId);
            return managementTimeDayDetailConverter.toResponse(managementTimeDayDetail, code);
        }catch(Exception e){
            return new DayDetailResponse();
        }
    }

    @Override
    public boolean findByManagementTimeDayId(String dayId) {

        ManagementTimeDayDetail managementTimeDayDetail = managementTimeDayDetailMapper.findByManagementTimeDayId(dayId);
        if(managementTimeDayDetail == null) return false;
        return true;
    }
}
