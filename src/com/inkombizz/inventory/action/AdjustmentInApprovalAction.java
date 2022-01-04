/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentInBLL;
import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Rayis
 */
@Results({
    @Result(name="success", location="inventory/adjustment-in-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentInApprovalAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    private AdjustmentIn adjustmentInApproval=new AdjustmentIn();
    
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }            
            
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    public AdjustmentIn getAdjustmentInApproval() {
        return adjustmentInApproval;
    }

    public void setAdjustmentInApproval(AdjustmentIn adjustmentInApproval) {
        this.adjustmentInApproval = adjustmentInApproval;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    
}
