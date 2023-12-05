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
public class CreateCommentNotificationRequest {

    @NotBlank(message = "Field notificationId is not filled")
    private String notificationId;

    @NotBlank(message = "Field content is not filled")
    private String content;

    private String parentId;

    private String userId;
}


