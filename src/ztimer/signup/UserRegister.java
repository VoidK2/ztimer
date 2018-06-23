package ztimer.signup;

import ztimer.Database.Interactive;
import ztimer.Database.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UserRegister",urlPatterns = {"/1"})
public class UserRegister extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取注册信息
//        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String userName=request.getParameter("user[name]");
        String userEmail=request.getParameter("user[email]");
        String userPasswd=request.getParameter("user[password]");

        //实例化用户模型
        UserModel user = new UserModel();
        user.setUserName(userName);
        user.setEmailAddress(userEmail);
        user.setUserPasswd(userPasswd);
        user.setUserStatus("0");
        user.setActiCode("public");
        user.setFlag(0);

        //数据库中插入数据
        Interactive userIns = new Interactive();
        userIns.insertUser(user);

        //跳转到登录页面
        String message = "注册成功！";
        if(user.getFlag()==1) {
//        request.getRequestDispatcher("./login.html").forward(request,response);
//            out.println("<script>alert(\"注册成功\");</script>");
            //System.out.println("cfgbxcf");
            request.setAttribute("message",message);
            response.sendRedirect("./login.html");

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
