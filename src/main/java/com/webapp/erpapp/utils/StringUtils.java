package com.webapp.erpapp.utils;

import com.webapp.erpapp.constant.AccountingConstant;
import com.webapp.erpapp.constant.CommentTaskConstant;
import com.webapp.erpapp.constant.UserConstant;
import com.webapp.erpapp.entity.Accounting;
import com.webapp.erpapp.entity.CommentTask;
import com.webapp.erpapp.entity.User;

public class StringUtils {

    public static boolean isBlank(String s){
        if(s == null || s.isEmpty()) return true;
        return false;
    }

    public static String[] split(String s, String regex){
        if (!isBlank(s)) {
            return s.split(regex);
        }
        return null;
    }

    public static String[] splitPathFile(Class<?> entityClass, String s, String regex){
        if (!isBlank(s)) {
            String[] parts = s.split(regex);
            for (int i = 0; i < parts.length; i++) {
                String pathRoot = "";
                if(entityClass == User.class){
                    pathRoot = UserConstant.PATH_FILE;
                } else if(entityClass == Accounting.class){
                    pathRoot = AccountingConstant.PATH_FILE;
                } else if(entityClass == CommentTask.class){
                    pathRoot = CommentTaskConstant.PATH_FILE;
                }
                parts[i] = pathRoot + parts[i];
            }
            return parts;
        }
        return null;
    }

    public static String getDifference(String old, String newStr) {

        if(isBlank(newStr)) return old;

        if(isBlank(old)) return null;

        String[] oldArray = old.split(",");
        String[] newArray = newStr.split(",");

        StringBuilder result = new StringBuilder();

        for (String element : oldArray) {
            if (!containsElement(newArray, element)) {
                if (result.length() > 0) {
                    result.append(",");
                }
                result.append(element);
            }
        }

        return result.toString();
    }

    private static boolean containsElement(String[] array, String element) {
        for (String e : array) {
            if (e.equals(element)) {
                return true;
            }
        }
        return false;
    }
}
