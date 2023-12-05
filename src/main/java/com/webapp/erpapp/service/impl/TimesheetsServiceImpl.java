package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.TimesheetsConverter;
import com.webapp.erpapp.entity.Timesheets;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.TimesheetsMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.response.timesheets.TimesheetsResponse;
import com.webapp.erpapp.service.TimesheetsService;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TimesheetsServiceImpl implements TimesheetsService {

    @Autowired
    private TimesheetsMapper timesheetsMapper;

    @Autowired
    private TimesheetsConverter timesheetsConverter;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<TimesheetsResponse> findAllByUserAndMonthYear(String userId, int year, int month) {
        return timesheetsMapper.findAllByUserAndMonthYear(userId, year, month).stream()
            .map(t -> timesheetsConverter.toResponse(t)).collect(Collectors.toList());
    }

    @Override
    public List<Map<String, ?>> getTotalWorkDayByYear(String userID) {
        return timesheetsMapper.totalWorkingDateByYear(userID);
    }

    @Override
    public List<Map<String, ?>> getTotalWorkDayByMonth(String userID, String year) {
        return timesheetsMapper.totalWorkingDateByMonth(userID, year);
    }

    @Override
    public boolean readExcelFile(MultipartFile file) {

        boolean isFoundUserByTimesheetsCode = true;

        try {
            InputStream fis = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(fis);
            Sheet sheet = workbook.getSheetAt(0);

            List<Timesheets> timesheetsList = new ArrayList<>();

            String cellMonthYear = sheet.getRow(1).getCell(20).getStringCellValue().trim();
            String monthYearFormat = cellMonthYear.substring(0, cellMonthYear.indexOf('-', cellMonthYear.indexOf('-') + 1));

            int rowIndex = 0;
            while (rowIndex < sheet.getPhysicalNumberOfRows()) {
                Row row = sheet.getRow(rowIndex);
                Cell cellShSoftVina = row.getCell(2, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
                if (cellShSoftVina != null && cellShSoftVina.getCellType() == CellType.STRING && "SH SOFT VINA".equals(cellShSoftVina.getStringCellValue())) {

                    Cell cellTimesheetsCode = row.getCell(8);
                    String timesheetsCode = String.valueOf((int)cellTimesheetsCode.getNumericCellValue());

                    if(userMapper.findByTimesheetsCode(timesheetsCode) == null){
                        isFoundUserByTimesheetsCode= false;
                        throw new NotFoundException("Some user not exist in system");
                    }


                    int[] indexCell ={2,6,7,8,11,16,18,21,24,25};
                    while(true){

                        int rowIndexDay = ++rowIndex;
                        int rowIndexContent = ++rowIndex;
                        for(int iCell: indexCell){
                            Row rowDay = sheet.getRow(rowIndexDay);
                            Cell cellDay = rowDay.getCell(iCell);
                            String day = cellDay.getStringCellValue().trim();

                            Row rowContent = sheet.getRow(rowIndexContent);
                            Cell cellContent = rowContent.getCell(iCell);
                            String content = null;
                            if (cellContent.getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(cellContent)) {
                                Date date = DateUtil.getJavaDate(cellContent.getNumericCellValue());
                                content = DateUtils.formatHHMM(date);
                            } else{
                                content =  cellContent.getStringCellValue();
                            }

                            if(!StringUtils.isBlank(content)){
                                Timesheets timesheets = Timesheets.builder()
                                        .workDate(DateUtils.toDate(monthYearFormat + "-" + day.substring(0, day.indexOf(' '))))
                                        .content(content)
                                        .timesheetsCode(timesheetsCode).build();
                                timesheetsList.add(timesheets);
                            }
                        }

                        if(sheet.getRow(rowIndex + 1).getCell(2) == null){
                            rowIndex++;
                            break;
                        } else if (sheet.getRow(rowIndex + 1).getCell(2).getStringCellValue().equals("SH SOFT VINA")){
                            break;
                        }
                    }
                }
                rowIndex++;
            }

            workbook.close();
            fis.close();

            try{
                timesheetsMapper.insertTimesheetsBatch(timesheetsList);
            } catch (Exception e){
                return false;
            }

            return true;
        } catch (Exception e) {
            if (!isFoundUserByTimesheetsCode) throw new NotFoundException("Some user not exist in system");
            return false;
        }
    }
}
