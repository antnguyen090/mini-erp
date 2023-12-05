package com.webapp.erpapp.model.response.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class IdAndFullnameUserResponse {
    private String id;
    private String fullname;
}

