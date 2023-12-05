package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.constant.CommentTaskConstant;
import com.webapp.erpapp.constant.SettingConstant;
import com.webapp.erpapp.converter.CommentTaskConverter;
import com.webapp.erpapp.entity.CommentTask;
import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.entity.Task;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.exception.FileTooLimitedException;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.CommentTaskMapper;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.mapper.TaskMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.commenttask.CreateCommentTaskRequest;
import com.webapp.erpapp.model.request.commenttask.UpdateCommentTaskRequest;
import com.webapp.erpapp.model.response.commenttask.CommentTaskResponse;
import com.webapp.erpapp.service.CommentTaskService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.MessageErrorUtils;
import com.webapp.erpapp.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class CommentTaskImpl implements CommentTaskService {

    @Autowired
    CommentTaskMapper commentTaskMapper;

    @Autowired
    CommentTaskConverter commentTaskConverter;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

    @Override
    public CommentTaskResponse findById(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        return commentTaskConverter.toResponse(commentTask);
    }

    @Override
    public CommentTaskResponse createCommentTask(CreateCommentTaskRequest createCommentTaskRequest) {

        String taskId = createCommentTaskRequest.getTaskId();
        Task task = taskMapper.findById(taskId);
        if (task==null) throw new NotFoundException(MessageErrorUtils.notFound("taskID"));

        String userID = createCommentTaskRequest.getUserId();
        User user = userMapper.findById(userID);
        if (user==null) throw new NotFoundException(MessageErrorUtils.notFound("userID"));

        String parentId = createCommentTaskRequest.getParentId();
        CommentTask commentTask = null;
        if (parentId!=null){
            commentTask = commentTaskMapper.findById(parentId);
            if (commentTask==null) throw new NotFoundException(MessageErrorUtils.notFound("parentId"));
        }

        MultipartFile[] fileList = createCommentTaskRequest.getFileList();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (fileList!= null){
            applicationUtils.checkValidateFile(CommentTask.class, fileList);

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, fileList);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            CommentTask ct = commentTaskConverter.toEntity(createCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                commentTaskMapper.createCommentTask(ct);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, ct.getFiles());
                return null;
            }
        }
        return null;
    }

    @Override
    public CommentTaskResponse updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest) {
        CommentTask commentTask = commentTaskMapper.findById(updateCommentTaskRequest.getId());
        if(commentTask == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile[] newFiles = updateCommentTaskRequest.getNewFiles();

        Setting setting = settingMapper.findByCode(SettingConstant.TASK_COMMENT_CODE);

        String remainFiles = updateCommentTaskRequest.getRemainFiles();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = new ArrayList<>();

        if (newFiles!= null){

            applicationUtils.checkValidateFile(CommentTask.class, newFiles);

            if(!StringUtils.isBlank(remainFiles)){
                if((remainFiles.split(",").length + newFiles.length) > setting.getFileLimit()) {
                    throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
                }
            } else if(newFiles.length > setting.getFileLimit()){
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, newFiles);
        }

        if(listFileNameSaveFileSuccess != null){
            try{
                String newFilesToDB = null;
                if(StringUtils.isBlank(remainFiles)){
                   newFilesToDB =  String.join(",", listFileNameSaveFileSuccess);
                } else{
                    if(!listFileNameSaveFileSuccess.isEmpty()){
                        newFilesToDB = remainFiles + "," + String.join(",", listFileNameSaveFileSuccess);
                    } else newFilesToDB = remainFiles;
                }

                CommentTask ct= commentTaskConverter.toEntity(updateCommentTaskRequest, newFilesToDB);
                commentTaskMapper.updateCommentTask(ct);
                String deleteFiles = StringUtils.getDifference(commentTask.getFiles(), remainFiles);
                FileUtils.deleteMultipleFilesToServer(request, dir, deleteFiles);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, String.join(",", listFileNameSaveFileSuccess));
                return null;
            }
        }
        return null;
    }

    @Override
    public int deleteCommentTask(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        if(commentTask == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        try {
            commentTaskMapper.deleteById(id);
            String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
            FileUtils.deleteMultipleFilesToServer(request, dir, commentTask.getFiles());
            return 1;
        } catch (Exception e){
        }
        return 0;
    }
}
