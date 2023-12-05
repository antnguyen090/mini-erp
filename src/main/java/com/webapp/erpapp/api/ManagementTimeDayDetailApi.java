package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.webapp.erpapp.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.webapp.erpapp.service.ManagementTimeDayDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/management-time-detail")
public class ManagementTimeDayDetailApi {

    @Autowired
    ManagementTimeDayDetailService managementTimeDayDetailService;

    @GetMapping("/{id}/{code}")
    public ResponseEntity<?> findByManagementTimeDayId(@PathVariable("id") String id,@PathVariable("code") String code) {
        return ResponseEntity.ok(managementTimeDayDetailService.findByManagementTimeDayId(id, code));
    }

    @GetMapping("/exist/{id}")
    public ResponseEntity<?> isExist(@PathVariable("id") String id) {
        return ResponseEntity.ok(managementTimeDayDetailService.findByManagementTimeDayId(id));
    }

    @PostMapping
    public ResponseEntity<?> createDay(@RequestBody DayDetailCreateRequest dayDetailCreateRequest) {
        return ResponseEntity.ok(managementTimeDayDetailService.createTimeDayDetail(dayDetailCreateRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateDay(@RequestBody DayDetailUpdateRequest dayDetailUpdateRequest) {
        return ResponseEntity.ok(managementTimeDayDetailService.updateTimeDayDetail(dayDetailUpdateRequest));
    }
}
