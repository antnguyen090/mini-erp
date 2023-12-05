package com.webapp.erpapp.exception;

// Defines UnauthorizedException for cases where there is no access
public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException(String message) {
        super(message);
    }
}
