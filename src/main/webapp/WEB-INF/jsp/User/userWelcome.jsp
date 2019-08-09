<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工首页</title>
    <script type="text/javascript" src="#{pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userMain/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userMain/home.css">
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.min.js"></script>
</head>
<body>
<div class="article toolbar">
    <div class="title ue-clear">
        <h2>常用功能</h2>
    </div>
    <div class="content">
        <ul class="toollist ue-clear">
            <li>
                <a href="showAllinBoxHtml.action" class="img" target="right"><img src="${pageContext.request.contextPath}/img/userMain/email03.png" /></a>
                <p><a href="showAllinBoxHtml.action" target="right">邮箱</a></p>
            </li>
            <li>
                <a href="showAllNoticeHtml.action" class="img" target="right"><img src="${pageContext.request.contextPath}/img/userMain/icon02.png" /></a>
                <p><a href="showAllNoticeHtml.action" target="right">公告管理</a></p>
            </li>
            <li>
                <a href="showAllLeaveHtml.action" class="img"><img src="${pageContext.request.contextPath}/img/userMain/leave01.png" /></a>
                <p><a href="showAllLeaveHtml.action">请假申请</a></p>
            </li>
        </ul>

    </div>
</div>
</body>
</html>
