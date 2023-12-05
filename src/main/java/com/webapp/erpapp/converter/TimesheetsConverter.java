package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.Timesheets;
import com.webapp.erpapp.model.response.timesheets.TimesheetsResponse;
import com.webapp.erpapp.utils.DateUtils;
import org.springframework.stereotype.Component;

@Component
public class TimesheetsConverter {
    public TimesheetsResponse toResponse(Timesheets timesheets) {

        return TimesheetsResponse.builder()
                .id(timesheets.getId())
                .workDate(DateUtils.formatDate(timesheets.getWorkDate()))
                .content(timesheets.getContent())
                .timesheetsCode(timesheets.getTimesheetsCode())
                .build();
    }
}