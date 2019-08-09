<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎来到阿里巴巴</title>
    <script src="js/jquery/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="js/Layui/layui.js" type="text/javascript"></script>
    <script src="js/login/login.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="css/login/login.css" />
</head>
<body>
<div class="logo_box">
    <h3>欢迎加入本公司</h3>
    <form action="/grade/login.action"  method="post" id="form">
        <div class="input_outer">
            <span class="u_user"></span>
            <input name="name" class="text" id="name" placeholder="请输入用户名"
                   style="color: #FFFFFF !important" type="text">
        </div>
        <div class="input_outer">
            <span class="us_uer"></span>
            <input name="pass" class="text" id="pass" style="color: #FFFFFF !important; position:absolute; z-index:100;"
                   placeholder="请输入密码"
                   value="" type="password">
        </div>

        <div class="mb2"><a class="act-but submit" href="javascript:;" style="color: #FFFFFF" id="submitData">登录</a></div>
    </form>


</div>

</body>
</html>