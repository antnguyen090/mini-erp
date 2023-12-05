package com.webapp.erpapp.model.request.user;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRegisterRequest {

    @NotBlank(message =  "Field fullname is not filled")
    private String fullname;

    @NotBlank(message = "Field UserID is not filled")
    @Email(message = "Invalid UserID")
    private String email;

    @NotBlank(message = "Field password is not filled")
    @Size(min = 6, message = "Password must have at least 6 characters and include Letters, numbers and special characters")
    @Pattern(
            regexp = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).*$",
            message = "Password must have at least 6 characters and include Letters, numbers and special characters"
    )
    private String password;

    @NotBlank(message = "Field confirmPassword is not filled")
    @Size(min = 6, message = "Password must have at least 6 characters and include letters, numbers and special characters")
    @Pattern(
            regexp = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).*$",
            message = "confirmPassword must have at least 6 characters and include letters, numbers and special characters"
    )
    private String confirmPassword;
}