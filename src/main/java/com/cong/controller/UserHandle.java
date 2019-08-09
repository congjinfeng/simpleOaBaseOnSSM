package com.cong.controller;

import com.cong.bean.User;
import com.cong.service.DepartmentService;
import com.cong.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 从进峰
 * @create 2019-05-1614:32
 */
@Controller
public class UserHandle {
    @Autowired
    private UserService userService;

    /*跳转到查看所有工时的界面*/
    @RequestMapping("/showWorkHourseHtml")
    public String showWorkHourseHtml() {
        return "User/showAllWorkHourse";
    }

    /*跳转到填报工时界面*/
    @RequestMapping("/addWorkHourseHtml")
    public String addWorkHourseHtml() {
        return "User/addWorkHourse";
    }

    /*添加工时*/
    @RequestMapping("/addWorkHourse")
    public @ResponseBody
    String addWorkHourse(@RequestParam Map params) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        /*根据员工的ID查找部门的HRID*/
        int id = Integer.parseInt((String) params.get("id"));
        int hrid = userService.findHrIdByUserId(id);
        params.put("hrid", hrid);
        params.put("date", simpleDateFormat.format(new Date()));
        params.put("confirm", 0);
        /*判断今天的工时是否已经提交*/
        Map result = userService.findTodayWorkHourse(params);
        if (result != null) {
            return "fail";
        } else {
            /*插入到数据库中*/
            int row = userService.addWorkHourse(params);
            if (row > 0) {
                return "success";
            } else {
                return "fail";
            }
        }
    }

    /*查看所有的工时*/
    @RequestMapping("/findWorkHourse")
    public @ResponseBody
    Map findWorkHourse(@RequestParam Map params, HttpSession session) {
        System.out.println("传过来的参数类型是：" + params.toString());
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        if (params.get("sort") == null) {
            params.put("sort", 1);
        }
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        System.out.println(user.toString() + user.getuId());
        List<Map> workHourses = userService.findAllWorkHourse(params);
        int count = userService.findAllWorkHourseCount(params);
        Map result = new HashMap();
        result.put("data", workHourses);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到待我审核界面*/
    @RequestMapping("/findAllWorkHourseForMeHtml")
    public String findAllWorkHourseForMeHtml() {
        return "User/showAllWorkHourseForMe";
    }

    /*查看待我审核*/
    @RequestMapping("/findAllWorkHourseForMe")
    public @ResponseBody
    Map findAllWorkHourseForMe(@RequestParam Map params, HttpSession session) {
        System.out.println("传过来的参数类型是：" + params.toString());
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        System.out.println(user.toString() + user.getuId());
        List<Map> workHourses = userService.findAllWorkHourse(params);
        int count = userService.findAllWorkHourseCount(params);
        Map result = new HashMap();
        result.put("data", workHourses);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*审核工时通过*/
    @RequestMapping("/updateWorkHourseOk")
    public @ResponseBody
    String updateWorkHourseOk(int id) {
        int row = userService.updateWorkHourseOk(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*审核工时不通过*/
    @RequestMapping("/updateWorkHourseNoOk")
    public @ResponseBody
    String updateWorkHourseNoOk(@RequestParam Map params) {
        System.out.println("接收到的参数是" + params);
        int row = userService.updateWorkHourseNoOk(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*一键审核工时通过*/
    @RequestMapping("/updateAllWorkHourseOK")
    public @ResponseBody
    String updateAllWorkHourseOK(int id) {
        int row = userService.updateAllWorkHourseOK(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*跳转到审核不通过的地方*/
    @RequestMapping("/addReason")
    public String addReason() {
        return "User/addReason";
    }

    /*跳转到已经审核的地方*/
    @RequestMapping("/findAllWorkForMe")
    public String findAllWorkForMe() {
        return "User/showAllWorkHourseOK";
    }

    /*跳转到查看请假的界面*/
    @RequestMapping("/showAllLeaveHtml")
    public String showAllLeaveHtml() {
        return "User/showAllLeave";
    }

    /*跳转到申请请假界面*/
    @RequestMapping("/addleaveHtml")
    public String addleaveHtml() {
        return "User/addLeave";
    }

    /*添加请假记录*/
    @RequestMapping("/addleave")
    public @ResponseBody
    String addleave(@RequestParam Map params) {
        System.out.println("接受的参数是:" + params);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        try {
            Date beginTime = simpleDateFormat.parse((String) params.get("begintime"));
            Date endTime = simpleDateFormat.parse((String) params.get("endtime"));
            calendar.setTime(beginTime);
            int startDay = calendar.get(Calendar.DAY_OF_MONTH);
            calendar.setTime(endTime);
            int endDay = calendar.get(Calendar.DAY_OF_MONTH);
            int day = endDay - startDay;
            params.put("day", day);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int hrid = userService.findHrIdByUserId(Integer.parseInt((String) params.get("id")));
        params.put("hrid", hrid);
        params.put("time", new Date());
        params.put("result", 0);
        int row = userService.addLeave(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*查找请假记录*/
    @RequestMapping("/findAllLeave")
    public @ResponseBody
    Map findAllLeave(@RequestParam Map params, HttpSession session) {
        System.out.println("传过来的参数类型是：" + params.toString());
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        if (params.get("sort") == null) {
            params.put("sort", 1);
        }
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        System.out.println(user.toString() + user.getuId());
        List<Map> leaves = userService.findAllLeaver(params);
        int count = userService.findAllWorkHourseCount(params);
        Map result = new HashMap();
        result.put("data", leaves);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到请假待我审核界面*/
    @RequestMapping("/showAllLeaveForMe")
    public String showAllLeaveForMe() {
        return "User/showAllLeaveForMe";
    }

    /*跳转到审核不通过的输入理由的及没按*/
    @RequestMapping("/addLeaveReason")
    public String addLeaveReason() {
        return "User/addLeaveReason";
    }

    /*一键审核请假通过*/
    @RequestMapping("/updateAllLeaveOK")
    public @ResponseBody
    String updateAllLeaveOK(int id) {
        int row = userService.updateAllLeaveOK(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*审核通过*/
    @RequestMapping("/updateLeaveOk")
    public @ResponseBody
    String updateLeaveOk(int id) {
        int row = userService.updateLeaveOk(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*审核工时不通过*/
    @RequestMapping("/updateLeaveNoOk")
    public @ResponseBody
    String updateLeaveNoOk(@RequestParam Map params) {
        System.out.println("接收到的参数是" + params);
        int row = userService.updateLeaveNoOk(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*查看我已经审核*/
    @RequestMapping("/findAllLeaveForMe")
    public String findAllLeaveForMe() {
        return "User/showAllLeaveOK";
    }

    /*跳转到收件箱界面*/
    @RequestMapping("/showInboxHtlm")
    public String showInboxHtlm() {
        return "User/showAllInBox";
    }

    /*跳转到发件箱界面*/
    @RequestMapping("/showOutboxHtlm")
    public String showOutboxHtlm() {
        return "User/showAllOutBox";
    }

    /*跳转到添加写信的界面*/
    @RequestMapping("/addemailHtml")
    public String addemail() {
        return "User/addemail";
    }

    /*添加email*/
    @RequestMapping("/addemail")
    public @ResponseBody
    String addemail(@RequestParam Map params, MultipartFile file, HttpSession session) {
        User user = (User) session.getAttribute("user");
        System.out.println(params.toString() + user.toString());
        String filename = file.getOriginalFilename();
        params.put("time", new Date());
        params.put("sendid", user.getuId());
        params.put("state", 0);
        if (filename != null && filename != "") {
            /*存储文件的路径*/
            String path = "D:\\file\\";
            /*获得图片的原始名称，包括文件格式*/
            params.put("filename", filename);
            /*使用UUID给图片生成一个新的名称 uuid+文件类型*/
            String filepath = UUID.randomUUID() + filename.substring(filename.lastIndexOf("."));
            params.put("filepath", filepath);
            /*生成一个新的文件对象*/
            File newfile = new File(path + filepath);
            /*写入到磁盘*/
            try {
                file.transferTo(newfile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        int row = userService.addemail(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*查找邮件*/
    @RequestMapping("/findAllemai")
    public @ResponseBody
    Map findAllemai(@RequestParam Map params, HttpSession session) {
        System.out.println("传过来的参数类型是：" + params.toString());
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        System.out.println(user.toString() + user.getuId());
        List<Map> emails = userService.findAllEmail(params);
        int count = userService.findAllEmailCount(params);
        Map result = new HashMap();
        result.put("data", emails);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到收件箱界面*/
    @RequestMapping("/showAllinBoxHtml")
    public String showAllinBoxHtml() {
        return "User/showAllInBox";
    }

    /*删除邮件*/
    @RequestMapping("/deleteEmail")
    public @ResponseBody
    String deleteEmail(int id) {
        int row = userService.deleteEmaoById(id);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*跳转到回复界面*/
    @RequestMapping("/addReplyHtml")
    public String addReply() {
        return "User/addReply";
    }

    /*跳转到查看我发布的任务界面*/
    @RequestMapping("/findTaskByMeHtml")
    public String findTaskByMeHtml() {
        return "User/showAllTask";
    }

    /*查看我发布的任务*/
    @RequestMapping("/findAllTask")
    public @ResponseBody
    Map findAllTask(@RequestParam Map params, HttpSession session) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        System.out.println(user.toString() + user.getuId());
        List<Map> tasks = userService.findTastByMe(params);
        int count = userService.findTastByMeCount(params);
        Map result = new HashMap();
        result.put("data", tasks);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到添加任务界面*/
    @RequestMapping("/addTaskHtml")
    public String addTaskHtml() {
        return "User/addTask";
    }

    /*跳转到选择当前主管部门下的员工的界面*/
    @RequestMapping("/chosePeople")
    public String chosePeople() {
        return "User/choseDepartmentUser";
    }

    /*添加任务*/
    @RequestMapping("/addTask")
    public @ResponseBody
    String addTask(@RequestParam Map params, MultipartFile file, HttpSession session) {
        User user = (User) session.getAttribute("user");
        System.out.println(params.toString() + user.toString());
        String filename = file.getOriginalFilename();
        params.put("time", new Date());
        params.put("send", user.getuId());
        if (filename != null && filename != "") {
            /*存储文件的路径*/
            String path = "D:\\file\\";
            /*获得图片的原始名称，包括文件格式*/
            params.put("filename", filename);
            /*使用UUID给图片生成一个新的名称 uuid+文件类型*/
            String filepath = UUID.randomUUID() + filename.substring(filename.lastIndexOf("."));
            params.put("filepath", filepath);
            /*生成一个新的文件对象*/
            File newfile = new File(path + filepath);
            /*写入到磁盘*/
            try {
                file.transferTo(newfile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        int row = userService.addTask(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*跳转到查看我的任务界面*/
    @RequestMapping("/findMyTaskHtml")
    public String findMyTask() {
        return "User/showMyTask";
    }

    /*查看我的任务*/
    @RequestMapping("/findMyTask")
    public @ResponseBody
    Map findMyTask(@RequestParam Map params, HttpSession session) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        /*获得主管的ID*/
        int manid = userService.findManIdThrowUserId(id);
        params.put("id", id);
        params.put("manid", manid);
        System.out.println(user.toString() + user.getuId());
        List<Map> tasks = userService.findMyTask(params);
        int count = userService.findMyTaskCount(params);
        Map result = new HashMap();
        result.put("data", tasks);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到查看我的调动申请界面*/
    @RequestMapping("/showMyHumanApplicationHtml")
    public String showMyHumanApplicationHtml() {
        return "User/showMyHumanApplication";
    }

    /*跳转到调动申请界面*/
    @RequestMapping("/addTransferHtml")
    public String addTransferHtml() {
        return "User/addTransferHtml";
    }

    @RequestMapping("/addHumanTran")
    public @ResponseBody
    String addHumanTran(@RequestParam Map params, HttpSession session) {
        User user = (User) session.getAttribute("user");
        int localHrId = userService.findHrIdByUserId(user.getuId());
        int departmentId = Integer.parseInt((String) params.get("departmentId"));
        //  根据部门ID得到部门主管人事ID
        int remoteHrId = userService.findHrIdByDepartmentId(departmentId);
        params.put("date", new Date());
        params.put("localHrId", localHrId);
        params.put("remoteHrId", remoteHrId);
        params.put("id", user.getuId());
        int row = userService.addHumanTransfo(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*查找我申请的调动*/
    @RequestMapping("/findMyHumanApplication")
    public @ResponseBody
    Map findMyHumanApplication(@RequestParam Map params, HttpSession session) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        List<Map> tasks = userService.findMyHumanApplication(params);
        int count = userService.findMyHumanApplicationCount(params);
        Map result = new HashMap();
        result.put("data", tasks);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*跳转到查看调入申请*/
    @RequestMapping("/showHumanInApplicationHtml")
    public String showHumanInApplicationHtml() {
        return "User/showHumanInApplication";
    }

    /*跳转到查看调出申请*/
    @RequestMapping("/showHumanOutApplicationHtml")
    public String showHumanOutApplicationHtml() {
        return "User/showHumanOutApplication";
    }

    /*查找调入申请*/
    @RequestMapping("/findHumanInApplication")
    public @ResponseBody
    Map findHumanInApplication(@RequestParam Map params, HttpSession session) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        List<Map> tasks = userService.findHumanInApplication(params);
        int count = userService.findHumanInApplicationCount(params);
        Map result = new HashMap();
        result.put("data", tasks);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*调入审核通过*/
    @RequestMapping("/inApplicationIsOk")
    public @ResponseBody
    String inApplicationIsOk(int id) {
        /*调入审核通过*/
        int row = userService.inApplicationIsOk(id);
        Map result = userService.findResult(id);
        System.out.println("查询输出结果是：" + result);
        int localresult = (int) result.get("h_localConfirm");
        int remoteresult = (int) result.get("h_remoteConfirm");
        if (localresult == 1 && remoteresult == 1) {
            int finalResult = userService.updateFinalResult(id);
            if (finalResult > 0) {
                /*获取申请人ID*/
                Map message = userService.findUserIDByTran(id);
                /*审批通过，修改员工信息*/
                int result1 = userService.updateUserMessageWhereTrans(message);
                if (result1 > 0) {
                    System.out.println("审批成功，员工信息已经修改");
                }
            }
        }
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*调入审核不通过*/
    @RequestMapping("/inApplicationIsNoOk")
    public @ResponseBody
    String inApplicationIsNoOk(@RequestParam Map params) {
        int row = userService.inApplicationIsNoOk(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*查找调出申请*/
    @RequestMapping("/findHumanOutApplication")
    public @ResponseBody
    Map findHumanOutApplication(@RequestParam Map params, HttpSession session) {
        int page = Integer.parseInt((String) params.get("page"));
        int limit = Integer.parseInt((String) params.get("limit"));
        int start = (page - 1) * limit;
        params.put("start", start);
        params.put("limit", limit);
        User user = (User) session.getAttribute("user");
        int id = user.getuId();
        params.put("id", id);
        List<Map> tasks = userService.findHumanOutApplication(params);
        int count = userService.findHumanOutApplicationCount(params);
        Map result = new HashMap();
        result.put("data", tasks);
        result.put("count", count);
        result.put("code", 0);
        return result;
    }

    /*调出审核通过*/
    @RequestMapping("/outApplicationIsOk")
    public @ResponseBody
    String outApplicationIsOk(int id) {
        int row = userService.outApplicationIsOk(id);
        Map result = userService.findResult(id);
        System.out.println("查询输出结果是：" + result);
        int localresult = (int) result.get("h_localConfirm");
        int remoteresult = (int) result.get("h_remoteConfirm");
        if (localresult == 1 && remoteresult == 1) {
            int finalResult = userService.updateFinalResult(id);
            if (finalResult > 0) {
                /*获取申请人ID*/
                Map message = userService.findUserIDByTran(id);
                /*审批通过，修改员工信息*/
                int result1 = userService.updateUserMessageWhereTrans(message);
                if (result1 > 0) {
                    System.out.println("审批成功，员工信息已经修改");
                }
            }
        }
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /*调出审核不通过*/
    @RequestMapping("/outApplicationIsNoOk")
    public @ResponseBody
    String outApplicationIsNoOk(@RequestParam Map params) {
        int row = userService.outApplicationIsNoOk(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    @RequestMapping("/updateUserPassHtml")
    public String updateUserPass(int id, HttpServletRequest request) {
        request.setAttribute("id", id);
        return "User/updateUserPassHtml";
    }

    @RequestMapping("/userUpdatePass")
    public @ResponseBody
    String userUpdatePass(@RequestParam Map params) {
        int row = userService.userUpdatePass(params);
        if (row > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
}
