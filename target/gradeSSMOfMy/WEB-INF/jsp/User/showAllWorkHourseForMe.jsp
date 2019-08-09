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
    <script src="${pageContext.request.contextPath}/js/Layui/layer.js" charset="utf-8"></script>
</head>
<script>
    /*加载表格*/
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#table'
            , height: 650
            , url: 'findAllWorkHourseForMe.action'
            //数据接口
            , where: {
                "sort": '4'
            }
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'w_id', title: 'ID', width: 80, sort: true}
                , {field: 'applicationname', title: '申请人姓名', width: 131}
                , {field: 'approvername', title: '审批人姓名', width: 134}
                , {field: 'w_time', title: '工时填报时间', width: 118}
                , {field: 'w_workDetail', title: '工作详情', width: 589}
                , {field: 'w_workTime', title: '工作时长', width: 103}
                , {field: 'w_approverOpintion', title: '审核人意见', width: 146}
                , {field: 'w_confirm', title: '审核结果', width: 197}
                , {fixed: 'right', title: '操作', width: 190, align: 'center', toolbar: '#barDemo'}
            ]]
            , done: function (res, page, count) {
                $("[data-field='w_confirm']").children().each(function () {
                    if ($(this).text() == '0') {
                        $(this).text("未审核")
                    } else if ($(this).text() == '1') {
                        $(this).text("审核通过")
                    }
                })
            }
        })
    });
    /*操作*/
    layui.use('table', function () {
        var table = layui.table;
        table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            var id = data.w_id;
            var confirm = data.w_confirm;
            if (layEvent === 'ok') { //
                if (confirm == 0) {
                    $.ajax({
                        type:"post",
                        url:"updateWorkHourseOk.action",
                        data:{"id":id},
                        success:function (result) {
                            if(result=="success"){
                                window.location.reload();
                            }
                        }
                    })
                } else {
                    layui.use("layer", function () {
                        var layer = layui.layer;
                        layer.msg("当前已经审核通过,请勿重复提交", {icon: 5, time: 200});
                    })
                }
            } else if (layEvent === 'nook') {
                var height = 500;
                var width = 800;
                var top = Math.round((window.screen.height - height) / 2);
                var left = Math.round((window.screen.width - width) / 2);
                window.open("addReason.action?id="+id, "_blank",
                    "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
            }
        });
    });
    function allisok() {
        $.ajax({
            type:"post",
            url:"updateAllWorkHourseOK.action",
            data:{"id":${sessionScope.user.uId}},
            success:function (result) {
                if(result=="success"){
                    window.location.reload();
                }
            }
        })
    }
</script>
<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<xblock>
    <button class="layui-btn"
            onclick="allisok()">
        <i class="layui-icon"></i>一键通过
    </button>
</xblock>
<table id="table" lay-filter="test"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="ok">审核通过</a>
    <a class="layui-btn layui-btn-xs" lay-event="nook">审核不通过</a>
</script>
</body>
</html>
