package com.webapp.erpapp.model.request.commentnotification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateCommentNotificationRequest {
    @NotBlank(message = "Field content is not filled")
    private String content;
    @NotBlank(message = "Field id is not filled")
    private String id;

    private String userId;
}
