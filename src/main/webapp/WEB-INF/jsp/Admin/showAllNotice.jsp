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
            , url: 'findAllNotice.action' //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'a_id', title: 'ID', width: 80,}
                , {field: 'a_title', title: '公告标题', width: 131}
                , {field: 'a_time', title: '下达时间', width: 134}
                , {
                    field: 'a_content',
                    title: '公告内容',
                    width: 540
                }
                , {
                    field: 'a_fileName',
                    title: '附件名称',
                    width: 590,
                }
                , {
                    field: 'a_filePath',
                    title: '下载附件',
                    width: 176,
                }

            ]]
            , done: function (res, page, count) {
                $("[data-field='a_filePath']").children().each(function () {
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
</body>
</html>
