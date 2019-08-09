<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看所有的任务</title>
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
        window.location.reload();
    }

    /*加载表格*/
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#table'
            , height: 650
            , url: 'findAllTask.action'
            //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 't_id', title: 'ID', width: 80, sort: true}
                , {field: 't_title', title: '任务标题', width: 131}
                , {field: 'sendname', title: '发送人', width: 134}
                , {field: 't_receiveSort', title: '接收类型', width: 118}
                , {field: 'receivename', title: '接收人', width: 92}
                , {field: 't_message', title: '任务内容', width: 462}
                , {field: 't_time', title: '发送时间', width: 109}
                , {field: 't_filename', title: '附件名称', width: 325}
                , {field: 't_filepath', title: '下载附件', width: 197}
            ]]
            , done: function (res, page, count) {
                $("[data-field='t_filepath']").children().each(function () {
                    if ($(this).text() == '下载附件') {
                        $(this).text("下载附件")
                    } else if ($(this).text() == '') {
                        $(this).text("没有附件")
                    } else {
                        $(this).html("<a href=" + '/file/' + $(this).text() + "><button class='layui-btn layui-btn-normal'>点击下载附件<button></a>")
                    }
                })
            }
        })
    });

    /*添加任务*/
    function addTask() {
        var height = 800;
        var width = 1200;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        if(${sessionScope.user.uPosition=='主管'}){
            window.open("addTaskHtml.action", "_blank",
                "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
        }else{
            layui.use("layer", function () {
                var layer = layui.layer;
                layer.msg("抱歉，您没有权限发布任务", {icon: 5, time: 2000})
            })
        }

    }
</script>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<div class="x-body">
    <xblock>
        <button class="layui-btn"
                onclick="addTask()">
            <i class="layui-icon"></i>发布任务
        </button>
    </xblock>
    <table id="table" lay-filter="test"></table>
</div>
</body>
</html>
