
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.security.model.ChangePassword;

@Results({
    @Result(name="success", location="security/change-password.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ChangePasswordAction extends ActionSupport{
    
    private ChangePassword changePassword;
    
    @Override
    public String execute() {
        try {
            changePassword = new ChangePassword();
            changePassword.setUsername(BaseSession.loadProgramSession().getUserName());
            
             return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public ChangePassword getChangePassword() {
        return changePassword;
    }

    public void setChangePassword(ChangePassword changePassword) {
        this.changePassword = changePassword;
    }

   
    
}
