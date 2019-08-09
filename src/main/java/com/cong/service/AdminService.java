package com.cong.service;

import com.cong.bean.Admin;

import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1114:24
 */
public interface AdminService {
    /*检查登录人员的密码*/
    public Admin checkAdminLoginPass(Map params);
}
