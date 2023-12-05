package com.webapp.erpapp.utils;

import com.webapp.erpapp.constant.SettingConstant;
import com.webapp.erpapp.entity.*;
import com.webapp.erpapp.entity.*;
import com.webapp.erpapp.enums.task.ActionChangeStatusTaskEnum;
import com.webapp.erpapp.enums.task.StatusTaskEnum;
import com.webapp.erpapp.enums.user.RoleEnum;
import com.webapp.erpapp.exception.FileLimitNotAllowException;
import com.webapp.erpapp.exception.FileSizeNotAllowException;
import com.webapp.erpapp.exception.FileTypeNotAllowException;
import com.webapp.erpapp.exception.UnauthorizedException;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.model.dto.task.ActionChangeStatusTaskEnumDto;
import com.webapp.erpapp.model.dto.EnumDto;
import com.webapp.erpapp.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@Component
public class ApplicationUtils {

    @Autowired
    private SettingMapper settingMapper;

    public static ActionChangeStatusTaskEnumDto instance(StatusTaskEnum statusTaskEnum) {
        if(statusTaskEnum != null){
            ActionChangeStatusTaskEnumDto dto = new ActionChangeStatusTaskEnumDto();
            dto.setCode(statusTaskEnum.name());
            dto.setName(statusTaskEnum.getValue());

            ActionChangeStatusTaskEnum[] actionEnums = statusTaskEnum.getActions();
            EnumDto[] actionDtos = new EnumDto[actionEnums.length];
            for (int i = 0; i < actionEnums.length; i++) {
                actionDtos[i] = EnumUtils.instance(actionEnums[i]);
            }
            dto.setActions(actionDtos);
            return dto;
        }
        return null;
    }

    public static StatusTaskEnum getNextStatusTaskEnum(StatusTaskEnum statusCurrent, String action){

        StatusTaskEnum nextStatusTask= null;

        if(StringUtils.isBlank(action)) return statusCurrent;

        switch (statusCurrent){
            case REGISTERED:
                if(action.equals(ActionChangeStatusTaskEnum.OPEN.toString())) nextStatusTask = StatusTaskEnum.OPENED;
                break;
            case OPENED:
            case REOPENED:
                if(action.equals(ActionChangeStatusTaskEnum.CLOSE.toString())) nextStatusTask = StatusTaskEnum.CLOSED;
                else if (action.equals(ActionChangeStatusTaskEnum.POSTPONE.toString())) nextStatusTask = StatusTaskEnum.POSTPONED;
                break;
            case POSTPONED:
            case CLOSED:
                if(action.equals(ActionChangeStatusTaskEnum.REOPEN.toString())) nextStatusTask = StatusTaskEnum.REOPENED;
                break;
        }
        return nextStatusTask;
    }

    public static boolean isActionValidForUpdateStatusTask(StatusTaskEnum statusCurrent, String action){

        ActionChangeStatusTaskEnum actionEnum = EnumUtils.getEnumFromValue(ActionChangeStatusTaskEnum.class, action);

        if(actionEnum == null) return true;

        ActionChangeStatusTaskEnum[] actionAllows = statusCurrent.getActions();
        for(ActionChangeStatusTaskEnum actionAllow: actionAllows){
            if(actionAllow.equals(actionEnum)) {
                return true;
            }
        }
        return false;
    }

    public static String generateId(){
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss"));
    }

    public static String generateVerifyMailCode(){
        int codeLength = 6;
        StringBuilder code = new StringBuilder();

        Random random = new Random();
        for (int i = 0; i < codeLength; i++) {
            int digit = random.nextInt(10);
            code.append(digit);
        }

        return code.toString();
    }

    private Setting getSetting(Class<?> c){
        Setting setting = null;
        if(c == User.class){
            setting = settingMapper.findByCode(SettingConstant.USER_CODE);
        } else if(c == Contract.class){
            setting = settingMapper.findByCode(SettingConstant.CONTRACT_CODE);
        } else if(c == Accounting.class){
            setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);
        } else if(c == Notification.class){
            setting = settingMapper.findByCode(SettingConstant.NOTIFICATION_CODE);
        } else if(c == CommentNotification.class){
            setting = settingMapper.findByCode(SettingConstant.NOTIFICATION_COMMENT_CODE);
        } else if(c == Task.class){
            setting = settingMapper.findByCode(SettingConstant.TASK_CODE);
        } else if(c == CommentTask.class){
            setting = settingMapper.findByCode(SettingConstant.TASK_COMMENT_CODE);
        } else if(c == Book.class){
            setting = settingMapper.findByCode(SettingConstant.BOOK);
        }
        return setting;
    }

    public void checkValidateFileAndImage(Class<?> c, MultipartFile file){

        Setting setting = getSetting(c);

        String imageTypes = setting.getImageType();
        String fileTypes = setting.getFileType();
        String imageAndFileTypes = imageTypes + "," + fileTypes;

        int fileLimit = setting.getFileSize();
        int fileSize = setting.getFileSize();

        if (!FileUtils.isAllowedFileSize(file, fileSize))
            throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize(fileSize));

        if (fileLimit < 1)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        if (!FileUtils.isAllowedFileType(file, imageAndFileTypes))
            throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(imageAndFileTypes));
    }

    public void checkValidateFileAndImage(Class<?> c, MultipartFile[] files){

        Setting setting = getSetting(c);

        int fileLimit = setting.getFileSize();

        if(fileLimit<files.length)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        for(MultipartFile file: files){
            checkValidateFileAndImage(c, file);
        }
    }

    public void checkValidateImage(Class<?> c, MultipartFile file){

        Setting setting = getSetting(c);

        String imageTypes = setting.getImageType();
        int fileLimit = setting.getFileLimit();
        int fileSize = setting.getFileSize();

        if (!FileUtils.isAllowedFileSize(file, fileSize))
            throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize(fileSize));

        if (fileLimit < 1)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        if (!FileUtils.isAllowedFileType(file, imageTypes))
            throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(imageTypes));
    }

    public void checkValidateImage(Class<?> c, MultipartFile[] files){

        if(files!=null){
            Setting setting = getSetting(c);

            int fileLimit = setting.getFileLimit();
            if(fileLimit<files.length)
                throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

            for(MultipartFile file: files){
                checkValidateImage(c, file);
            }
        }
    }

    public void checkValidateFile(Class<?> c, MultipartFile file){

        if(file!=null){
            Setting setting = getSetting(c);

            String fileTypes = setting.getFileType();
            int fileLimit = setting.getFileLimit();
            int fileSize = setting.getFileSize();

            if (!FileUtils.isAllowedFileSize(file, fileSize))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize(fileSize));

            if (fileLimit < 1)
                throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

            if (!FileUtils.isAllowedFileType(file, fileTypes))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(fileTypes));
        }
    }

    public void checkValidateFile(Class<?> c, MultipartFile[] files){

        if(files!=null){
            Setting setting = getSetting(c);

            int fileLimit = setting.getFileLimit();
            if(fileLimit<files.length)
                throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

            for(MultipartFile file: files){
                checkValidateFile(c, file);
            }
        }
    }

    public void checkUserAllow(){
        User userCurrent = Principal.getUserCurrent();
        RoleEnum roleCurrent = userCurrent.getRole();

        if(!(roleCurrent.equals(RoleEnum.OWNER) || roleCurrent.equals(RoleEnum.MANAGER))){
            throw new UnauthorizedException(MessageErrorUtils.unauthorized());
        }
    }

    public void checkUserAllow(String idUser){
        User userCurrent = Principal.getUserCurrent();
        RoleEnum roleCurrent = userCurrent.getRole();
        String idUserCurrent = userCurrent.getId();

        if(!(roleCurrent.equals(RoleEnum.OWNER) || roleCurrent.equals(RoleEnum.MANAGER) || idUserCurrent.equals(idUser))){
            throw new UnauthorizedException(MessageErrorUtils.unauthorized());
        }
    }

    public boolean checkUserWebSocketAllow(User user){
        if(!(user.getRole().equals(RoleEnum.OWNER) || user.getRole().equals(RoleEnum.MANAGER))){
            return false;
        }
        return true;
    }

    public boolean checkUserWebSocketAllow(User user, String userId){
        if(!(user.getRole().equals(RoleEnum.OWNER) || user.getRole().equals(RoleEnum.MANAGER) || userId.equals(user.getId()))){
            return false;
        }
        return true;
    }
}