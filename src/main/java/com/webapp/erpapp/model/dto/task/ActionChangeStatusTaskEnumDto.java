package com.webapp.erpapp.model.dto.task;

import com.webapp.erpapp.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActionChangeStatusTaskEnumDto {
    private String code;
    private String name;
    private EnumDto[] actions;
}
