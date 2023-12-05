
package com.webapp.erpapp.utils;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class DateUtils {
    public static Date getDefaultStartDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    public static String formatDateTime(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            return sdf.format(date);
        }
        return null;
    }

    public static Date parseDateTime(String date) {
        if(date != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
            try {
                return sdf.parse(date);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static String formatTime(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatDate(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatHHMM(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatDate(LocalDate localDate) {
        if (localDate != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return localDate.format(formatter);
        }
        return null;
    }

    public static String formatTime(Time time) {
        if(time != null){
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            return sdf.format(time);
        }
        return null;
    }

    public static String formatLocalDateTime(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }

    public static String formatDate(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }

    public static String formatYearMonth(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }


    public static LocalDateTime toLocalDateTime(String dateString) {
        LocalDate localDate = LocalDate.parse(dateString);
        LocalTime currentTime = LocalTime.now();

        return LocalDateTime.of(localDate, currentTime);
    }

    public static Date toDate(String dateString) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = dateFormat.parse(dateString);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean isValidDate(String dateStr) {
        String regex = "\\d{4}-\\d{2}-\\d{2}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(dateStr);
        if (!matcher.matches()) {
            return false;
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        try {
            dateFormat.parse(dateStr);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
