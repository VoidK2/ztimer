package ztimer.Database;

import jdk.nashorn.internal.objects.annotations.Getter;

public class UserModel {
    public String userName;
    public String userPasswd;
    public String emailAddress;
    public String userStatus;
    public String actiCode;
    public int flag;

    public int getFlag() { return flag; }

    public void setFlag(int flag) { this.flag = flag; }

    public String getUserName() {
        return userName;
    }

    public String getUserPasswd() {
        return userPasswd;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public String getActiCode() {
        return actiCode;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserPasswd(String userPasswd) {
        this.userPasswd = userPasswd;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public void setActiCode(String actiCode) {
        this.actiCode = actiCode;
    }
}
