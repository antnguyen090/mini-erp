package com.webapp.erpapp.service;

import com.webapp.erpapp.model.response.timesheets.TimesheetsResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface TimesheetsService {
    List<TimesheetsResponse> findAllByUserAndMonthYear(String userId, int year, int month);
    List<Map<String, ?>> getTotalWorkDayByYear(String userID);
    List<Map<String, ?>> getTotalWorkDayByMonth(String userID, String year);
    boolean readExcelFile(MultipartFile file);
}