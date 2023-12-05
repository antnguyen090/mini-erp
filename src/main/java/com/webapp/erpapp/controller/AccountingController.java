package com.webapp.erpapp.controller;

import com.webapp.erpapp.constant.SettingConstant;
import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.model.response.accounting.AccountResponse;
import com.webapp.erpapp.model.response.accounting.PageAccountListResponse;
import com.webapp.erpapp.model.response.setting.SettingAllowanceResponse;
import com.webapp.erpapp.service.AccountingService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
@RequestMapping("/accounting")
@RequiredArgsConstructor
public class AccountingController {
    private final AccountingService accountingService;
    private final SettingMapper settingMapper;
    @GetMapping()
    public ModelAndView showAccountingList(@RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                           @RequestParam(name = "size", required = false, defaultValue = "10") Integer size,
                                           @RequestParam(name = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                           @RequestParam(name = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        ModelAndView modelAndView = new ModelAndView("accounting/homepage");
        if (startDate == null) {
            LocalDate today = LocalDate.now();
            startDate = today.withDayOfMonth(1);
        }

        if (endDate == null) {
            LocalDate today = LocalDate.now();
            endDate = today.withDayOfMonth(today.lengthOfMonth());
        }
        PageAccountListResponse listResponse = accountingService.findAccountingByMonth(page,size,startDate,endDate);
        Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);

        SettingAllowanceResponse settings = new SettingAllowanceResponse(setting.getFileSize(),setting.getFileType(),setting.getImageType(),setting.getFileLimit());

        modelAndView.addObject("list",listResponse);
        modelAndView.addObject("setting",settings);

//        modelAndView.addObject("month",monthId);
        return modelAndView;
    }

    @GetMapping("/detail/{id}")
    public ModelAndView showAccountingDetail(@PathVariable("id") String id) {
        ModelAndView modelAndView = new ModelAndView("accounting/detail");
        AccountResponse accountingResponse = accountingService.findAccountingById(id);
        Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);

        SettingAllowanceResponse settings = new SettingAllowanceResponse(setting.getFileSize(),setting.getFileType(),setting.getImageType(),setting.getFileLimit());

        modelAndView.addObject("account",accountingResponse);
        modelAndView.addObject("setting",settings);
        return modelAndView;
    }
}
