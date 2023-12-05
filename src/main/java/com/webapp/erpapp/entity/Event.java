package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.event.EventTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Event {
    private String id;
    private Date createdDate;
    private String startDate;
    private String endDate;
    private String title;
    private String content;
    private User user;
    private EventTypeEnum type;
}
