<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加工时</title>
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
        var time = $("#time option:selected").val();
        var content = $("#content").val();
        if (time != null && content != null) {
            $.ajax({
                type: "post",
                data: {
                    "id": ${sessionScope.user.uId},
                    "time": time,
                    "content": content
                },
                url: "addWorkHourse.action",
                success: function (data) {
                    if (data=="success") {
                        layui.use("layer",function () {
                            layer.msg("添加成功，即将刷新界面", {icon: 1, time: 2000})
                        })
                        setTimeout("refresh()", 2000);
                    } else {
                        layui.use("layer",function () {
                            layer.msg("添加失败,今日工时已经添加", {icon: 5, time: 2000})
                        })
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.tips("存在数据格式不正确，请仔细检查", "#submitDate", {tips: [2, "red"], time: 1500})
            })
        }
    }
</script>
<body>
<div class="x-body layui-anim layui-anim-up">
    <div class="layui-form-item">
        <label for="time" class="layui-form-label">
            <span class="x-red">*</span>工作时间，满勤为8
        </label>
        <div class="layui-input-inline">
            <select name="city" id="time">
                <option value="4">4</option>
                <option value="8" selected="selected">8</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label for="content" class="layui-form-label">
            <span class="x-red">*</span>主要工作内容
        </label>
        <div class="layui-input-inline">
            <textarea name="content" id="content" cols="50" rows="20"></textarea>
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
