package com.cong.serviceImp;

import com.cong.bean.User;
import com.cong.dao.UserMapper;
import com.cong.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1114:25
 */
@Service
public class UserServiceImp implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User checkUserLoginPass(Map params) {
        return userMapper.checkUserLoginPass(params);
    }

    @Override
    public List<Map> findAllWorkHourse(Map params) {
        return userMapper.findAllWorkHourse(params);
    }

    @Override
    public int findAllWorkHourseCount(Map params) {
        return userMapper.findAllWorkHourseCount(params);
    }

    @Override
    public int findHrIdByUserId(int id) {
        return userMapper.findHrIdByUserId(id);
    }

    @Override
    public int addWorkHourse(Map params) {
        return userMapper.addWorkHourse(params);
    }

    @Override
    public Map findTodayWorkHourse(Map params) {
        return userMapper.findTodayWorkHourse(params);
    }

    @Override
    public int updateWorkHourseOk(int id) {
        return userMapper.updateWorkHourseOk(id);
    }

    @Override
    public int updateWorkHourseNoOk(Map params) {
        return userMapper.updateWorkHourseNoOk(params);
    }

    @Override
    public int updateAllWorkHourseOK(int id) {
        return userMapper.updateAllWorkHourseOK(id);
    }

    @Override
    public int addLeave(Map params) {
        return userMapper.addLeave(params);
    }

    @Override
    public List<Map> findAllLeaver(Map params) {
        return userMapper.findAllLeaver(params);
    }

    @Override
    public int findAllLeaverCount(Map params) {
        return userMapper.findAllLeaverCount(params);
    }

    @Override
    public int updateLeaveOk(int id) {
        return userMapper.updateLeaveOk(id);
    }

    @Override
    public int updateLeaveNoOk(Map params) {
        return userMapper.updateLeaveNoOk(params);
    }

    @Override
    public int updateAllLeaveOK(int id) {
        return userMapper.updateAllLeaveOK(id);
    }

    @Override
    public int addemail(Map params) {
        return userMapper.addemail(params);
    }

    @Override
    public List<Map> findAllEmail(Map params) {
        return userMapper.findAllEmail(params);
    }

    @Override
    public int findAllEmailCount(Map params) {
        return userMapper.findAllEmailCount(params);
    }

    @Override
    public int deleteEmaoById(int id) {
        return userMapper.deleteEmaoById(id);
    }

    @Override
    public List<Map> findTastByMe(Map params) {
        return userMapper.findTastByMe(params);
    }

    @Override
    public int findTastByMeCount(Map params) {
        return userMapper.findTastByMeCount(params);
    }

    @Override
    public int addTask(Map params) {
        return userMapper.addTask(params);
    }

    @Override
    public int findManIdThrowUserId(int id) {
        return userMapper.findManIdThrowUserId(id);
    }

    @Override
    public int findMyTaskCount(Map params) {
        return userMapper.findMyTaskCount(params);
    }

    @Override
    public List<Map> findMyTask(Map params) {
        return userMapper.findMyTask(params);
    }

    @Override
    public int findHrIdByDepartmentId(int id) {
        return userMapper.findHrIdByDepartmentId(id);
    }

    @Override
    public int addHumanTransfo(Map params) {
        return userMapper.addHumanTransfo(params);
    }

    @Override
    public List<Map> findMyHumanApplication(Map params) {
        return userMapper.findMyHumanApplication(params);
    }

    @Override
    public int findMyHumanApplicationCount(Map params) {
        return userMapper.findMyHumanApplicationCount(params);
    }

    @Override
    public List<Map> findHumanInApplication(Map params) {
        return userMapper.findHumanInApplication(params);
    }

    @Override
    public int findHumanInApplicationCount(Map params) {
        return userMapper.findHumanInApplicationCount(params);
    }

    @Override
    public int inApplicationIsOk(int id) {
        return userMapper.inApplicationIsOk(id);
    }

    @Override
    public int inApplicationIsNoOk(Map params) {
        return userMapper.inApplicationIsNoOk(params);
    }

    @Override
    public Map findResult(int id) {
        return userMapper.findResult(id);
    }

    @Override
    public int updateFinalResult(int id) {
        return userMapper.updateFinalResult(id);
    }

    @Override
    public List<Map> findHumanOutApplication(Map params) {
        return userMapper.findHumanOutApplication(params);
    }

    @Override
    public int findHumanOutApplicationCount(Map params) {
        return userMapper.findHumanOutApplicationCount(params);
    }

    @Override
    public int outApplicationIsOk(int id) {
        return userMapper.outApplicationIsOk(id);
    }

    @Override
    public int outApplicationIsNoOk(Map params) {
        return userMapper.outApplicationIsNoOk(params);
    }

    @Override
    public int updateUserMessageWhereTrans(Map params) {
        return userMapper.updateUserMessageWhereTrans(params);
    }

    @Override
    public Map findUserIDByTran(int id) {
        return userMapper.findUserIDByTran(id);
    }

    @Override
    public int userUpdatePass(Map params) {
        return userMapper.userUpdatePass(params);
    }
}
