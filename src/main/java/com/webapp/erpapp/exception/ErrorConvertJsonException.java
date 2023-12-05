package com.webapp.erpapp.exception;

// Define ErrorConvertJsonException for overlapping cases
public class ErrorConvertJsonException extends RuntimeException {
    public ErrorConvertJsonException(String message) {
        super(message);
    }
}
