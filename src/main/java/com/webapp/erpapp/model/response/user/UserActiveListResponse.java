
package com.webapp.erpapp.model.response.user;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserActiveListResponse {
    private String id;
    private String username;
    private String email;
    private String role;
    private String status;
}
