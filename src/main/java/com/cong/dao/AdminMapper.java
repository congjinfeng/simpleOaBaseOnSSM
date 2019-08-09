package com.cong.dao;

import com.cong.bean.Admin;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1113:57
 */
@Repository
public interface AdminMapper {
    /*检查登录人员的密码*/
    public Admin checkAdminLoginPass(Map params);
}
