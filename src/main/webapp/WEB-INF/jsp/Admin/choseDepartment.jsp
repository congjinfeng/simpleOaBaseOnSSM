<%--
  User: cong
  Date: 2019/5/12
  Time: 16:40
--%>
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

    /*重载表格*/
    function findByCondition() {
        var name = $("#name").val();
        var manname = $("#manname").val();
        var hrname = $("#hrname").val();
        layui.use('table', function () {
            var table = layui.table;
            //第一个实例
            table.reload("table", {
                height: 650
                , url: 'findAllDepartmentByTable.action' //数据接口
                , where: {"name": name, "manname": manname, "hrname": hrname}

            });
        });
    }

    /*加载表格*/
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#table'
            , height: 650
            , url: 'findAllDepartmentByTable.action' //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'd_id', title: 'ID', width: 80, sort: true}
                , {field: 'd_name', title: '部门名称', width: 170}
                , {field: 'manname', title: '部门主管姓名', width: 170, sort: true}
                , {field: 'manphone', title: '部门主管联系方式', width: 170}
                , {field: 'manemail', title: '部门主管邮件', width: 170}
                , {field: 'hrname', title: '部门人事主管', width: 170}
                , {field: 'hrphone', title: '部门人事主管联系方式', width: 170}
                , {field: 'hremail', title: '部门人事主管邮件', width: 170}
                , {field: 'upname', title: '上级部门', width: 170}
                , {fixed: 'right', title: '操作', width: 190, align: 'center', toolbar: '#barDemo'}
            ]]
        })
    });
    /*操作*/
    layui.use('table', function () {
        var table = layui.table;
        table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            var id = data.d_id;
            if (layEvent === 'chose') {
                layer.confirm('确定选择么', function (index) {
                    layer.close(index);
                    if(data.d_id==1){
                        layer.msg("不可以选择总公司",{icon:5,time:1000})
                    }else{
                        window.opener.document.getElementById("department").value = data.d_id;
                        window.close()
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
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <input type="text" id="name" placeholder="部门名称" class="layui-input">
            <input type="text" id="manname" placeholder="主管名称" class="layui-input">
            <input type="text" id="hrname" placeholder="人事主管名称" class="layui-input">
            <button class="layui-btn" type="button" onclick="findByCondition()"><i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>
    <table id="table" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="chose">选择</a>
    </script>


</div>
</body>
</html>
