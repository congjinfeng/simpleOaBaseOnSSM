<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员首页</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    var zNodes;
    var setting = {
        data: {
            key: {
                name: "d_name"//数据库的名字  默认name
            },
            simpleData: {
                enable: true,
                idKey: "d_id",//数据库的id  默认id
                pIdKey: "d_pid",//数据库的父节点id  默认pid
            },
        },
        callback: {
            //onClick: onCheck
        }
    };

    function Inint() {//初始化加载节点
        $.ajax({
            global: true,
            async: false,
            cache: false,
            dataType: "json",
            url: "findAllDepartment.action",
            type: "post",
            success: function (data) {
                zNodes = data;

            }
        });
    };
    $(function () {
        Inint(); //加载数据
        $.fn.zTree.init($("#zTree"), setting, zNodes);
        var treeObj = $.fn.zTree.getZTreeObj("zTree");
        var nodes = treeObj.getNodes();
        for (var i = 0; i < nodes.length; i++) { //设置节点展开
            treeObj.expandNode(nodes[i], true, false, true);
        }
    });
    $(function () {
        showtime();
        setInterval("showtime()", 1000);
    });

    function showtime() {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var hour = date.getHours();
        var min = date.getMinutes();
        if (min < 10) {
            min = "0" + min;
        }
        var sec = date.getSeconds();
        $("#showtime").text(year + "年" + month + "月" + day + "日" + hour + ":" + min + ":" + sec)
    }

    /*获取数量*/

    $(function () {
        $.ajax({
            type: "POST",
            url: "findDepartmentCount.action",
            success: function (data) {
               $("#departmentNumber").text(data)
            }
        })
        $.ajax({
            type: "POST",
            url: "findUserNormalCount.action",
            success: function (data) {
                $("#usernormalCount").text(data)
            }
        })
        $.ajax({
            type: "POST",
            url: "findUserNoNormalCount.action",
            success: function (data) {
                $("#UsernoCount").text(data)
            }
        })
        $.ajax({
            type: "POST",
            url: "findUserCount.action",
            success: function (data) {
                $("#userCount").text(data)
            }
        })
        $.ajax({
            type: "POST",
            url: "inUserCount.action",
            success: function (data) {
                $("#inUserCount").text(data)
            }
        })
        $.ajax({
            type: "POST",
            url: "outUserCount.action",
            success: function (data) {
                $("#outUserCount").text(data)
            }
        })

    });


</script>
<body>
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<div class="x-body layui-anim layui-anim-up">
    <blockquote class="layui-elem-quote">欢迎管理员：
        <span class="x-red">${sessionScope.admin.a_name}</span>！当前时间是：<span class="x-red" id="showtime"></span>
    </blockquote>
    <fieldset class="layui-elem-field">
        <legend>数据统计</legend>
        <div class="layui-field-box">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside"
                             lay-arrow="none" style="width: 100%; height: 90px;">
                            <div carousel-item="">
                                <ul class="layui-row layui-col-space10 layui-this">
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>部门数量</h3>
                                            <p>
                                                <cite id="departmentNumber"></cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>员工数量</h3>
                                            <p>
                                                <cite id="userCount"></cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>正式员工数量</h3>
                                            <p>
                                                <cite id="usernormalCount"></cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>非正式员工数量</h3>
                                            <p>
                                                <cite id="UsernoCount"></cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>本月新招员工数量</h3>
                                            <p>
                                                <cite id="inUserCount"></cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>本月离职员工数量</h3>
                                            <p>
                                                <cite id="outUserCount"></cite></p>
                                        </a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>部门架构</legend>
        <ul id="zTree" class="ztree"></ul>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>开发团队</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <tbody>
                <tr>
                    <th>开发者</th>
                    <td>从进峰</td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>

</body>
</html>
