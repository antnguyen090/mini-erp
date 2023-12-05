
package com.webapp.erpapp.model.response.user;

import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.model.response.contract.ContractResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDetailResponse{
    private String id;
    private String fullname;
    private String dateOfBirth;
    private String address;
    private String phone;
    private String emergencyPhone;
    private String avatar;
    private EnumDto type;
    private EnumDto department;
    private String email; // user_id
    private EnumDto role;
    private EnumDto position;
    private String resume;
    private String atm;
    private String timesheetsCode;
    private List<ContractResponse> contracts;
    private String createdDate;
    private EnumDto gender;
}