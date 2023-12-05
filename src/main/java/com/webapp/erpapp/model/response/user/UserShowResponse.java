package com.webapp.erpapp.model.response.user;

import com.webapp.erpapp.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserShowResponse {
    private String id;
    private String fullname;
    private EnumDto department;
    private String email; // user_id
    private EnumDto position;
    private String createdDate;
}
