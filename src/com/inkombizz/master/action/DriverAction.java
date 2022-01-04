
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.master.bll.DriverBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Results({
    @Result(name="success", location="master/driver.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class DriverAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(driverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
}
