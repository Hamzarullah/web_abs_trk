/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentOutBLL;
import com.inkombizz.inventory.model.AdjustmentOut;
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
    @Result(name="success", location="inventory/adjustment-out-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentOutApprovalAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentOut adjustmentOutApproval=new AdjustmentOut();
    
    @Override
    public String execute() {
        try {
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentOutBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public AdjustmentOut getAdjustmentOutApproval() {
        return adjustmentOutApproval;
    }

    public void setAdjustmentOutApproval(AdjustmentOut adjustmentOutApproval) {
        this.adjustmentOutApproval = adjustmentOutApproval;
    }

    
}
