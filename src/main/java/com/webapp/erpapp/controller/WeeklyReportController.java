package com.webapp.erpapp.controller;

import com.webapp.erpapp.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.webapp.erpapp.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/weekly-reports")
public class WeeklyReportController {

    @Autowired
    private WeeklyReportService weeklyReportService;

    @GetMapping
    public ModelAndView showListWeeklyReport() {
        ModelAndView mav = new ModelAndView("weekly-report/list-weekly-report");
        return mav;
    }

    @GetMapping("/{id}")
    public ModelAndView findById(@PathVariable String id) {
        ModelAndView mav = new ModelAndView("weekly-report/weekly-report-detail");
        WeeklyReportDetailResponse wr = weeklyReportService.findById(id);
        mav.addObject("wr", wr);
        return mav;
    }
}
