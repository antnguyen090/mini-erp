package com.webapp.erpapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthController {

    @GetMapping("/login")
    public ModelAndView login() {
        ModelAndView mav = new ModelAndView("auth/login");
        return mav;
    }

    @GetMapping("/register/confirm-mail")
    public ModelAndView confirmMail() {
        ModelAndView mav = new ModelAndView("auth/confirm-mail");
        return mav;
    }

    @GetMapping("/register")
    public ModelAndView register() {
        ModelAndView mav = new ModelAndView("auth/register");
        return mav;
    }
}
