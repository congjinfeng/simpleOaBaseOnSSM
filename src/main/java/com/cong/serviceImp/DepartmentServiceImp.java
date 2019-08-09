package com.cong.serviceImp;

import com.cong.dao.DepartmentMapper;
import com.cong.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1216:30
 */
@Service
public class DepartmentServiceImp implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;


    @Override
    public List<Map> findAllDepartmentForTree() {
        return departmentMapper.findAllDepartmentForTree();
    }

    @Override
    public List<Map> findAllDepartment(Map params) {
        return departmentMapper.findAllDepartment(params);
    }

    @Override
    public int findAllDepartmentCount(Map params) {
        return departmentMapper.findAllDepartmentCount(params);
    }

    @Override
    public List<Map> findNextDeparmentById(int id) {
        return departmentMapper.findNextDeparmentById(id);
    }

    @Override
    public int addDepartment(Map params) {
        return departmentMapper.addDepartment(params);
    }

    @Override
    public int updateDepartment(Map params) {
        return departmentMapper.updateDepartment(params);
    }

    @Override
    public int findUpDepartmentId(int id) {
        return departmentMapper.findUpDepartmentId(id);
    }

    @Override
    public Map findDeparmetnByName(Map params) {
        return departmentMapper.findDeparmetnByName(params);
    }

    @Override
    public List<Map> findUserById(int id) {
        return departmentMapper.findUserById(id);
    }

    @Override
    public Map findDepartmentById(int id) {
        return departmentMapper.findDepartmentById(id);
    }

    @Override
    public int deleteDepartmentById(int id) {
        return departmentMapper.deleteDepartmentById(id);
    }

    @Override
    public List<Map> findAllUser(Map params) {
        return departmentMapper.findAllUser(params);
    }

    @Override
    public int findAllUserCount(Map params) {
        return departmentMapper.findAllUserCount(params);
    }

    @Override
    public int addUser(Map params) {
        return departmentMapper.addUser(params);
    }

    @Override
    public int updateUser(Map params) {
        return departmentMapper.updateUser(params);
    }

    @Override
    public int findManIdByDepartmentId(int id) {
        return departmentMapper.findManIdByDepartmentId(id);
    }

    @Override
    public int findManIdByHrId(int id) {
        return departmentMapper.findHrIdByDepartmentId(id);
    }

    @Override
    public int updateDeparmentWhenUserChoseMan(Map params) {
        return departmentMapper.updateDeparmentWhenUserChoseMan(params);
    }

    @Override
    public int updateDeparmentWhenUserChoseHr(Map params) {
        return departmentMapper.updateDeparmentWhenUserChoseHr(params);
    }

    @Override
    public int updateAdminPass(Map params) {
        return departmentMapper.updateAdminPass(params);
    }

    @Override
    public Map findUserByUserId(int id) {
        return departmentMapper.findUserByUserId(id);
    }

    @Override
    public int deleteUser(Map params) {
        return departmentMapper.deleteUser(params);
    }

    @Override
    public int updateDepartmentMan(int id) {
        return departmentMapper.updateDepartmentMan(id);
    }

    @Override
    public int updateDepartmentHr(int id) {
        return departmentMapper.updateDepartmentHr(id);
    }

    @Override
    public int findHowManyPeopleComeThisMonth(String num) {
        return departmentMapper.findHowManyPeopleComeThisMonth(num);
    }

    @Override
    public List<Map> findAllNotice(Map params) {
        return departmentMapper.findAllNotice(params);
    }

    @Override
    public int findAllNoticeCount() {
        return departmentMapper.findAllNoticeCount();
    }

    @Override
    public int addNotice(Map params) {
        return departmentMapper.addNotice(params);
    }

    @Override
    public int findDepartmentCount() {
        return departmentMapper.findDepartmentCount();
    }

    @Override
    public int findUserCount() {
        return departmentMapper.findUserCount();
    }

    @Override
    public int findUserNormalCount() {
        return departmentMapper.findUserNormalCount();
    }

    @Override
    public int findUserNoNormalCount() {
        return departmentMapper.findUserNoNormalCount();
    }

    @Override
    public int inUserCount(String date) {
        return departmentMapper.inUserCount(date);
    }

    @Override
    public int outUserCount(String date) {
        return departmentMapper.outUserCount(date);
    }


}
