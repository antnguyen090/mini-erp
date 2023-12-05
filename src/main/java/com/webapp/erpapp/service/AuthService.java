package com.webapp.erpapp.service;

import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.model.request.user.UserRegisterRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;

public interface AuthService {
    int registerUser(UserRegisterRequest user);
    User registerUserOAuth2(OAuth2User oAuth2User);
}
