package com.webapp.erpapp.model.request.todo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoManagementTimeRequest {
    private Date day;
    private String target;
    private String userId;
    private String codeCategory;
    private String codeManagement;
}
