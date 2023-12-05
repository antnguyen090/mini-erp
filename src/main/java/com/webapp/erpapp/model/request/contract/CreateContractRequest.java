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
public class CreateContractRequest {

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    @NotBlank(message = "Field basicSalary is not filled")
    private String basicSalary;

    @NotBlank(message = "Field allowance is not filled")
    private String allowance;

    @NotBlank(message = "Field insurance is not filled")
    private String insurance;

    private String parentId;
    private MultipartFile contract;
}