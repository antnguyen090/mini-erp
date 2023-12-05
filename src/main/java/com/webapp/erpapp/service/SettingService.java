package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.setting.SettingUpdateRequest;
import com.webapp.erpapp.model.response.setting.SettingResponse;

import java.util.List;

public interface SettingService {
    List<SettingResponse> findAll();
    SettingResponse findById(String id);
    int updateSetting(SettingUpdateRequest[] settingUpdateRequests);
    SettingResponse findByCode(String code);
}