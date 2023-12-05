package com.webapp.erpapp.security.oauth2;

import com.webapp.erpapp.exception.UserLockException;
import com.webapp.erpapp.exception.UserPendingException;
import com.webapp.erpapp.exception.WaitingApprovalException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomFailureOauth2Handler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        if (exception instanceof UserLockException) {
            response.sendRedirect("/login?userLock");
        } else if (exception instanceof UserPendingException) {
            response.sendRedirect("/login?userPending");
        } else if(exception instanceof WaitingApprovalException){
            response.sendRedirect("/login?registerOauth2");
        }
    }
}
