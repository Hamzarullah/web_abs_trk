
package com.inkombizz.system.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.bll.ModuleBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="system/module.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ModuleAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
 
    @Override
    public String execute() {
        try {
            ModuleBLL moduleBLL = new ModuleBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(moduleBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
          
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

    
    
}
