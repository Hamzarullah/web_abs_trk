/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.model;

import com.inkombizz.common.SessionGetter;
import java.util.Date;

public class LoginCheckIn {
    
    private static String code;
    private static String name;
    private static Date loginDate;
    private static User user;
    private static String imageMemberPath;

    public static String getCode() {
        return (String)SessionGetter.getSessionValue("code");
    }

    public static void setCode(String code) {
        SessionGetter.setSessionValue(code,"code");
    }

    
    public static String getName() {
         return (String) SessionGetter.getSessionValue("name");
    }

    public static void setName(String name) {
        SessionGetter.setSessionValue(name, "name");
    }

    public static Date getLoginDate() {
         return (Date) SessionGetter.getSessionValue("loginDate");
    }

    public static void setLoginDate(Date loginDate) {
       SessionGetter.setSessionValue(loginDate, "loginDate");
    }

    public static User getUser() {
         return (User) SessionGetter.getSessionValue("user");
    }

    public static void setUser(User user) {
        SessionGetter.setSessionValue(user, "user");
    }

    public static String getImageMemberPath() {
        return (String) SessionGetter.getSessionValue("imageMemberPath");
    }

    public static void setImageMemberPath(String imageMemberPath) {
        SessionGetter.setSessionValue(imageMemberPath, "imageMemberPath");
    }
    
    
    
}
