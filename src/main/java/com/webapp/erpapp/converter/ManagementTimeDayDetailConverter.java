package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.ManagementTimeDayDetail;
import com.webapp.erpapp.enums.managementtime_daydetail.DayDetailCodeEnum;
import com.webapp.erpapp.mapper.ManagementTimeDayDetailMapper;
import com.webapp.erpapp.mapper.ManagementTimeDayMapper;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.webapp.erpapp.model.response.managementtimedetail.DayDetailResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ManagementTimeDayDetailConverter {

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private ManagementTimeDayDetailMapper managementTimeDayDetailMapper;

    public ManagementTimeDayDetail toEntity(DayDetailCreateRequest dayDetailCreateRequest) {

        String sixToTwelvePM = null;
        String twelveToSixPM = null;
        String sixToTwelveAM = null;

        if (dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_PM.toString())) {
            sixToTwelvePM = String.join(",", dayDetailCreateRequest.getData());
        } else if(dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.TWELVE_TO_SIX_PM.toString())){
            twelveToSixPM = String.join(",", dayDetailCreateRequest.getData());
        } else if(dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_AM.toString())){
            sixToTwelveAM = String.join(",", dayDetailCreateRequest.getData());
        }

        return ManagementTimeDayDetail.builder()
                .id(ApplicationUtils.generateId())
                .managementTimeDay(managementTimeDayMapper.findById(dayDetailCreateRequest.getDayId()))
                .sixToTwelvePM(sixToTwelvePM)
                .twelveToSixPM(twelveToSixPM)
                .sixToTwelveAM(sixToTwelveAM)
                .build();
    }

    public ManagementTimeDayDetail toUpdateEntity(DayDetailUpdateRequest dayDetailUpdateRequest) {

        ManagementTimeDayDetail managementTimeDayDetail = managementTimeDayDetailMapper.findByManagementTimeDayId(dayDetailUpdateRequest.getDayId());
        if (dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_PM.toString())) {
            managementTimeDayDetail.setSixToTwelvePM(String.join(",", dayDetailUpdateRequest.getData()));
        } else if(dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.TWELVE_TO_SIX_PM.toString())){
            managementTimeDayDetail.setTwelveToSixPM(String.join(",", dayDetailUpdateRequest.getData()));
        } else if(dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_AM.toString())){
            managementTimeDayDetail.setSixToTwelveAM(String.join(",", dayDetailUpdateRequest.getData()));
        }
        return managementTimeDayDetail;
    }

    public DayDetailResponse toResponse(ManagementTimeDayDetail managementTimeDayDetail, String code) {

        String data = null;

        if (code.equals(DayDetailCodeEnum.SIX_TO_TWELVE_PM.toString())) {
            data = managementTimeDayDetail.getSixToTwelvePM();
        } else if (code.equals(DayDetailCodeEnum.TWELVE_TO_SIX_PM.toString())) {
            data = managementTimeDayDetail.getTwelveToSixPM();
        } else data = managementTimeDayDetail.getSixToTwelveAM();
            return DayDetailResponse.builder()
                    .id(managementTimeDayDetail.getId())
                    .data(data.split(","))
                    .build();
        }
}