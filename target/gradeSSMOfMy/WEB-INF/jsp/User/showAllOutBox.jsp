<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看所有部门</title>
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
    layui.use("laydate",function () {
        laydate=layui.laydate;
        laydate.render({
            elem: '#time',
            min: -180,
            max: 0
        })
    })

    /*重载表格*/
    function findByCondition() {
        var name = $("#name").val();
        var time = $("#time").val();
        layui.use('table', function () {
            var table = layui.table;
            //第一个实例
            table.reload("table", {
                height: 650
                ,
                url: 'findAllemai.action' //数据接口
                ,
                where: {
                    "sign":1,
                    "name": name,
                    "time":time
                }
            });
        });
    }

    /*加载表格*/
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#table'
            , height: 650
            , url: 'findAllemai.action'
            //数据接口
            , page: true //开启分页
            ,where:{
                "sign":1
            }
            , cols: [[ //表头
                {field: 'e_id', title: 'ID', width: 80, sort: true}
                , {field: 'receivename', title: '收件人姓名', width: 131}
                , {field: 'receivedepartmentname', title: '收件人所在部门名称', width: 166}
                , {field: 'e_sendTime', title: '发送时间', width: 122}
                , {field: 'e_message', title: '消息内容', width: 456}
                , {field: 'e_fileName', title: '附件名称', width: 550}
                , {field: 'e_filePath', title: '下载附件', width: 146}
            ]]
            , done: function (res, page, count) {
                $("[data-field='e_filePath']").children().each(function () {
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

    /*添加消息*/
    function addemail() {
        var height = 600;
        var width = 800;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("addemailHtml.action", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <input type="text" id="name" placeholder="收件人姓名" class="layui-input" >
            <input type="text" id="time" placeholder="发送时间" class="layui-input" >
            <button class="layui-btn" type="button" onclick="findByCondition()"><i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn"
                onclick="addemail()">
            <i class="layui-icon"></i>写信
        </button>
    </xblock>
    <table id="table" lay-filter="test"></table>
</div>
</body>
</html>
