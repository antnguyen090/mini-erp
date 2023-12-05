package com.webapp.erpapp.model.request.commenttask;

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
public class CreateCommentTaskRequest {

    @NotBlank(message = "Field taskId is not filled")
    private String taskId;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    private MultipartFile[] fileList;
    private String parentId;

    @NotBlank(message = "Field userId is not filled")
    private String userId;
}