package ztimer.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import java.sql.Statement;

public class dbManage {
    //初始化连接数据库
    public Connection initDB(){
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://13.229.72.11:3306/ztimer";
            conn = DriverManager.getConnection(url,"root","270400");
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        } catch(SQLException e){
            e.printStackTrace();
        }
        return conn;
    }

    //关闭数据库连接-无结果
    public void closeDB(Statement sta, Connection conn){
        try{
            sta.close();
            conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    //关闭数据库连接-有结果
    public void closeDB(ResultSet rs, Statement sta, Connection conn){
        try{
            rs.close();
            sta.close();
            conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
}
