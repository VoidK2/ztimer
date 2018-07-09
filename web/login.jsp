<!DOCTYPE html>
<!-- made by k2 with heart -->
<!-- contact:zhangzexindeguge@gmail.com -->
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Cache-Control" content="no-transform"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <title>Ztimer's account Login and Registration</title>
    <link rel="stylesheet" media="all" href="dmaku.main.css"/>
</head>
<body class="align">
	<%
        String message=(String)session.getAttribute("message");
        if (message != null) {
    %><script>alert("<%=message%>");</script><%
        }
    %>
<div class="site__container">
    <div class="grid__container">
        <img class="logo" src="./images/logo.png"/>
        <form _lpchecked="1" accept-charset="UTF-8" action="/login" class="form form--login" method="post">
            <div class="form__field">
                <input autofocus="true" class="form__input" id="login__email_address" name="user[email]"
                       placeholder="邮箱" required="" type="text"/>
            </div>
            <div class="form__field">
                <input autocomplete="off" class="form__input" id="login__password" name="user[password]"
                       placeholder="密码" required="" type="password"/>
            </div>
            <div class="form__field">
                <input type="submit" value="登 录"/>
            </div>
        </form>
        <p class="text--center"><a href="./forgetpwd.html">忘记密码?</a></p>
        <p class="text--center">还没有帐号? <a href="./signup.html">点击注册</a></p>
    </div>
</div>
</body>
</html>