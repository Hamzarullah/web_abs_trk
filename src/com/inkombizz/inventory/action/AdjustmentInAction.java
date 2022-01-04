
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.inventory.bll.AdjustmentInBLL;
import com.inkombizz.inventory.model.AdjustmentIn;

@Results({
    @Result(name="success", location="inventory/adjustment-in.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentInAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentIn adjustmentIn=new AdjustmentIn();
    
    @Override
    public String execute() {
        try {
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public AdjustmentIn getAdjustmentIn() {
        return adjustmentIn;
    }

    public void setAdjustmentIn(AdjustmentIn adjustmentIn) {
        this.adjustmentIn = adjustmentIn;
    }

    
    
}
