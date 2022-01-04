/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.action;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.UserBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author IKB_CHRISR
 */

@Results({
    @Result(name="success", type = "json")
})
public class SessionExpiredJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    String username = "";
    
    @Action("session-expired-data")
    public String findata(){
        
        try {
            
            UserBLL userBLL = new UserBLL(hbmSession);
            userBLL.deleteUserSession(this.username);

            BaseSession.clearSession();
            return SUCCESS;
            
        } catch (Exception e) {
            e.printStackTrace();
            return SUCCESS;
        }
        
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
}
