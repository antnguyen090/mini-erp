package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.SettingConverter;
import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.model.request.setting.SettingUpdateRequest;
import com.webapp.erpapp.model.response.setting.SettingResponse;
import com.webapp.erpapp.service.SettingService;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SettingServiceImpl implements SettingService {

    @Autowired
    private SettingMapper settingMapper;

    @Autowired
    private SettingConverter settingConverter;

    @Override
    public List<SettingResponse> findAll() {
        return settingMapper.findAll().stream().map(setting -> settingConverter.toResponse(setting)).collect(Collectors.toList());
    }

    @Override
    public SettingResponse findById(String id) {
        return settingConverter.toResponse(settingMapper.findById(id));
    }

    @Override
    public int updateSetting(SettingUpdateRequest[] settingUpdateRequests) {

        int updatedCount = 0;

        for (SettingUpdateRequest settingUpdateRequest : settingUpdateRequests) {
            if (settingMapper.findByCode(settingUpdateRequest.getCode()) == null)
                throw new NotFoundException(MessageErrorUtils.notFound("code"));

            Setting setting = settingConverter.toEntity(settingUpdateRequest);
            try {
                int result = settingMapper.updateSetting(setting);
                if (result > 0) {
                    updatedCount++;
                }
            } catch (Exception e) {}
        }

        return updatedCount;
    }

    @Override
    public SettingResponse findByCode(String code) {
        return settingConverter.toResponse(settingMapper.findByCode(code));
    }
}
