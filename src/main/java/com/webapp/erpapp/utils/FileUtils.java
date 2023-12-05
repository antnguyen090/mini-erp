package com.webapp.erpapp.utils;

import com.webapp.erpapp.constant.*;
import com.webapp.erpapp.entity.*;
import com.webapp.erpapp.constant.*;
import com.webapp.erpapp.entity.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class FileUtils {

    private static String uploadDirectory;

    @Value("${file.uploadDir}")
    public void setUploadDirectory(String uploadDirectory) {
        FileUtils.uploadDirectory = uploadDirectory;
    }

    private static String getFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex > 0) {
            return filename.substring(lastDotIndex);
        }
        return "";
    }

    private static String removeFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex > 0) {
            return filename.substring(0, lastDotIndex);
        }
        return filename;
    }

    public static String formatNameImage(MultipartFile file) {
        if (file != null) {
            String originalFilename = file.getOriginalFilename();
            String extension = getFileExtension(originalFilename);
            String formattedDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss"));
            String filenameWithoutExtension = removeFileExtension(originalFilename);
            return filenameWithoutExtension + "-" + formattedDate + extension;
        }
        return null;
    }

    public static boolean saveImageToServer(HttpServletRequest request, String dir, MultipartFile file, String fileName) {
        if(file != null && fileName != null){
            Path savePath = Paths.get(uploadDirectory + dir);
            Path filePath = savePath.resolve(fileName);
            try {
                if (!Files.exists(savePath)) {
                    Files.createDirectories(savePath);
                }
                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
    }

    public static List<String> saveMultipleFilesToServer(HttpServletRequest request, String dir, MultipartFile... files) {

        List<String> listFileName = new ArrayList<>();

        if(files == null) return listFileName;

        boolean isSuccess = true;

        for(MultipartFile file: files){
            if(file!= null){
                String fileName = formatNameImage(file);
                boolean isSave = saveImageToServer(request, dir, file, fileName);
                listFileName.add(fileName);
                if(!isSave){
                    isSuccess = false;
                    break;
                }
            }
        }

        if(!isSuccess){
            for(String fileName: listFileName){
                deleteImageFromServer(request, dir, fileName);
            }
            return null;
        }

        return listFileName;
    }

    public static void deleteMultipleFilesToServer(HttpServletRequest request,String dir, String listFileName) {
        if(listFileName != null){
            String[] fileNames = listFileName.split(",");
            for(String fn: fileNames){
                deleteImageFromServer(request, dir, fn);
            }
        }
    }

    public static boolean deleteImageFromServer(HttpServletRequest request,String dir, String fileName) {
        String basePath = request.getSession().getServletContext().getRealPath("/");
        String grandparentPath = Paths.get(basePath).getParent().getParent().toString();
        Path deletePath = Paths.get(grandparentPath + dir + fileName);

        String[] parts = dir.split("upload");
        String destinationFolder = parts[parts.length-1];
        Path deletePathTarget = Paths.get(basePath + "/upload/" + destinationFolder + "/" + fileName);

        if (Files.exists(deletePath)) {
            try {
                Files.delete(deletePath);
                if (Files.exists(deletePathTarget)) {
                    try {
                        Files.delete(deletePathTarget);
                        return true;
                    } catch (IOException e) {
                        return false;
                    }
                }
                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
    }

    public static String convertMultipartFileArrayToString(MultipartFile[] files) {
        if (files != null) {
            return Arrays.stream(files)
                    .filter(file -> file != null && !file.isEmpty())
                    .map(file -> formatNameImage(file))
                    .collect(Collectors.joining(","));
        }
        return null;
    }

    public static String convertMultipartFileArrayToString(List<String> listFileNameSaveFileSuccess) {
        if (!listFileNameSaveFileSuccess.isEmpty()) {
            return listFileNameSaveFileSuccess.stream()
                    .filter(file -> file != null && !file.isEmpty())
                    .collect(Collectors.joining(","));
        }
        return null;
    }

    public static String getPathUpload(Class<?> c, String fileName) {
        if(fileName != null){
            if (c == User.class) {
                return UserConstant.PATH_FILE + fileName;
            }
            else if (c == Accounting.class) {
                return AccountingConstant.PATH_FILE + fileName;
            }
            else if (c == Notification.class) {
                return NotificationConstant.PATH_FILE + fileName;
            }
            else if (c == Contract.class) {
                return ContractConstant.PATH_FILE + fileName;
            }
            else if (c == Book.class) {
                return BookConstant.PATH_FILE + fileName;
            }
        }
        return null;
    }

    public static String[] getPathUploadList(Class<?> c, String fileNames) {
        if(fileNames != null && !fileNames.isEmpty()){
            String[] rs = fileNames.split(",");
            return Stream.of(rs).map(fileName -> {
                if (c == User.class) {
                    return UserConstant.PATH_FILE + fileName;
                }
                else if (c == Accounting.class) {
                    return AccountingConstant.PATH_FILE + fileName;
                }
                else if (c == Notification.class) {
                    return NotificationConstant.PATH_FILE + fileName;
                } else return null;
            }).toArray(String[]::new);
        }
        return null;
    }

    public static boolean isAllowedFileType(MultipartFile file, String listType) {
        String originalFileName = file.getOriginalFilename();
        if (originalFileName != null) {
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toLowerCase();
            String[] allowedExtensions = listType.split(",");

            for (String allowedExtension : allowedExtensions) {
                if (fileExtension.equals(allowedExtension.trim().toLowerCase())) return true;
            }
        }
        return false;
    }

    public static boolean isAllowedFileType(MultipartFile[] files, String listType) {
        return Arrays.stream(files)
                .allMatch(file -> isAllowedFileType(file, listType));
    }

    public static boolean isAllowedFileSize(MultipartFile file, Integer fileSize) {
        long fileSizeInBytes = file.getSize();
        long maxFileSizeInBytes = fileSize * 1024 * 1024;
        return fileSizeInBytes <= maxFileSizeInBytes;
    }

    public static boolean isAllowedFileSize(MultipartFile[] files, Integer fileSize) {
        for(MultipartFile file: files){
            if(!isAllowedFileSize(file,fileSize)) return false;
        }
        return true;
    }
}
