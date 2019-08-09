<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加请假</title>
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
        var begintime = $("#begintime").val();
        var endtime = $("#endtime").val();
        if (begintime != null && endtime != null&&new Date(Date.parse(begintime))<=new Date(Date.parse(endtime))) {
            $.ajax({
                type: "post",
                data: {
                    "id": ${sessionScope.user.uId},
                    "begintime": begintime,
                    "endtime": endtime
                },
                url: "addleave.action",
                success: function (data) {
                    if (data == "success") {
                        layui.use("layer", function () {
                            layer.msg("添加成功，即将刷新界面", {icon: 1, time: 2000})
                        })
                        setTimeout("refresh()", 2000);
                    } else {
                        layui.use("layer", function () {
                            layer.msg("添加失败", {icon: 5, time: 2000})
                        })
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.msg("抱歉，结束时间要在开始时间之后,且都不可以为空，请重新选择", {icon: 5, time: 2000})
            })
        }
    }

    layui.use("laydate", function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#begintime',
            min: 0,
            max: 14
        })

        laydate.render({
            elem: '#endtime',
            min:1,
            max: 14
        });
    })
</script>
<body>
<div class="x-body layui-anim layui-anim-up">
    <div class="layui-form-item">
        <label for="begintime" class="layui-form-label">
            <span class="x-red">*</span>起始日(含)
        </label>
        <div class="layui-input-inline">
            <input type="text" id="begintime" required
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label for="endtime" class="layui-form-label">
            <span class="x-red">*</span>结束日(不含)
        </label>
        <div class="layui-input-inline">
            <input type="text" id="endtime" required
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

</div>

</body>
</html>
