package com.webapp.erpapp.exception;

import org.springframework.security.core.AuthenticationException;

// Define UserNotFoundException for overlapping cases
public class UserNotFoundException extends AuthenticationException {
    public UserNotFoundException(String message) {
        super(message);
    }
}
