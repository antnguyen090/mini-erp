package com.webapp.erpapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NotFoundController {
    @GetMapping("/404-page")
    public String getFrontPage() {
        return "common/404-page";
    }
}
