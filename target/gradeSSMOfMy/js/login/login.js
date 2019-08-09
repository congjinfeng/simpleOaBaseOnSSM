$(function () {
    /*校验账号是否为空*/
    $("#name").blur(function () {
        if ($(this).val() == "" && $(this).val().length == 0) {
            layui.use("layer", function () {
                layer = layui.layer;
                layer.tips("抱歉，账号不能为空", "#name", {tips: [2, "red"], time: 1000})
            });
        }

    });
    /*校验密码是否为空*/
    $("#pass").blur(function () {
        if ($(this).val() == "" && $(this).val().length == 0) {
            layui.use("layer", function () {
                layer = layui.layer;
                layer.tips("抱歉，密码不能为空", "#pass", {tips: [2, "red"], time: 1000})
            });
        }
    })
    /*登录*/
    $("#submitData").click(function () {
        var name = $("#name").val();
        var pass = $("#pass").val();
        var form=$("#form")
        if (name != null && name.length != 0 && pass != null && pass.length != 0) {
            /*检查账号密码是否正确*/
            $.ajax({
                type: "POST",
                url: "/grade/checkUserPass.action",
                data: {"name": name, "pass": pass},
                success: function (data) {
                    if(data=="success"){
                        form.submit();
                    }else if(data="fail"){
                        layui.use("layer", function () {
                            layer = layui.layer;
                            layer.msg("账号或密码错误，请重新检查后输入", {icon: 5, time: 2000})
                        });
                    }
                }
            })
        } else {
            layui.use("layer", function () {
                layer = layui.layer;
                layer.msg("账号密码不可以为空哦", {icon: 5, time: 2000})
            });
        }
    });
});