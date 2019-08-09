package com.cong.controller;

import com.cong.bean.Admin;
import com.cong.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 从进峰
 * @create 2019-05-1216:33
 */
@Controller
public class DepartmentHandle {
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/findAllDepartmentHtml")
    public String findAllDepartmentHtml() {
        return "Admin/showAllDepartment";
    }

    @RequestMapping("/findAllDepartmentByTable")
    public @ResponseBody
    Map findAllDepartmentByTable(@RequestParam Map params) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        List<Map> departments = departmentService.findAllDepartment(params);
        int count = departmentService.findAllDepartmentCount(params);
        Map result = new HashMap();
        result.put("data", departments);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    @RequestMapping("/findAllDepartment")
    public @ResponseBody
    List<Map> findAllDepartment() {
        List<Map> departments = departmentService.findAllDepartmentForTree();
        return departments;
    }

    /*跳转到添加子部门的界面*/
    @RequestMapping("/addDepartmentHtml")
    public String addDepartmentHtml(int pid, HttpServletRequest request) {
        System.out.println("传过来的值是:" + pid);
        if (pid != 0) {
            request.setAttribute("pid", pid);
        }

        return "Admin/addDepartment";
    }

    /*跳转到选择主管和人事主管的的界面*/
    @RequestMapping("/choseMan")
    public String choseMan(int sign) {
        if (sign == 1) {
            return "Admin/choseUser";
        } else {
            return "Admin/choseHr";
        }

    }

    /*跳转到显示员工的界面*/
    @RequestMapping("/findAllUserHtml")
    public String findAllUserHtml() {
        return "Admin/showAllUser";
    }

    /*查找所有的员工*/
    @RequestMapping("/findAllUser")
    public @ResponseBody
    Map findAllUser(@RequestParam Map params) {
        System.out.println("查询员工" + params);
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        List<Map> users = departmentService.findAllUser(params);
        int count = departmentService.findAllUserCount(params);
        Map result = new HashMap();
        result.put("data", users);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*根据部门ID查找是否有下级部门*/
    @RequestMapping("/findNextDeparmentById")
    public @ResponseBody
    String findNextDeparmentById(int id) {
        List<Map> results = departmentService.findNextDeparmentById(id);
        if (results.isEmpty()) {
            return "none";
        } else {
            return "have";
        }
    }

    /*根据部门ID查找是否有员工*/
    @RequestMapping("/findUserById")
    public @ResponseBody
    String findUserById(int id) {
        List<Map> results = departmentService.findUserById(id);
        System.out.println("查找当前部门是否有员工！！！！！" + results);
        if (results.isEmpty()) {
            return "none";
        } else {
            return "have";
        }
    }

    /*根据部门ID删除部门*/
    @RequestMapping("/deleteDepartmentById")
    public @ResponseBody
    String deleteDepartmentById(int id) {
        int row = departmentService.deleteDepartmentById(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*添加部门*/
    @RequestMapping("/addDepartment")
    public @ResponseBody
    String addDepartment(@RequestParam Map params) {
        Map map = departmentService.findDeparmetnByName(params);
        if (map == null) {
            int row = departmentService.addDepartment(params);
            if (row > 0) {
                return "success";
            } else {
                return "fail";
            }
        } else {
            return "fail";
        }
    }

    /*选择部门的界面*/
    @RequestMapping("/choseDepartment")
    public String choseDepartment() {
        return "Admin/choseDepartment";
    }

    /*添加用户界面*/
    @RequestMapping("/addUserHtml")
    public String addUserHtml() {
        return "Admin/addUser";
    }

    /*添加用户*/

    @RequestMapping("/addUser")
    public @ResponseBody
    String addUser(@RequestParam Map params) {
        params.put("pass", "123456");
        params.put("date", new Date());
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        /*根据这个去查找当月公司一共招了多少人，工号组成0+年份+月份+本月第几位来到公司*/
        String firstUserNum = "0";
        if (month < 10) {
            firstUserNum = firstUserNum + year + "0" + month;
        } else {
            firstUserNum = firstUserNum + year + month;
        }
        int num = departmentService.findHowManyPeopleComeThisMonth(firstUserNum);
        String usernum = firstUserNum;
        if (num < 10) {
            usernum = usernum + "00" + num;
        } else if (num < 100) {
            usernum = usernum + "0" + num;
        } else {
            usernum = usernum + num;
        }
        System.out.println("该员工的工号是：" + usernum);
        params.put("usernum", usernum);
        int row = departmentService.addUser(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*跳转到修改部门的界面*/
    @RequestMapping("/updateDepartmentHtml")
    public String updateDepartmentHtml(int pid, HttpServletRequest request) {
        Map department = departmentService.findDepartmentById(pid);
        System.out.println(department);
        request.setAttribute("department", department);
        return "Admin/updateDepartment";
    }

    /*更新数据*/
    @RequestMapping("/updateDepartment")
    public @ResponseBody
    String updateDepartment(@RequestParam Map params) {
        /*先查找部门的上级ID*/
        int id = departmentService.findUpDepartmentId(Integer.parseInt((String) params.get("id")));
        Map m = new HashMap();
        m.put("id", id);
        m.put("name", params.get("name"));
        Map map = departmentService.findDeparmetnByName(m);
        if (map == null) {
            int row = departmentService.updateDepartment(params);
            if (row > 0) {
                return "success";
            } else {
                return "fail";
            }
        } else {
            return "fail";
        }
    }

    /*删除员工*/
    @RequestMapping("/deleteUserById")
    public @ResponseBody
    String deleteUserById(@RequestParam Map params) {
        params.put("enddate", new Date());
        int row = departmentService.deleteUser(params);
        /*判断员工是否是主管或者人事主管，如果是主管或者人事主管，则部门表对应的字段为空*/
        departmentService.updateDepartmentMan(Integer.parseInt((String) params.get("id")));
        departmentService.updateDepartmentHr(Integer.parseInt((String) params.get("id")));
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*修改员工*/
    @RequestMapping("/updateUsertHtml")
    public String updateUsertHtml(int pid, HttpServletRequest request) {
        /*根据ID查找到用户*/
        Map user = departmentService.findUserByUserId(pid);
        request.setAttribute("user", user);
        return "Admin/updateUser";
    }

    /*修改员工信息*/
    @RequestMapping("/updateUser")
    public @ResponseBody
    String updateUser(@RequestParam Map params) {

        /*如果修改后是主管或者人事主管，需要更新部门表*/
        String postion = (String) params.get("position");
        int department = Integer.parseInt((String) params.get("department"));
        int id = Integer.parseInt((String) params.get("id"));
        if (postion.equals("主管")) {
            Map map = new HashMap();
            map.put("department", department);
            map.put("id", id);
            /*检查这个部门是否有主管*/
            int result = departmentService.findManIdByDepartmentId(department);
            if (result != 0) {
                /*说明此时这个部门已经有主管了*/
                return "exits";
            } else {
                /*开始更新*/
                int row = departmentService.updateUser(params);
                if (row > 0) {
                    /*同步部门表*/
                    int num = departmentService.updateDeparmentWhenUserChoseMan(map);
                    if (num > 0) {
                        /*同步成功*/
                        return "success";
                    } else {
                        /*同步失败*/
                        return "fail";
                    }
                } else {
                    return "fail";
                }
            }
        } else if (postion.equals("人事主管")) {
            Map map = new HashMap();
            map.put("department", department);
            map.put("id", id);
            /*查看这个部门是否有人事主管*/
            int result = departmentService.findManIdByHrId(id);
            if (result != 0) {
                /*说明此时这个部门已经有人事主管了*/
                return "exits";
            } else {
                /*开始更新*/
                int row = departmentService.updateUser(params);
                if (row > 0) {
                    /*同步部门表*/
                    int num = departmentService.updateDeparmentWhenUserChoseHr(map);
                    if (num > 0) {
                        return "success";
                    } else {
                        return "fail";
                    }
                } else {
                    return "fail";
                }
            }
        } else {
            int row = departmentService.updateUser(params);
            if (row > 0) {
                return "success";
            } else {
                return "fail";
            }
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        /*清除Session*/
        session.invalidate();
        System.out.println("用户退出登录");
        return "redirect:/index.jsp";
    }

    @RequestMapping("/updatePasswordHtml")
    public String updatePasswordHtml(int id, HttpServletRequest request) {
        request.setAttribute("id", id);
        return "Admin/updatePassHtml";
    }

    @RequestMapping("/adminUpdatePass")
    public @ResponseBody
    String adminUpdatePass(@RequestParam Map params) {
        int row = departmentService.updateAdminPass(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*跳转到显示所有的公告界面*/
    @RequestMapping("/showAllNoticeHtml")
    public String showAllNoticeHtml() {
        return "Admin/showAllNotice";
    }

    /*查找所有的公告*/
    @RequestMapping("/findAllNotice")
    public @ResponseBody
    Map findAllNotice(@RequestParam Map params) {
        System.out.println("查询员工" + params);
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        List<Map> notices = departmentService.findAllNotice(params);
        int count = departmentService.findAllNoticeCount();
        Map result = new HashMap();
        result.put("data", notices);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    @RequestMapping("/addNoticeHtml")
    public String addNoticeHtml() {
        return "Admin/addNotice";
    }

    @RequestMapping("/addNotice")
    public @ResponseBody
    String addNotice(@RequestParam Map params, MultipartFile file) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String checkFile = file.getOriginalFilename();
        params.put("time", simpleDateFormat.format(new Date()));
        // 判断是否有文件上传
        if (checkFile != null && checkFile != "") {
            /*存储文件的路径*/
            String path = "D:\\file\\";
            /*获得图片的原始名称，包括文件格式*/
            String name = file.getOriginalFilename();
            params.put("name", name);
            /*使用UUID给图片生成一个新的名称 uuid+文件类型*/
            String newName = UUID.randomUUID() + name.substring(name.lastIndexOf("."));
            params.put("newName", newName);
            /*生成一个新的文件对象*/
            File newfile = new File(path + newName);
            /*写入到磁盘*/
            try {
                file.transferTo(newfile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println(params.toString());
        int row = departmentService.addNotice(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    @RequestMapping("/findDepartmentCount")
    public @ResponseBody
    int findDepartmentCount() {
        return departmentService.findDepartmentCount();
    }

    @RequestMapping("/findUserNoNormalCount")
    public @ResponseBody
    int findUserNoNormalCount() {
        return departmentService.findUserNoNormalCount();
    }

    @RequestMapping("/findUserCount")
    public @ResponseBody
    int findUserCount() {
        return departmentService.findUserCount();
    }

    @RequestMapping("/findUserNormalCount")
    public @ResponseBody
    int findUserNormalCount() {
        return departmentService.findUserNormalCount();
    }

    @RequestMapping("/inUserCount")
    public @ResponseBody
    int inUserCount() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        String date =year+"-"+month;
        return departmentService.inUserCount(date);
    }

    @RequestMapping("/outUserCount")
    public @ResponseBody
    int outUserCount() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        String date =year+"-"+month;
        return departmentService.outUserCount(date);
    }
}
