<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    $(function () {
        $("#name").blur(function () {
            var reg = /^[\u4e00-\u9fa5]{1,}((·[\u4e00-\u9fa5]{1,}){0,3})$/;
            if (reg.test($(this).val())) {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("账号可用", "#name", {tips: [2, "green"], time: 2000})
                })
            } else {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("账号不可用，必须是全中文", "#name", {tips: [2, "red"], time: 2000})
                })
            }
        });
        $("#phone").blur(function () {
            var reg = /^1\d{10}$/;
            if (reg.test($(this).val())) {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("电话格式正确", "#phone", {tips: [2, "green"], time: 1500})
                })
            } else {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("电话格式错误，必须是1开头的11位，", "#phone", {tips: [2, "red"], time: 2000})
                })
            }
        });
        $("#pass").blur(function () {
            if ($(this).val().length < 6) {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("密码长度最少是6，请重新输入", "#pass", {tips: [2, "red"], time: 1500})
                })
            } else {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("电话格式错误，必须是1开头的11位，", "#phone", {tips: [2, "red"], time: 2000})
                })
            }
        });
        $("#email").blur(function () {
            var reg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
            if (reg.test($(this).val())) {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("邮箱格式正确", "#email", {tips: [2, "green"], time: 1500})
                })
            } else {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("邮箱格式错误,正确格式如：123qwe@qwe.com", "#email", {tips: [2, "red"], time: 2000})
                })
            }
        });
    });

    function refresh() {
        window.close();
        window.opener.location.reload();
    }

    function submitDate() {
        var namereg = /^[\u4e00-\u9fa5]{1,}((·[\u4e00-\u9fa5]{1,}){0,3})$/;
        var phonereg = /^1\d{10}$/;
        var emailreg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        var name = $("#name").val();
        var phone = $("#phone").val();
        var email = $("#email").val();
        var card = $("#card").val();
        var pass = $("#pass").val();
        var department = $("#department").val();
        var position = $("#position option:selected").val();
        if (namereg.test(name) && phonereg.test(phone) && emailreg.test(email)) {
            if (name != null && phone != null && email != null && card != null && pass != null && department != null && position != null) {
                $.ajax({
                    type: "post",
                    data: {
                        "name": name,
                        "phone": phone,
                        "email": email,
                        "card": card,
                        "position": position,
                        "department": department,
                        "pass": pass,
                        "id":${user.u_id}
                    },
                    url: "updateUser.action",
                    success: function (data) {
                        alert(data);
                        if (data == "success") {
                            layui.use("layer", function () {
                                var layer = layui.layer;
                                layer.msg("修改成功，即将刷新界面", {icon: 1, time: 2000})
                            })
                            setTimeout("refresh()", 2000);
                        } else if (data == "fail") {
                            layui.use("layer", function () {
                                var layer = layui.layer;
                                layer.msg("修改失败", {icon: 5, time: 2000})
                            })
                        }
                        else if (data == "exits") {
                            layui.use("layer", function () {
                                var layer = layui.layer;
                                layer.msg("部门已经存在主管或者人事主管", {icon: 5, time: 2000})
                            })
                        }
                    }
                })
            } else {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("存在空数据，请重新检查", "#submitDate", {tips: [2, "red"], time: 1500})
                })
            }

        } else {
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.tips("存在数据格式不正确，请仔细检查", "#submitDate", {tips: [2, "red"], time: 1500})
            })
        }

    }

    /*选择部门*/
    function choseDepartment() {
        var height = 500;
        var width = 1800;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("choseDepartment.action", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>
<body>
<div class="x-body layui-anim layui-anim-up">
    <div class="layui-form-item">
        <label for="name" class="layui-form-label">
            <span class="x-red">*</span>员工姓名
        </label>
        <div class="layui-input-inline">
            <input type="text" id="name" required
                   class="layui-input" value="${user.u_name}" disabled="disabled" style="cursor: not-allowed">
        </div>
    </div>
    <div class="layui-form-item">
        <label for="pass" class="layui-form-label">
            <span class="x-red">*</span>密码
        </label>
        <div class="layui-input-inline">
            <input type="text" id="pass" required
                   class="layui-input" value="${user.u_pass}">
        </div>
    </div>

    <div class="layui-form-item">
        <label for="phone" class="layui-form-label">
            <span class="x-red">*</span>联系电话
        </label>
        <div class="layui-input-inline">
            <input type="text" id="phone" required
                   class="layui-input" value="${user.u_phone}">
        </div>
    </div>

    <div class="layui-form-item">
        <label for="email" class="layui-form-label">
            <span class="x-red">*</span>邮箱
        </label>
        <div class="layui-input-inline">
            <input type="text" id="email" required
                   class="layui-input" value="${user.u_email}">
        </div>
    </div>


    <div class="layui-form-item">
        <label for="card" class="layui-form-label">
            <span class="x-red"></span>银行卡号
        </label>
        <div class="layui-input-inline">
            <input type="text" id="card" required
                   class="layui-input" value="${user.u_card}">
        </div>
    </div>


    <div class="layui-form-item">
        <label for="position" class="layui-form-label">
            <span class="x-red">*</span>选择职位
        </label>
        <div class="layui-input-inline">
            <select name="city" id="position">
                <option value="主管" ${user.u_position eq '主管'?'selected':''}>主管</option>
                <option value="人事主管" ${user.u_position eq '人事主管'?'selected':''}>人事主管</option>
                <option value="正式员工" ${user.u_position eq '正式员工'?'selected':''}>正式员工</option>
                <option value="试用期员工" ${user.u_position eq '试用期员工'?'selected':''}>试用期员工</option>
                <option value="实习生" ${user.u_position eq '实习生'?'selected':''}>实习生</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="department" class="layui-form-label">
            <span class="x-red">*</span>选择部门
        </label>
        <div class="layui-input-inline" style="position: relative">
            <input type="text" id="department" required
                   class="layui-input" value="${user.d_id}">
            <button type="button" onclick="choseDepartment()">点击选择部门</button>
        </div>
    </div>

    <div class="layui-form-item">
        <label for="submitDate" class="layui-form-label">
        </label>
        <button class="layui-btn" id="submitDate" type="button" onclick="submitDate()">
            增加
        </button>
    </div>

</div>

</body>
</body>
</html>
