package com.webapp.erpapp.utils;

public class MessageErrorUtils {
    public static String notFound(String s){
        return s.concat(" is not found");
    }

    public static String alreadyExists(String s){
        return s.concat(" already exists");
    }

    public static String notAllowImageType(String imageTypes){
        return "Image type is allowed! (" + imageTypes + ")";
    }

    public static String notAllowFileType(String fileTypes){
        return "File type is allowed (" + fileTypes + ")";
    }

    public static String notAllowFileLimit(int fileLimit){
        return "File count must <= " + fileLimit;
    }

    public static String notAllowFileSize(int fileSize){
        return "File size must <= " + fileSize + "Mb";
    }

    public static String unauthorized(){
        return "Unauthorized!";
    }

    public static String unknown(String s){
        return s.concat(" unknown!");
    }

    public static String notAllow(String s){
        return s.concat(" is not allow");
    }

    public static String invalid(){
        return "Data is invalid";
    }

    public static String missing(String s){
        return s + " can not be missing";
    }
}
