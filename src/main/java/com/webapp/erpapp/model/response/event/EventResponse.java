package com.webapp.erpapp.model.response.event;

import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.model.response.user.IdAndFullnameUserResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventResponse {
    private String id;
    private String startDate;
    private String endDate;
    private String title;
    private String content;
    private IdAndFullnameUserResponse user;
    private EnumDto type;
    private String categoryPush;
}
