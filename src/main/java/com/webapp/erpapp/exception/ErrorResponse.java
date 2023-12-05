package com.webapp.erpapp.exception;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

// Define model response for exception
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ErrorResponse {
    private HttpStatus status;
    private String message;
}
