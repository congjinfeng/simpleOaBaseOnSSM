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
        var username = $("#username").val();
        var name = $("#name").val();
        var usernum = $("#usernum").val();
        var position = $("#position option:selected").val();
        var enddate = $("#enddate option:selected").val();
        layui.use('table', function () {
            var table = layui.table;
            //第一个实例
            table.reload("table", {
                height: 650
                ,
                url: 'findAllUser.action' //数据接口
                ,
                where: {
                    "username": username,
                    "name": name,
                    "usernum": usernum,
                    "position": position,
                    "enddate": enddate
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
            , url: 'findAllUser.action' //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'u_id', title: 'ID', width: 80, sort: true}
                , {field: 'u_loginname', title: '员工工号', width: 131}
                , {field: 'd_name', title: '部门名称', width: 134}
                , {field: 'u_name', title: '员工姓名', width: 118}
                , {field: 'u_date', title: '入职时间', width: 170 }
                , {field: 'u_position', title: '职位', width: 103}
                , {field: 'u_phone', title: '联系方式', width: 146}
                , {field: 'u_email', title: '邮件', width: 197}
                , {field: 'u_card', title: '银行卡号', width: 171}
                , {field: 'u_enddate', title: '离职时间', width: 189}
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
            var id = data.u_id;
            if (layEvent === 'del') { //删除
                layer.confirm('真的删除行么', function (index) {
                    layer.close(index);
                    /*删除员工*/
                    $.ajax({
                        type: "post",
                        url: "deleteUserById.action",
                        data: {"id": id},
                        success: function (result) {
                            if (result == "success") {
                                layer.msg("删除成功，即将刷新界面", {icon: 1, time: 1500})
                                setTimeout("refresh()", 1800)
                            } else {
                                layer.msg("删除失败，该员工已经离职", {icon: 1, time: 1500})
                            }

                        }
                    })
                });
            } else if (layEvent === 'edit') { //编辑
                var height = 500;
                var width = 600;
                var top = Math.round((window.screen.height - height) / 2);
                var left = Math.round((window.screen.width - width) / 2);
                window.open("updateUsertHtml.action?pid="+id, "_blank",
                    "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
            }
        });
    });

    /*添加员工*/
    function addUser() {
        var height = 500;
        var width = 600;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("addUserHtml.action", "_blank",
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
            <input type="text" id="username" placeholder="员工名称" class="layui-input">
            <input type="text" id="name" placeholder="部门名称" class="layui-input">
            <input type="text" id="usernum" placeholder="工号" class="layui-input">
            <div class="layui-inline">
                <select id="enddate">
                    <option value="">选择是否在职</option>
                    <option value="在职">在职</option>
                    <option value="离职">离职</option>
                </select>
            </div>
            <div class="layui-inline">
                <select id="position">
                    <option value="">选择职位</option>
                    <option value="主管">主管</option>
                    <option value="人事主管">人事主管</option>
                    <option value="正式员工">正式员工</option>
                    <option value="试用期员工">试用期员工</option>
                    <option value="实习生">实习生</option>
                </select>
            </div>
            <button class="layui-btn" type="button" onclick="findByCondition()"><i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn"
                onclick="addUser()">
            <i class="layui-icon"></i>添加
        </button>
    </xblock>
    <table id="table" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>


</div>
</body>
</html>
