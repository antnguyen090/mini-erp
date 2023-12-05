package com.webapp.erpapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/timesheets")
public class TimesheetsController {

    @GetMapping
    public ModelAndView getTimesheets() {
        ModelAndView mav = new ModelAndView("timesheets/timesheets");
        return mav;
    }
}