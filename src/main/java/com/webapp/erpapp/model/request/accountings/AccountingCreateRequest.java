package com.webapp.erpapp.model.request.accountings;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountingCreateRequest {

    @NotNull(message = "Field is not filled")
    private Long expense;

    @NotBlank(message = "Field is not filled")
    private String userId;

    private MultipartFile[] bill;

    @NotBlank(message = "Field is not filled")
    private String title;

    private String note;

    @NotBlank(message = "Field is not filled")
    private String payDate;
}

