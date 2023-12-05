package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.UserConverter;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.exception.DuplicateException;
import com.webapp.erpapp.exception.NoMatchException;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.user.UserRegisterRequest;
import com.webapp.erpapp.service.AuthService;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    UserConverter userConverter;

    @Autowired
    UserMapper userMapper;

    @Override
    public int registerUser(UserRegisterRequest userRegisterRequest){

        String pass = userRegisterRequest.getPassword();
        String passConfirm = userRegisterRequest.getConfirmPassword();
        if(pass!= null && passConfirm!= null && !passConfirm.equals(pass)){
            throw new NoMatchException("Password confirm isn't matched");
        }

        String email = userRegisterRequest.getEmail();
        User user = userMapper.findByEmail(email);

        if(user != null) throw new DuplicateException("UserID is existed in the system");

        user = userConverter.toEntity(userRegisterRequest);
        return userMapper.registerUser(user);
    }

    @Override
    public User registerUserOAuth2(OAuth2User oAuth2User) {

        String email = (String) oAuth2User.getAttributes().get("email");
        if(email == null) throw new NotFoundException(MessageErrorUtils.notFound("email"));

        User user = userConverter.toEntity(oAuth2User);
        try{
            userMapper.registerUser(user);
            return user;
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
