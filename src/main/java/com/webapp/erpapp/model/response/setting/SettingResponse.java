package com.webapp.erpapp.model.response.setting;
import com.webapp.erpapp.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingResponse {

    private String id;
    private EnumDto code;
    private String imageType;
    private String fileType;
    private Integer fileLimit;
    private Integer fileSize;
}
