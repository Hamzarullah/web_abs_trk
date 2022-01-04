
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="security/user.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class UserAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private User user=new User();
    
    @Override
    public String execute() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(userBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            String branchCode=BaseSession.loadProgramSession().getSetup().getDefaultBranchCode();
//            user.setBranchCode(branchCode);
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
}
