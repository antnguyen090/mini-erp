package com.webapp.erpapp.model.response.commenttask;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentTaskResponse {
    private String id;
    private String title;
    private String content;
    private String[] files;
    private String createdDate;
    private String modifiedBy;
    private String modifiedDate;
    private String fullnameUser;
    private String avatarUser;
    private String idUser;
    private String parentId;
    private List<CommentTaskResponse> childComments;
}
