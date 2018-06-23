package ztimer.login;

import ztimer.Database.Interactive;
import ztimer.Database.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "UserLoginer",urlPatterns = {"/2"})
public class UserLoginer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        //获取网页信息
        String userEmail = request.getParameter("user[email]");
        String userPasswd = request.getParameter("user[password]");

        //加载用户模型
        UserModel user = new UserModel();
        user.setEmailAddress(userEmail);
        user.setUserPasswd(userPasswd);
        user.setFlag(0);

        //判定合法性
        Interactive userIog = new Interactive();
        UserModel judge = userIog.judgeUserPasswd(user);

        String message = "邮箱或密码错误！";
        if(judge == null){
            request.setAttribute("message",message);
            request.getRequestDispatcher("./login.html").forward(request,response);
        }
        else{
            //首页显示用户模块
            System.out.println("登录成功! 账号ID:"+user.getEmailAddress()+"密码:"+user.getUserPasswd());
            response.sendRedirect("./index.html");
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
