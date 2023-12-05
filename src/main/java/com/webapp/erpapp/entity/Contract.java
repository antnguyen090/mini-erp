package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.contract.StatusContractEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Contract {

    private String id;
    private String basicSalary;
    private String allowance;
    private String contract;
    private Date createdDate;
    private User user;
    private String insurance;
    private StatusContractEnum status;
    private Contract parentContract;
    private List<Contract> historyContract;
}