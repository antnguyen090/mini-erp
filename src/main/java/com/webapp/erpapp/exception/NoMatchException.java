package com.webapp.erpapp.exception;

// Define NoMatchException for overlapping cases
public class NoMatchException extends RuntimeException {
    public NoMatchException(String message) {
        super(message);
    }
}
