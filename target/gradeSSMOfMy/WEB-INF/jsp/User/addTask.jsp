<%--
  User: cong
  Date: 2019/5/14
  Time: 20:59
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加任务</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ztree/zTreeStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMain/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/Layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.3.1.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.core.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/Layui/layui.js" charset="utf-8"></script>
</head>
<script>
    $(function () {
        $("#sort").change(function () {
            var value = $("#sort option:selected").val();
            if (value == "全体员工") {
                $("#chosePeople").hide();
            } else {
                $("#chosePeople").show();
            }
        })

        layui.use('form', function () {
            var form = layui.form;
            form.render();
        });
    })

    /*选择收件人*/
    function chosePeople() {
        var height = 800;
        var width = 2000;
        var top = Math.round((window.screen.height - height) / 2);
        var left = Math.round((window.screen.width - width) / 2);
        window.open("chosePeople.action?", "_blank",
            "height=" + height + ", width=" + width + ", top=" + top + ", left= " + left + ", toolbar=no, menubar=no, scrollbars=auto, resizable=no, location=yes, status=no");
    }
</script>
<body>
<form class="layui-form layui-col-md12 x-so" id="form" enctype="multipart/form-data"
      method="post" action="/grade/addTask.action">
    <div class="layui-form-item">
        <label for="title" class="layui-form-label">
            <span class="x-red">*</span>标题
        </label>
        <div class="layui-input-inline">
            <input type="text" id="title" required name="title"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label for="sort" class="layui-form-label">
            <span class="x-red">*</span>收件人
        </label>
        <div class="layui-input-inline">
            <select name="sort" id="sort" lay-ignore>
                <option value="全体员工">全体员工</option>
                <option value="单个员工">单个员工</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" id="chosePeople" style="display: none">
        <label for="people" class="layui-form-label">
            <span class="x-red">*</span>接收人
        </label>
        <div class="layui-input-inline" style="position: relative">
            <input type="text" id="people" name="receive"
                   class="layui-input">
            <button type="button" onclick="chosePeople()">点击选择收件人</button>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="message" class="layui-form-label">
            <span class="x-red">*</span>内容
        </label>
        <div class="layui-input-inline">
            <textarea name="message" id="message" cols="80" rows="20"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="file" class="layui-form-label">
            <span class="x-red"></span>上传文件
        </label>
        <div class="layui-input-inline">
            <input type="file" name="file" id="file">
        </div>
    </div>
    <div class="layui-form-item">
        <label for="submitDate" class="layui-form-label">
        </label>
        <button class="layui-btn" id="submitDate" type="submit">
            增加
        </button>
    </div>
</form>
</body>
</html>
