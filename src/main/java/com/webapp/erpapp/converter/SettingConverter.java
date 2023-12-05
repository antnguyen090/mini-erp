package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.enums.setting.CodeSettingEnum;
import com.webapp.erpapp.model.request.setting.SettingUpdateRequest;
import com.webapp.erpapp.model.response.setting.SettingResponse;
import com.webapp.erpapp.utils.EnumUtils;
import org.springframework.stereotype.Component;

@Component
public class SettingConverter {

    public SettingResponse toResponse(Setting setting) {
        return SettingResponse.builder()
                .id(setting.getId())
                .code(EnumUtils.instance(setting.getCode()))
                .imageType(setting.getImageType())
                .fileType(setting.getFileType())
                .fileLimit(setting.getFileLimit())
                .fileSize(setting.getFileSize()).build();
    }

    public Setting toEntity(SettingUpdateRequest settingUpdateRequest) {
        return Setting.builder()
                .code(EnumUtils.getEnumFromValue(CodeSettingEnum.class, settingUpdateRequest.getCode()))
                .imageType(settingUpdateRequest.getImageType())
                .fileType(settingUpdateRequest.getFileType())
                .fileLimit(settingUpdateRequest.getFileLimit())
                .fileSize(settingUpdateRequest.getFileSize()).build();
    }
}