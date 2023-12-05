package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.setting.SettingUpdateRequest;
import com.webapp.erpapp.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/settings")
public class SettingApi {

    @Autowired
    private SettingService settingService;

    @GetMapping
    public ResponseEntity<?> findAll() {
        return ResponseEntity.ok(settingService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(settingService.findById(id));
    }

    @GetMapping("/code")
    public ResponseEntity<?> findByCode(@RequestParam("code") String code) {
        return ResponseEntity.ok(settingService.findByCode(code));
    }

    @PutMapping
    public ResponseEntity<?> updateSetting(@RequestBody SettingUpdateRequest[] settingUpdateRequest) {
        return ResponseEntity.ok(settingService.updateSetting(settingUpdateRequest));
    }
}
