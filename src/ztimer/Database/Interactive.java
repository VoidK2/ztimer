package ztimer.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Interactive {
    public void insertUser(UserModel user){
        dbManage dbmanage = new dbManage();
        Connection conn = null;
        Statement sta =null;
        try {
            conn = dbmanage.initDB();
            sta = conn.createStatement();
            String sql = String.format("INSERT INTO user (email,pwd,username,status,ActiCode)VALUES('%s','%s','%s','%s','%s')",
                    user.getEmailAddress(),
                    user.getUserPasswd(),
                    user.getUserName(),
                    user.getUserStatus(),
                    user.getActiCode());
//            System.out.println(sql);
            sta.executeUpdate(sql);
            user.setFlag(1);

        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            dbmanage.closeDB(sta,conn);
        }
    }
    public UserModel judgeUserPasswd(UserModel user){
        dbManage dbmanage = new dbManage();
        Connection conn = null;
        Statement sta = null;
        ResultSet rs = null;
        UserModel judge = null;
        try {
            conn = dbmanage.initDB();
            sta = conn.createStatement();
//            System.out.println(userID);
//            System.out.println(userPasswd);
            String sql = String.format("SELECT * FROM user WHERE email ='%s'AND pwd='%s'",
                    user.getEmailAddress(),
                    user.getUserPasswd());
//            System.out.println(sql);
            rs = sta.executeQuery(sql);
            //这里写的太优美了好吧
            while(rs.next()){
                judge = new UserModel();
                judge.setEmailAddress(rs.getString("id"));
                judge.setUserPasswd(rs.getString("pwd"));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            dbmanage.closeDB(rs,sta,conn);
        }
        return judge;
    }
}
