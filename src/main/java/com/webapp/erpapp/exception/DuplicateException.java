package com.webapp.erpapp.exception;

// Define DuplicateException for overlapping cases
public class DuplicateException extends RuntimeException {
    public DuplicateException(String message) {
        super(message);
    }
}
