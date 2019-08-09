<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请调动</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    function refresh() {
        window.close();
        window.opener.location.reload();
    }

    function submitDate() {
        var departmentId = $("#department").val();
        var reason = $("#reason").val();
        var position = $("#position").val();
        $.ajax({
            type: "post",
            data: {"departmentId": departmentId, "reason": reason,"position":position},
            url: "addHumanTran.action",
            success: function (data) {
                if (data == "success") {
                    layui.use("layer",function () {
                        layer=layui.laydate;
                        layer.msg("添加成功，即将刷新界面", {icon: 1, time: 2000})
                    })
                    setTimeout("refresh()",2000);
                } else {
                    layer.msg("添加失败", {icon: 5, time: 2000})
                }
            }
        })
    }


    /*选择收件人*/
    function chosePeople() {
        var height = 800;
        var width = 2000;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("choseDepartment.action?", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>
<body>
<div class="layui-form-item" id="chosePeople">
    <label for="department" class="layui-form-label">
        <span class="x-red">*</span>调动部门
    </label>
    <div class="layui-input-inline" style="position: relative">
        <input type="text" id="department"
               class="layui-input">
        <button type="button" onclick="chosePeople()">点击选择要调往的部门</button>
    </div>
</div>

<div class="layui-form-item">
    <label for="position" class="layui-form-label">
        <span class="x-red">*</span>选择职位
    </label>
    <div class="layui-input-inline">
        <select name="city" id="position">
            <option value="主管">主管</option>
            <option value="人事主管">人事主管</option>
            <option value="正式员工">正式员工</option>
            <option value="试用期员工" selected="selected">试用期员工</option>
            <option value="实习生">实习生</option>
        </select>
    </div>
</div>
<div class="layui-form-item">
    <label for="reason" class="layui-form-label">
        <span class="x-red">*</span>调动原因
    </label>
    <div class="layui-input-inline">
        <textarea name="message" id="reason" cols="80" rows="20"></textarea>
    </div>
</div>

<div class="layui-form-item">
    <label for="submitDate" class="layui-form-label">
    </label>
    <button class="layui-btn" id="submitDate" type="submit" onclick="submitDate()">
        申请
    </button>
</div>

</body>
</html>
