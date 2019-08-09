<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员主界面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
</head>
<script>
    function updatePassWord() {
        var height = 500;
        var width = 600;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("updatePasswordHtml.action?id=" +${sessionScope.admin.a_id}, "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>
<body>
<!-- 顶部开始 -->
<div class="container">
    <div class="logo"><a href="index.html">欢迎使用本系统</a></div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">${sessionScope.admin.a_name}</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
                <dd><a onClick="updatePassWord()">修改密码</a></dd>
                <dd><a href="logout.action">退出</a></dd>
            </dl>
        </li>
    </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe726;</i>
                    <cite>部门管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="findAllDepartmentHtml.action"><i class="iconfont">&#xe6a7;</i><cite>查看所有部门</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b8;</i>
                    <cite>员工管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="findAllUserHtml.action"><i class="iconfont">&#xe6a7;</i><cite>显示所有员工</cite></a></li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont"> &#xe69e;</i>
                    <cite>公告管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="addNoticeHtml.action"><i class="iconfont">&#xe6a7;</i><cite>发布公告</cite></a></li>
                    <li><a _href="showAllNoticeHtml.action"><i class="iconfont">&#xe6a7;</i><cite>显示所有公告</cite></a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>我的主页</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='/grade/adminWelcome.action' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
</body>
</html>
