<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加子部门</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    /*选择部门主管*/
    function choseMan() {
        var height = 500;
        var width = 1800;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("choseMan.action?sign=1", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }

    /*选择人事主管*/
    function choseHr() {
        var height = 500;
        var width = 1800;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("choseMan.action?sign=2", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }

    function refresh() {
        window.close();
        window.opener.location.reload();
    }

    /*添加部门*/
    function addDepartment() {
        var id =${requestScope.pid};
        var hrid = $("#hr").val();
        var manid = $("#man").val();
        var name = $("#name").val();
        if (hrid != null && manid != null && name != null) {
            $.ajax({
                type: "post",
                url: "addDepartment.action",
                data: {"id": id, "hr": hrid, "man": manid, "name": name},
                success: function (data) {
                    if (data == "success") {
                        layui.use("layer", function () {
                            layer = layui.layer;
                            layer.msg("添加成功，即将刷新界面", {icon: 1, time: 2000});
                            setTimeout("refresh()", 2000)
                        })
                    } else {
                        layui.use("layer", function () {
                            layer = layui.layer;
                            layer.msg("添加失败，该部门已经存在相同名称的子部门", {icon: 5, time: 2000});
                        })
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                layer = layui.layer;
                layer.msg("抱歉，数据有误，无法添加", {icon: 5, time: 2000});
            })
        }


    }
</script>
<div class="x-body layui-anim layui-anim-up">

    <div class="layui-form-item">
        <label for="name" class="layui-form-label">
            <span class="x-red">*</span>部门名称
        </label>
        <div class="layui-input-inline">
            <input type="text" id="name" required
                   class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label for="man" class="layui-form-label">
            <span class="x-red">*</span>部门主管
        </label>
        <div class="layui-input-inline" style="position: relative">
            <input type="text" id="man" required
                   class="layui-input">
            <button type="button" onclick="choseMan()">点击选择部门主管</button>
        </div>
    </div>

    <div class="layui-form-item">
        <label for="hr" class="layui-form-label">
            <span class="x-red">*</span>人事主管
        </label>
        <div class="layui-input-inline" style="position: relative">
            <input type="text" id="hr" required
                   class="layui-input">
            <button type="button" onclick="choseHr()">点击选择部门人事主管</button>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="submitDate" class="layui-form-label">
        </label>
        <button class="layui-btn" id="submitDate" type="button" onclick="addDepartment()">
            增加
        </button>
    </div>

</div>
</html>
