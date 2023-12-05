package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(String email, String status);

    User findByEmail( String email);

    User findByTimesheetsCode( String timesheetsCode);

    int registerUser(User user);

    int updateUserProfile(User user);

    int updateUserDetail(User user);

    List<User> getAllUser( String searchTerm,
                           String sortDirection,
                           String status,
                          RowBounds rowBounds);

    User findById(String id);

    int changeStatusUser( String id,  String status);

    void activeUserRegister(User user);

    int deleteUser(String id);

    List<Map<String, Object>> getAllFullname();

    long getTotalUser(String status,
                       String searchTerm,
                       String sortDirection);

    List<User> getUserBirthday( LocalDate prevMonth, LocalDate nextMonth, LocalDate monthly);

    List<User> getTodayBirthday( LocalDate date);
}