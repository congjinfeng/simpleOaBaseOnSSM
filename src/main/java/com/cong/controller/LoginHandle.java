package com.cong.controller;

import com.cong.bean.Admin;
import com.cong.bean.User;
import com.cong.dao.UserMapper;
import com.cong.service.AdminService;
import com.cong.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1114:30
 */
@Controller
public class LoginHandle {
    @Autowired
    private UserService userService;
    @Autowired
    private AdminService adminService;

    /*检查登录人员的密码*/
    @RequestMapping("/checkUserPass")
    public @ResponseBody
    String checkUserPass(@RequestParam Map params) {

        System.out.println(params);
        String name = (String) params.get("name");
        /*先判断是员工还是管理员*/
        if (name.startsWith("0") && name.length() == 10) {
            /*登录的使员工*/
            User user = userService.checkUserLoginPass(params);
            /*员工存在返回success*/
            if (user != null) {
                return "success";
            } else {
                return "fail";
            }
        } else {
            /*登录的是管理员*/
            Admin admin = adminService.checkAdminLoginPass(params);
            if (admin != null) {
                return "success";
            } else {
                return "fail";
            }
        }
    }

    /*登录，成功跳转到对应的界面*/
    @RequestMapping("/login")
    public ModelAndView login(@RequestParam Map params, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        String name = (String) params.get("name");
        /*员工登录*/
        if (name.startsWith("0") && name.length() == 10) {
            /*员工登录*/
            System.out.println(userService.checkUserLoginPass(params));
            session.setAttribute("user", userService.checkUserLoginPass(params));
            modelAndView.setViewName("User/userMain");
        } else {
            /*管理员登录*/
            Admin admin = adminService.checkAdminLoginPass(params);
            session.setAttribute("admin", admin);
            modelAndView.setViewName("Admin/adminMain");
            modelAndView.addObject("admin", adminService.checkAdminLoginPass(params));
        }
        return modelAndView;
    }

    /*跳转到管理员首页*/
    @RequestMapping("/adminWelcome")
    public String adminWelcome() {
        return "Admin/AdminWelcome";
    }

    /*跳转到员工首页*/
    @RequestMapping("/userWelcome")
    public String userWelcome() {
        return "User/userWelcome";
    }
}
