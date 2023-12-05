package com.webapp.erpapp.model.response.setting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingAllowanceResponse {
    private Integer maxFileSize;
    private String listTypeFile;
    private String listTypeImage;
    private Integer uploadFileLimit;
}
