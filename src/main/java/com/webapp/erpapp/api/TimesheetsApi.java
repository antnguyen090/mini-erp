package com.webapp.erpapp.api;

import com.webapp.erpapp.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/timesheets")
public class TimesheetsApi {

    @Autowired
    TimesheetsService timesheetsService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> findAllByUserAndMonthYear(@RequestParam int year, @RequestParam int month,
                                     @PathVariable String userId) {
        return ResponseEntity.ok(timesheetsService.findAllByUserAndMonthYear(userId, year, month));
    }

    @GetMapping("/workingday/{userID}")
    public ResponseEntity<?> getTotalWorkingDate(@PathVariable("userID") String userID,
                                               @RequestParam(name = "year", required = false) String year) {

        List<Map<String, ?>> workingDay = null;
        if (year == null)  workingDay = timesheetsService.getTotalWorkDayByYear(userID);
        else workingDay = timesheetsService.getTotalWorkDayByMonth(userID, year);

        return ResponseEntity.ok(workingDay);
    }

    @PostMapping("/upload")
    public ResponseEntity<?> handleFileUpload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) return new ResponseEntity<>("File is empty", HttpStatus.BAD_REQUEST);

        boolean isSuccess = timesheetsService.readExcelFile(file);
        if(isSuccess) return new ResponseEntity<>(isSuccess, HttpStatus.OK);
        return new ResponseEntity<>(isSuccess, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
