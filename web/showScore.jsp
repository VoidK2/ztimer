<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/9
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- Loading Bootstrap -->
    <link href="./flat/dist/css/vendor/bootstrap.min.css" rel="stylesheet">
    <!-- Loading Flat UI -->
    <link href="./flat/dist/css/flat-ui.css" rel="stylesheet">
    <!-- Loading DOC css -->
    <link href="./flat/docs/assets/css/docs.css" rel="stylesheet">
    <%--Loading Chart.js--%>
    <script type="text/javascript" src="/chart_js/Chart.bundle.js"></script>
    <script type="text/javascript" src="/chart_js/Chart.js"></script>
    <title>ZTimer</title>
</head>
<body>
<%
    String userN = (String) session.getAttribute("userN");
    String userID = (String) session.getAttribute("userID");
%>
<!--导航栏-->
<nav class="navbar navbar-inverse navbar-embossed navbar-expand-lg" role="navigation">
    <a class="navbar-brand" href="#">Ztimer</a>
    <ul class="nav navbar-nav mr-auto">
        <li class="active">
            <a herf="./index.jsp">首页</a>
        </li>
        <li>
            <a herf="/showScore.jsp">详情</a>
        </li>
    </ul>
    <%if (userN == null) {%>
    <ul class="nav navbar-nav navbar-right">
        <form class="navbar-form navbar-right form-inline my-2 my-lg-0" action="/process/dologin.jsp" method="post">
            <div class="form-group" style="margin-right: 2px">
                <input type="text" placeholder="Email" name="user[email]" class="form-control">
            </div>
            <div class="form-group">
                <input type="password" placeholder="Password" name="user[password]" class="form-control">
            </div>
            <button type="submit" class="btn btn-default">Sign in</button>
        </form>
    </ul>
    <%}%>
    <%if (userN != null) {%>
    <div class="collapse navbar-collapse justify-content-end">
        <p class="navbar-text navbar-right">Signed in as <a class="navbar-link" href="#"><%=userN%>
        </a></p>
        <p class="navbar-text navbar-right"><a class="navbar-link" href="process/destroySession.jsp">退了</a></p>
    </div>
    <%}%>
</nav>
</body>
</html>
