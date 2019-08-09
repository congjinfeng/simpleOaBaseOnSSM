<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加理由</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/Layui/layer.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    function refresh() {
        window.close();
        window.opener.location.reload();
    }
    function sub() {
        var id=$("#va").val();
        var reason = $("#reason").val();
        if (reason != null && reason != '') {
            $.ajax({
                type: "post",
                data: {
                    "id": id,
                    "reason": reason
                },
                url: "updateWorkHourseNoOk.action",
                success: function (data) {
                    if (data == "success") {
                        layui.use("layer", function () {
                            var layer = layui.layer;
                            layer.msg("成功成功,即将刷新界面", {icon: 1, time: 2000})
                        })
                        setTimeout("refresh()", 2000);
                    } else {
                        layui.use("layer", function () {
                            var layer = layui.layer;
                            layer.msg("添加失败", {icon: 5, time: 2000})
                        })
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.tips("存在数据格式不正确,请仔细检查","#submitDate", {tips: [2, "red"], time: 1500})
            })
        }
    }

</script>
<body>
<div class="x-body layui-anim layui-anim-up">
    <div class="layui-form-item">
        <label for="reason" class="layui-form-label">
            <span class="x-red">*</span>请简述审核不通过的原因
        </label>
        <div class="layui-input-inline">
            <textarea name="content" id="reason" cols="80" rows="20"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="submitDate" class="layui-form-label">
        </label>
        <button class="layui-btn" id="submitDate" type="button" onclick="sub()">
            增加
        </button>
    </div>
   <input type="hidden" value="<%=request.getParameter("id")%>" id="va">

</div>
</body>
</html>
