<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>写信</title>
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
</script>
<body>
<form  action="/grade/addemail.action" class="layui-form layui-col-md12 x-so" id="form" enctype="multipart/form-data"
       method="post">
    <div class="x-body layui-anim layui-anim-up">
        <div class="layui-form-item">
            <label for="content" class="layui-form-label">
                <span class="x-red">*</span>内容
            </label>
            <div class="layui-input-inline">
                <textarea name="content" id="content" cols="80" rows="20"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="file" class="layui-form-label">
                <span class="x-red"></span>上传文件
            </label>
            <div class="layui-input-inline">
                <input type="file" name="file" id="file">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="submitDate" class="layui-form-label">
            </label>
            <button class="layui-btn" id="submitDate" type="submit">
                增加
            </button>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <input type="hidden" value="<%=request.getParameter("id")%>" id="va" name="man">
            </div>
        </div>
    </div>
</form>
</body>
</html>
