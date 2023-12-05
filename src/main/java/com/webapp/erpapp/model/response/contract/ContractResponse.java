
package com.webapp.erpapp.model.response.contract;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ContractResponse {
    private String id;
    private String basicSalary;
    private String allowance;
    private String contract;
    private String createdDate;
    private String insurance;
    private List<ContractResponse> historyContract;
}
