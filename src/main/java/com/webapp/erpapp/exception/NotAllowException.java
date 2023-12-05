package com.webapp.erpapp.exception;

// Define InvalidException for overlapping cases
public class NotAllowException extends RuntimeException {
    public NotAllowException(String message) {
        super(message);
    }
}
