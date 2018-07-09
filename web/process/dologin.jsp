<%--
  Created by IntelliJ IDEA.
  User: 13994
  Date: 2018/7/9
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("utf-8");

    String userEmail = request.getParameter("user[email]");
    String userPasswd = request.getParameter("user[password]");
    System.out.println("获取到用户名密码:" + userEmail + userPasswd);
    String userName=null;
    String userID=null;
    String sql = String.format("select * from user where email='%s' and passwd='%s'", userEmail, userPasswd);
    System.out.println(sql);

    Connection conn;
    Statement stm = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://34.236.145.58:3306/ztimer?characterEncoding=UTF-8";
        conn = DriverManager.getConnection(url, "root", "270400");
        stm = conn.createStatement();
        rs = stm.executeQuery(sql);
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (rs.next()) {
        userName = rs.getString("uname");
        userID = rs.getString("uid");
        System.out.println("登录为：" + userName);
        session.setAttribute("userN", userName);
        session.setAttribute("userID", userID);
        response.sendRedirect("../index.jsp");
    }else {
        response.sendRedirect("login_failure.jsp");
    }
%>