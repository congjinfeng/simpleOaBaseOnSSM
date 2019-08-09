<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userMain/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userMain/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userMain/jquery.dialog.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/userMain/core.js"></script>
    <script src="${pageContext.request.contextPath}/js/userMain/jquery.dialog.js"></script>
    <script src="${pageContext.request.contextPath}/js/userMain/index.js"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layer.js"></script>
</head>
<style>
    .layui-layer-title {
        background: url(../../../img/userMain/righttitlebig.png) repeat-x;
        font-weight: bold;
        color: #46647e;
        border: 1px solid #c1d3de;
        height: 33px;
        line-height: 33px;
    }
</style>
<script>
    function updatePassWord() {
        var height = 500;
        var width = 600;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("updateUserPassHtml.action?id=" +${sessionScope.user.uId}, "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>

<body>
<div id="container">
    <div id="hd">
        <div class="hd-wrap ue-clear">
            <div class="top-light"></div>
            <div class="login-info ue-clear">
                <div class="welcome ue-clear"><span>欢迎您,</span><a href="javascript:void(0)"
                                                                  class="user-name">${sessionScope.user.uName}</a></div>
                <%-- <div class="login-msg ue-clear">
                     <a href="javascript:void(0)" class="msg-txt">消息</a>
                     <a href="javascript:void(0)" class="msg-num">10</a>
                 </div>--%>
            </div>
            <div class="toolbar ue-clear">
                <a href="userWelcome.action" class="home-btn" target="right">首页</a>
                <a  class="home-btn1"  onClick="updatePassWord()">修改密码</a>
                <a href="/grade/logout.action" class="quit-btn exit home-btn">退出</a>
            </div>
        </div>
    </div>
    <div id="bd">
        <div class="wrap ue-clear">
            <div class="sidebar">
                <h2 class="sidebar-header"><p>功能导航</p></h2>
                <ul class="nav">
                    <li class="office current">
                        <div class="nav-header"><a href="userWelcome.action" target="right"
                                                   class="ue-clear"><span>首页</span><i
                                class="icon"></i></a></div>
                    </li>
                    <li class="land">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear"><span>工时管理</span><i
                                class="icon hasChild"></i></a></div>
                        <ul class="subnav">
                            <li><a href="showWorkHourseHtml.action" target="right">查看我的工时</a></li>
                            <li><a href="findAllWorkHourseForMeHtml.action" target="right">查看待我审核</a></li>
                            <li><a href="findAllWorkForMe.action" target="right">查看我已审核</a></li>
                        </ul>
                    </li>
                    <li class="train">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear"><span>请假管理</span><i
                                class="icon hasChild"></i></a></div>
                        <ul class="subnav">
                            <li><a href="showAllLeaveHtml.action" target="right">查看我的请假</a></li>
                            <li><a href="showAllLeaveForMe.action" target="right">查看待我审核</a></li>
                            <li><a href="findAllLeaveForMe.action" target="right">查看我已审核</a></li>
                        </ul>
                    </li>
                    <li class="email">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear" target="right"><span>消息管理</span><i
                                class="icon"></i></a></div>
                        <ul class="subnav">
                            <li><a href="showAllinBoxHtml.action" target="right">收件箱</a></li>
                            <li><a href="showOutboxHtlm.action" target="right">发件箱</a></li>
                        </ul>
                    </li>
                    <li class="list_m">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear"
                                                   target="right"><span>人事调动管理</span><i
                                class="icon"></i></a></div>
                        <ul class="subnav">
                            <li><a href="showMyHumanApplicationHtml.action" target="right">查看我的申请</a></li>
                            <li><a href="showHumanOutApplicationHtml.action" target="right">查看调入申请</a></li>
                            <li><a href="showHumanInApplicationHtml.action" target="right">查看调出申请</a></li>
                        </ul>
                    </li>
                    <li class="dossier">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear"><span>任务管理</span><i
                                class="icon hasChild"></i></a></div>
                        <ul class="subnav">
                            <li><a href="findTaskByMeHtml.action" target="right">查看我发布的任务</a></li>
                            <li><a href="findMyTaskHtml.action" target="right">查看我的任务</a></li>
                        </ul>
                    </li>
                    <li class="part">
                        <div class="nav-header"><a href="JavaScript:;" class="ue-clear"><span>公告管理</span><i
                                class="icon hasChild"></i></a></div>
                        <ul class="subnav">
                            <li><a href="showAllNoticeHtml.action" target="right">查看公告</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="content">
                <iframe src="userWelcome.action" id="iframe" width="100%" height="100%" frameborder="0" name="right"
                        style="min-width: 1100px"></iframe>
            </div>
        </div>
    </div>
</div>
</body>
</html>
