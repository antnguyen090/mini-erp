package com.webapp.erpapp.model.request.contract;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateContractRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    private String basicSalary;
    private String allowance;
    private String insurance;
    private MultipartFile contract;
}