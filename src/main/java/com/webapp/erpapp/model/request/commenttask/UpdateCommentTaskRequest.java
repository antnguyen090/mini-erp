package com.webapp.erpapp.model.request.commenttask;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UpdateCommentTaskRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field title is not filled")
    private String title;

    @NotBlank(message = "Field content is not filled")
    private String content;

    private String remainFiles;

    private MultipartFile[] newFiles;
}
