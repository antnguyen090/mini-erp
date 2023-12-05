package com.webapp.erpapp.model.request.notification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateNotificationRequest {

    private String userId;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    private MultipartFile[] files;
}
