/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common;
import com.inkombizz.utils.DateUtils;
import java.util.Date;
import org.apache.struts2.ServletActionContext;


public class SessionGetter {
    
     public static final String USER_SESSION = "user";
    public static final String MENU = "menu";

    public static Object getSessionValue(String attribute){
        Object obj = ServletActionContext.getRequest().getSession().getAttribute(attribute);
        return obj;
    }

    public static void setSessionValue(Object data, String attribute){
        ServletActionContext.getRequest().getSession().setAttribute(attribute, data);
    }
    
    public static void setSessionValue(Object data, Date attribute){        
        ServletActionContext.getRequest().getSession().setAttribute(DateUtils.toString(attribute, DateUtils.DATE_FORMAT_COMPLETE), data);
    }

    public static void destroySessionValue(String attribute){
        ServletActionContext.getRequest().getSession().removeAttribute(attribute);
    }
    
    public static void setLengthTime(int length){
        //14400 4jam
        ServletActionContext.getRequest().getSession().setMaxInactiveInterval(length);
    }

    public static boolean isNull(Object obj) {
        if(obj==null){
            return true;
        }else
            return false;
    }
}
