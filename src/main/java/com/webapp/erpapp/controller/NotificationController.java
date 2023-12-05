package com.webapp.erpapp.controller;

import com.webapp.erpapp.constant.SettingConstant;
import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.enums.Notification.StatusNotificationEnum;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.model.response.notification.NotificationDetailResponse;
import com.webapp.erpapp.model.response.notification.NotificationShowResponse;
import com.webapp.erpapp.security.Principal;
import com.webapp.erpapp.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.webapp.erpapp.utils.ApplicationUtils;

import java.util.List;

@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private SettingMapper settingMapper;

    @Autowired
    ApplicationUtils applicationUtils;

    @GetMapping
    public String getList(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(name = "search", required = false, defaultValue = "") String search,
            Model model
    ) {
            List<NotificationShowResponse> listNotification = notificationService.getAllNoti((page - 1) * pageSize, pageSize, search);
            int totalNotification = notificationService.countAll(search); // Total number of notes
            int totalPages = (totalNotification + pageSize - 1) / pageSize;
            model.addAttribute("listNotification", listNotification);
            model.addAttribute("currentPage", page);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("search", search);
            Setting setting = settingMapper.findByCode(SettingConstant.NOTIFICATION_CODE);
            model.addAttribute("maxFileSize", setting.getFileSize());
            model.addAttribute("listTypeFile", setting.getFileType());
            model.addAttribute("uploadFileLimit", setting.getFileLimit());
            return "notification/get-list";
    }

    @GetMapping("/{id}")
    public String getDetail(@PathVariable String id,
                            Model model){
            NotificationDetailResponse notification = notificationService.findById(id);
            if(notification.getStatus().equals(StatusNotificationEnum.INACTIVE)){
                applicationUtils.checkUserAllow();
            }
            model.addAttribute("notification", notification);
            model.addAttribute("user", Principal.getUserCurrent());
            Setting setting = settingMapper.findByCode(SettingConstant.NOTIFICATION_CODE);
            model.addAttribute("maxFileSize", setting.getFileSize());
            model.addAttribute("listTypeFile", setting.getFileType());
            model.addAttribute("uploadFileLimit", setting.getFileLimit());
            return "notification/detail";
    }
}
