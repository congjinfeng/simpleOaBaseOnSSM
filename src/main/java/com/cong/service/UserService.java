package com.cong.service;

import com.cong.bean.User;

import java.util.List;
import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1114:24
 */
public interface UserService {
    /*检查员工登录密码*/
    public User checkUserLoginPass(Map params);

    /*查看所有的工时*/
    public List<Map> findAllWorkHourse(Map params);

    public int findAllWorkHourseCount(Map params);

    /*根据员工的ID查找HRID*/
    public int findHrIdByUserId(int id);

    /*添加工时*/
    public int addWorkHourse(Map params);

    /*判断今天是否已经添加了工时*/
    public Map findTodayWorkHourse(Map params);

    /*审核工时通过*/
    public int updateWorkHourseOk(int id);

    /*审核工时不通过*/
    public int updateWorkHourseNoOk(Map params);

    /*一键审核工时*/
    public int updateAllWorkHourseOK(int id);

    /*添加请假*/
    public int addLeave(Map params);

    /*查找请假*/
    public List<Map> findAllLeaver(Map params);

    public int findAllLeaverCount(Map params);

    /*审核请假通过*/
    public int updateLeaveOk(int id);

    /*审核请假不通过*/
    public int updateLeaveNoOk(Map params);

    /*一键审核请假*/
    public int updateAllLeaveOK(int id);

    /*添加邮件*/
    public int addemail(Map params);

    /*查找邮件*/
    public List<Map> findAllEmail(Map params);

    public int findAllEmailCount(Map params);

    /*删除邮件*/
    public int deleteEmaoById(int id);

    /*查看我发布的任务*/
    public List<Map> findTastByMe(Map params);

    public int findTastByMeCount(Map params);

    /*添加任务*/
    public int addTask(Map params);

    /*根据员工ID查找主管ID*/
    public int findManIdThrowUserId(int id);

    /*查看我的任务*/
    public int findMyTaskCount(Map params);

    public List<Map> findMyTask(Map params);

    /*根据部门ID查找人事主管ID*/
    public int findHrIdByDepartmentId(int id);

    /*添加调动申请*/
    public int addHumanTransfo(Map params);

    /*查看我的人事调动*/
    public List<Map> findMyHumanApplication(Map params);

    public int findMyHumanApplicationCount(Map params);

    /*查看我的人事调入申请*/
    public List<Map> findHumanInApplication(Map params);

    public int findHumanInApplicationCount(Map params);

    /*调入审批通过*/
    public int inApplicationIsOk(int id);

    /*调入审批不通过*/
    public int inApplicationIsNoOk(Map params);

    /*判断审核最终结果*/
    public Map findResult(int id);

    /*修改最终结果*/
    public int updateFinalResult(int id);

    /*查看我的人事调出申请*/
    public List<Map> findHumanOutApplication(Map params);

    public int findHumanOutApplicationCount(Map params);

    /*调出审批通过*/
    public int outApplicationIsOk(int id);

    /*调出审批不通过*/
    public int outApplicationIsNoOk(Map params);
    /*审批通过修改员工信息*/
    public int updateUserMessageWhereTrans(Map params);
    /*通过调动申请ID获取申请人ID*/
    public Map findUserIDByTran(int id);
    /*员工修改密码*/
    public int userUpdatePass(Map params);
}
