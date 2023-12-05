package com.webapp.erpapp.exception;

public class FileLimitNotAllowException extends RuntimeException {
    public FileLimitNotAllowException(String message) {
        super(message);
    }
}
