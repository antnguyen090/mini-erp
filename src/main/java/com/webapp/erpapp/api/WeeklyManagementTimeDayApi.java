package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.managementtime.weekly.WeeklyManagementTimeDayUpdateRequest;
import com.webapp.erpapp.service.WeeklyManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/weekly-management-time-day")
public class WeeklyManagementTimeDayApi {

    @Autowired
    private WeeklyManagementTimeDayService weeklyManagementTimeDayService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getWeekly(@PathVariable("id") String id) {
        return ResponseEntity.ok(weeklyManagementTimeDayService.getWeekly(id));
    }

    @PutMapping
    public ResponseEntity<?> updateWeekly(@RequestBody WeeklyManagementTimeDayUpdateRequest weeklyManagementTimeDayUpdateRequest) {
        return ResponseEntity.ok(weeklyManagementTimeDayService.updateWeekly(weeklyManagementTimeDayUpdateRequest));
    }
}
