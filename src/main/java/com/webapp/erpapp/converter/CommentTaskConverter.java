package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.CommentTask;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.mapper.CommentTaskMapper;
import com.webapp.erpapp.mapper.TaskMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.commenttask.CreateCommentTaskRequest;
import com.webapp.erpapp.model.request.commenttask.UpdateCommentTaskRequest;
import com.webapp.erpapp.model.response.commenttask.CommentTaskResponse;
import com.webapp.erpapp.security.Principal;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class CommentTaskConverter {

    @Autowired
    CommentTaskMapper commentTaskMapper;

    @Autowired
    TaskMapper taskMapper;

    @Autowired
    UserMapper userMapper;

    public CommentTaskResponse toResponse(CommentTask commentTask) {

        if(commentTask == null) return null;

        User user = commentTask.getUser();
        String avatarUser = null, fullnameUser = null;
        if(commentTask.getUser() != null){
            avatarUser = FileUtils.getPathUpload(User.class, user.getAvatar());
            fullnameUser = user.getFullname();
        }

        return CommentTaskResponse.builder()
                .id(commentTask.getId())
                .title(commentTask.getTitle())
                .content(commentTask.getContent())
                .files(StringUtils.splitPathFile(CommentTask.class, commentTask.getFiles(), ","))
                .createdDate(DateUtils.formatDateTime(commentTask.getCreatedDate()))
                .modifiedBy(commentTask.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentTask.getModifiedDate()))
                .parentId(commentTask.getParentComment() != null?commentTask.getParentComment().getId(): null)
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .idUser(commentTask.getUser().getId())
                .childComments(toListResponse(commentTask.getChildComments()))
                .build();
    }

    public CommentTask toEntity(CreateCommentTaskRequest createCommentTaskRequest, List<String> listFileNameSaveFileSuccess) {
        String files = null;
        if(!listFileNameSaveFileSuccess.isEmpty()){
            files = String.join(",", listFileNameSaveFileSuccess);
        }
        return CommentTask.builder()
                .id(ApplicationUtils.generateId())
                .title(createCommentTaskRequest.getTitle())
                .content(createCommentTaskRequest.getContent())
                .files(files)
                .createdDate(new Date())
                .task(taskMapper.findById(createCommentTaskRequest.getTaskId()))
                .user(userMapper.findById(createCommentTaskRequest.getUserId()))
                .parentComment(commentTaskMapper.findById(createCommentTaskRequest.getParentId()))
                .build();
    }

    public CommentTask toEntity(UpdateCommentTaskRequest updateCommentTaskRequest, String newFilesToDB) {

        CommentTask commentTask = commentTaskMapper.findById(updateCommentTaskRequest.getId());
        commentTask.setTitle(updateCommentTaskRequest.getTitle());
        commentTask.setContent(updateCommentTaskRequest.getContent());
        commentTask.setFiles(newFilesToDB);
        commentTask.setModifiedDate(new Date());
        commentTask.setModifiedBy(Principal.getUserCurrent().getFullname());
        return commentTask;
    }

    public List<CommentTaskResponse> toListResponse(List<CommentTask> commentTasks) {
        if(commentTasks == null) return null;
        return commentTasks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }
}
