<%--
  User: cong
  Date: 2019/5/15
  Time: 17:00
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
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
        $("#repass").blur(function () {
            if ($(this).val() != $("#pass").val()) {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    layer.tips("两次输入密码不一致，请重新输入", "#repass", {tips: [2, "red"], time: 2000})
                })
            }
        });
    });

    function submitDate() {
        if ($("#pass").val() == $("#repass").val()) {
            var pass = $("#repass").val();
            $.ajax({
                type: "post",
                url: "userUpdatePass.action",
                data: {"id":${requestScope.id}, "pass": pass},
                success: function (data) {
                    if (data == "success") {
                        layui.use("layer", function () {
                            var layer = layui.layer;
                            layer.msg("修改成功，即将跳转到登录界面", {icon: 1, time: 2000})
                        })
                        setTimeout(function () {
                            window.close();
                          window.opener.location="logout.action"
                        },2000)
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.tips("两次输入密码不一致，请重新输入", "#submitDate", {tips: [2, "red"], time: 2000})
            })
        }
    }
</script>

<body>
<div class="layui-form-item">
    <label for="pass" class="layui-form-label">
        <span class="x-red">*</span>输入密码
    </label>
    <div class="layui-input-inline">
        <input type="password" id="pass" required
               class="layui-input">
    </div>
</div>
<div class="layui-form-item">
    <label for="repass" class="layui-form-label">
        <span class="x-red">*</span>请再次输入密码
    </label>
    <div class="layui-input-inline">
        <input type="password" id="repass" required
               class="layui-input">
    </div>
</div>
<div class="layui-form-item">
    <label for="submitDate" class="layui-form-label">
    </label>
    <button class="layui-btn" id="submitDate" type="button" onclick="submitDate()">
        增加
    </button>
</div>
</body>
</html>
