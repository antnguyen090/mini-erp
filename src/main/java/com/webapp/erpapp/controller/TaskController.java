package com.webapp.erpapp.controller;

import com.webapp.erpapp.entity.Task;
import com.webapp.erpapp.enums.task.StatusDeleteTaskEnum;
import com.webapp.erpapp.mapper.TaskMapper;
import com.webapp.erpapp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @GetMapping
    public ModelAndView getTasks() {
        ModelAndView mav = new ModelAndView("task/tasks");
        return mav;
    }

    @GetMapping("/{id}")
    public ModelAndView getTask(@PathVariable String id) {

        Task task = taskMapper.findById(id);
        if (task.getStatus().equals(StatusDeleteTaskEnum.INACTIVE)){
            applicationUtils.checkUserAllow();
        }

        ModelAndView mav = new ModelAndView("task/task-detail");
        mav.addObject("id", id);
        return mav;
    }
}