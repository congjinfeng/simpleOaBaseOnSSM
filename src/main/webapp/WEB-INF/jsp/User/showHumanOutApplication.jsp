<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看调入申请</title>
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
            , url: 'findHumanOutApplication.action'
            //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'h_id', title: 'ID', width: 60, sort: true}
                , {field: 'applicationname', title: '申请人姓名', width: 107}
                , {field: 'localhrname', title: '直属人事主管姓名', width: 142}
                , {field: 'olddepartmentname', title: '原部门名称', width: 102}
                , {field: 'departmentname', title: '申请调入部门名称', width: 146}
                , {field: 'h_postion', title: '调动职位', width: 91}
                , {field: 'h_reason', title: '调动原因', width: 125}
                , {field: 'h_date', title: '申请时间', width: 171}
                , {field: 'h_localApproverOpinion', title: '直属人事主管意见', width: 144}
                , {field: 'h_remoteApproverOpinion', title: '调动人事主管意见', width: 142}
                , {field: 'h_localConfirm', title: '直属人事审批结果', width: 142}
                , {field: 'h_remoteConfirm', title: '调动人事审批结果', width: 146}
                , {fixed: 'right', title: '操作', width: 130, align: 'center', toolbar: '#barDemo'}
            ]]
            , done: function (res, page, count) {
                $("[data-field='h_localConfirm']").children().each(function () {
                    if ($(this).text() == '0') {
                        $(this).text("未审批")
                    } else if ($(this).text() == '1') {
                        $(this).text("审批通过")
                    } else if ($(this).text() == '2') {
                        $(this).text("审批不通过")
                    }
                })
                $("[data-field='h_remoteConfirm']").children().each(function () {
                    if ($(this).text() == '调动人事审批结果') {
                        $(this).text("调动人事审批结果")
                    } else if ($(this).text() == '0') {
                        $(this).text("未审批")
                    } else if ($(this).text() == '1') {
                        $(this).text("审批通过")
                    } else if ($(this).text() == '2') {
                        $(this).text("审批不通过")
                    }
                })
                $("[data-field='h_result']").children().each(function () {
                    if ($(this).text() == '最终结果') {
                        $(this).text("最终结果")
                    } else if ($(this).text() == '0') {
                        $(this).text("未通过")
                    } else if ($(this).text() == '1') {
                        $(this).text("审批通过")
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
            var id = data.h_id;
            var confirm = data.h_localConfirm;
            if (layEvent === 'ok') { //
                if (confirm == 0) {
                    $.ajax({
                        type:"post",
                        url:"outApplicationIsOk.action",
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
                        layer.msg("当前已经审核通过,请勿重复提交", {icon: 5, time: 1000});
                    })
                }
            } else if (layEvent === 'nook') {
                layui.use("layer", function () {
                    var layer = layui.layer;
                    if(confirm==0){
                        layer.prompt({title: '请简述不通过的原因，并确认', formType: 2}, function(content, index){
                            layer.close(index);
                            var content=content;
                            if (confirm == 0) {
                                $.ajax({
                                    type:"post",
                                    url:"outApplicationIsNoOk.action",
                                    data:{"id":id,"content":content},
                                    success:function (result) {
                                        if(result=="success"){
                                            window.location.reload();
                                        }
                                    }
                                })
                            }
                        });
                    } else {
                        layui.use("layer", function () {
                            var layer = layui.layer;
                            layer.msg("当前已经审核,请勿重复提交", {icon: 5, time: 1000});
                        })
                    }
                })
            }
        });
    });

</script>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.reload()" title="刷新本页面">
        <i class="layui-icon" style="line-height:38px">ဂ</i></a>
</div>
<div class="x-body">
    <table id="table" lay-filter="test"></table>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="ok">通过</a>
    <a class="layui-btn layui-btn-xs" lay-event="nook">不通过</a>
</script>
</body>
</html>
