package com.webapp.erpapp.model.request.setting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingUpdateRequest {

    @NotBlank(message = "Field code is not filled")
    private String code;
    private String imageType;
    private String fileType;
    @Min(value=1, message = "Min limit is 1")
    private Integer fileLimit;
    @Min(value=1, message = "Min size is 0")
    private Integer fileSize;
}