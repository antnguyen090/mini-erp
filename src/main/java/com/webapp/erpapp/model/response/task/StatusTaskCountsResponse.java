package com.webapp.erpapp.model.response.task;

import com.webapp.erpapp.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StatusTaskCountsResponse {
    private EnumDto statusTask;
    private long taskCount;
}
