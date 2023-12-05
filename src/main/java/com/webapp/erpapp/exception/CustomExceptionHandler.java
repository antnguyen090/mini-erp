package com.webapp.erpapp.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@RestControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(UnauthorizedException.class)
    public void handleUnauthorizedException(UnauthorizedException ex, HttpServletResponse response) throws IOException  {
        log.error(ex.getMessage(),ex);
        response.sendRedirect("/forbidden");
    }

    @ExceptionHandler(DuplicateException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse handleDuplicateException(DuplicateException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(FileTooLimitedException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTooLimitedException(FileTooLimitedException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NotFoundException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNotFoundException(NotFoundException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NoMatchException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNoMatchException(NoMatchException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileTypeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTypeNotAllowException(FileTypeNotAllowException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileSizeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileSizeNotAllowException(FileSizeNotAllowException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileLimitNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileLimitNotAllowException(FileLimitNotAllowException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNotAllowException(NotAllowException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleMethodArgumentNotValidException(MethodArgumentNotValidException e, WebRequest req) {
        log.error(e.getMessage(),e);
        return new ErrorResponse(HttpStatus.BAD_REQUEST,
                e.getBindingResult().getAllErrors().get(0).getDefaultMessage());
    }

    @ExceptionHandler(ErrorConvertJsonException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleErrorConvertJsonException(ErrorConvertJsonException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(InvalidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleInvalidException(InvalidException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(MissingException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleMissingException(MissingException ex, WebRequest req) {
        log.error(ex.getMessage(),ex);
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleException(Exception ex, WebRequest req, HttpServletResponse response) throws IOException {
        log.error(ex.getMessage(), ex);
        HttpServletRequest servletRequest = ((ServletWebRequest) req).getRequest();
        String uri = servletRequest.getRequestURI();
        if (uri.contains("api")) {
            return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        } else {
            response.sendRedirect("/404-page");
            return null;
        }
    }
}
