package com.cong.service;

import java.util.List;
import java.util.Map;

/**
 * @author 从进峰
 * @create 2019-05-1216:29
 */
public interface DepartmentService {
    /*ztree*/
    public List<Map> findAllDepartmentForTree();

    /*查看所有管理员*/
    public List<Map> findAllDepartment(Map params);

    public int findAllDepartmentCount(Map params);

    /*根据部门ID查找是否有下属部门*/
    public List<Map> findNextDeparmentById(int id);

    /*添加部门*/
    public int addDepartment(Map params);

    /*更新部门信息*/
    public int updateDepartment(Map params);

    /* 查找当前部门的上级部门ID*/
    public int findUpDepartmentId(int id);

    /*根据上级部门ID和部门名称判定是否唯一*/
    public Map findDeparmetnByName(Map params);

    /*根据部门ID查找是否有员工*/
    public List<Map> findUserById(int id);

    /*根据部门ID查找部门信息*/
    public Map findDepartmentById(int id);

    /*根据部门ID删除部门*/
    public int deleteDepartmentById(int id);

    /*查看所有的员工*/
    public List<Map> findAllUser(Map params);

    public int findAllUserCount(Map params);

    /*添加用户*/
    public int addUser(Map params);

    /*修改员工*/
    public int updateUser(Map params);

    /*修改员工信息，先判断，部门是否有主管或者人事主管*/
    public int findManIdByDepartmentId(int id);

    public int findManIdByHrId(int id);

    /*修改员工信息，如果是主管或者人事主管，同步部门表*/
    public int updateDeparmentWhenUserChoseMan(Map params);

    public int updateDeparmentWhenUserChoseHr(Map params);

    /*管理员修改密码*/
    public int updateAdminPass(Map params);

    /*根据ID查找用户*/
    public Map findUserByUserId(int id);

    /*根据ID删除用户*/
    public int deleteUser(Map params);

    public int updateDepartmentMan(int id);

    public int updateDepartmentHr(int id);

    /*查找公司这个月一共招了多少人*/
    public int findHowManyPeopleComeThisMonth(String num);

    /*查找所有公告*/
    public List<Map> findAllNotice(Map params);

    public int findAllNoticeCount();

    /*添加公告*/
    public int addNotice(Map params);

    /*查找部门数量*/
    public int findDepartmentCount();

    /*查找员工数量*/
    public int findUserCount();

    /*正式员工数量*/
    public int findUserNormalCount();

    /*非正式员工*/
    public int findUserNoNormalCount();

    /*本月新招员工*/
    public int inUserCount(String date);

    /*本月离职员工*/
    public int outUserCount(String date);
}
