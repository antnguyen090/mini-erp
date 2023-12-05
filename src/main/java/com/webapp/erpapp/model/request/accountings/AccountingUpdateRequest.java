package com.webapp.erpapp.model.request.accountings;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountingUpdateRequest {

    @NotBlank(message = "Field is not filled")
    private String id;

    @NotNull(message = "Field is not filled")
    private Long expense;

    private Long remain;

    @NotBlank(message = "Field is not filled")
    private String userId;

    private String[] oldFile;

    private MultipartFile[] bill;

    @NotBlank(message = "Field is not filled")
    private String title;

    private String note;

    @NotBlank(message = "Field is not filled")
    private String payDate;
}
