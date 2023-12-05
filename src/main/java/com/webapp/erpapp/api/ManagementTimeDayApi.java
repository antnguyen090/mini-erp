package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.managementtime.day.DayCreateRequest;
import com.webapp.erpapp.model.request.managementtime.day.DayUpdateRequest;
import com.webapp.erpapp.service.ManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/management-time")
public class ManagementTimeDayApi {

    @Autowired
    private ManagementTimeDayService managementTimeDayService;

    @PostMapping("/day")
    public ResponseEntity<?> createDay(@RequestBody DayCreateRequest dayCreateRequest) {
        return ResponseEntity.ok(managementTimeDayService.createDay(dayCreateRequest));
    }

    @PutMapping("/day")
    public ResponseEntity<?> updateDay(@RequestBody DayUpdateRequest updateRequest) {
        return ResponseEntity.ok(managementTimeDayService.updateDay(updateRequest));
    }

    @GetMapping("/day/{id}")
    public ResponseEntity<?> getDay(@PathVariable String id) {
        return ResponseEntity.ok(managementTimeDayService.findById(id));
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getDays(@RequestParam String endDate,
                                                   @RequestParam String startDate,
                                                   @PathVariable String userId) {
        return ResponseEntity.ok(managementTimeDayService.getDays(userId, startDate, endDate));
    }
}