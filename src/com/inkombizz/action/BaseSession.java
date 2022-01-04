/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;

/**
 *
 * @author niko
 */

public class BaseSession extends ActionSupport  {
    
    public static void settingSession(ProgramSession prgSession) throws Exception {
        try {
            Map<String, Object> session = ActionContext.getContext().getSession();
            
            session.put("ProgramSession", prgSession);
        }
        catch(Exception ex){
            throw ex;
        }
    }
     
    public boolean isSessionValid() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        
        if (session.get("ProgramSession") == null)
            return false;
        else
            return true;

    }
    
    public static ProgramSession loadProgramSession() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        
        return (ProgramSession) session.get("ProgramSession");
    }
    
    public static void clearSession() {
        ActionContext.getContext().getSession().clear();
    }
    
}
