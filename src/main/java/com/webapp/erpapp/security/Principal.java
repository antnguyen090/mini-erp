package com.webapp.erpapp.security;

import com.webapp.erpapp.entity.User;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static User getUserCurrent() {
        return (User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
    }
}