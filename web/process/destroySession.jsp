<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/9
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate();
    response.sendRedirect("../index.jsp");
%>
