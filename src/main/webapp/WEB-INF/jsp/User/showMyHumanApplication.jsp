<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看我的调动申请</title>
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
            , url: 'findMyHumanApplication.action'
            //数据接口
            , page: true //开启分页
            ,where:{
                "sign":1
            }
            , cols: [[ //表头
                {field: 'h_id', title: 'ID', width: 80, sort: true}
                , {field: 'localhrname', title: '直属人事主管姓名', width: 148}
                , {field: 'departmentname', title: '申请调动部门', width: 114}
                , {field: 'h_postion', title: '调动职位', width: 91}
                , {field: 'remotehrname', title: '申请部门人事主管姓名', width: 185}
                , {field: 'h_reason', title: '调动原因', width: 125}
                , {field: 'h_date', title: '申请时间', width: 171}
                , {field: 'h_localApproverOpinion', title: '直属人事主管意见', width: 146}
                , {field: 'h_remoteApproverOpinion', title: '调动人事主管意见', width: 146}
                , {field: 'h_localConfirm', title: '直属人事审批结果', width: 146}
                , {field: 'h_remoteConfirm', title: '调动人事审批结果', width: 146}
                , {field: 'h_result', title: '最终结果', width: 146}
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

    /*添加*/
    function addTransfer() {
        var height = 600;
        var width = 800;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("addTransferHtml.action", "_blank",
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
    <xblock>
        <button class="layui-btn"
                onclick="addTransfer()">
            <i class="layui-icon"></i>申请调动
        </button>
    </xblock>
    <table id="table" lay-filter="test"></table>
</div>
</body>
</html>
