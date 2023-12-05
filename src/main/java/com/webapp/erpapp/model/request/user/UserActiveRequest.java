package com.webapp.erpapp.model.request.user;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserActiveRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field UserID is not filled")
    @Email(message = "Invalid UserID")
    private String email;

    @NotBlank(message = "Field role is not filled")
    private String role;

    @NotBlank(message = "Field status is not filled")
    private String status;
}