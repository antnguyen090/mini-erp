package com.webapp.erpapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/settings")
public class SettingController {

    @GetMapping("/file")
    public ModelAndView getSettingFiles() {
        ModelAndView mav = new ModelAndView("setting/file");
        return mav;
    }
}