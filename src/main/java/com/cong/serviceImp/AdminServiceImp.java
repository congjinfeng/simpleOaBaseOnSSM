package com.cong.serviceImp;

import com.cong.bean.Admin;
import com.cong.dao.AdminMapper;
import com.cong.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1114:24
 */
@Service
public class AdminServiceImp implements AdminService{
    @Autowired
    private AdminMapper adminMapper;
    @Override
    public Admin checkAdminLoginPass(Map params) {
        return adminMapper.checkAdminLoginPass(params);
    }
}
