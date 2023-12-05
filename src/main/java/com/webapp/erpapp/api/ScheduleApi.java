package com.webapp.erpapp.api;


import com.webapp.erpapp.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/schedules")
public class ScheduleApi {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> getScheduleDetail(@PathVariable String userId,
                                               @RequestParam(name = "monthly",required = false) String monthly) {
        return new ResponseEntity<>(scheduleService.getScheduleDetail(userId, monthly), HttpStatus.OK);
    }
}

