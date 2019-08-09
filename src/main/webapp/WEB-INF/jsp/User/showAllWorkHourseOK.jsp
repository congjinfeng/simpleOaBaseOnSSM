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
    /*加载表格*/
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#table'
            , height: 650
            , url: 'findWorkHourse.action'
            //数据接口
            , where: {
                "sort": 5
            }
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'w_id', title: 'ID', width: 80, sort: true}
                , {field: 'applicationname', title: '申请人姓名', width: 131}
                , {field: 'approvername', title: '审批人姓名', width: 134}
                , {field: 'w_time', title: '工时填报时间', width: 118}
                , {field: 'w_workDetail', title: '工作详情', width: 783}
                , {field: 'w_workTime', title: '工作时长', width: 103}
                , {field: 'w_approverOpintion', title: '审核人意见', width: 146}
                , {field: 'w_confirm', title: '审核结果', width: 197}
            ]]
            , done: function (res, page, count) {
                $("[data-field='w_confirm']").children().each(function () {
                    if ($(this).text() == '0') {
                        $(this).text("未审核")
                    } else if ($(this).text() == '1') {
                        $(this).text("审核通过")
                    } else if ($(this).text() == '2') {
                        $(this).text("审核不通过")
                    }
                })
            }
        })
    });

</script>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<table id="table" lay-filter="test"></table>
</div>
</body>
</html>
