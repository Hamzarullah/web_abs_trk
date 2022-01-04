/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.bll.BillOfMaterialBLL;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author CHRIST
 */
@Results({
    @Result(name="success", location="engineering/bill-of-material-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BillOfMaterialApprovalAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private BillOfMaterial billOfMaterialApproval=new BillOfMaterial();

    @Override
    public String execute() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            billOfMaterialApproval.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            billOfMaterialApproval.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));

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

    public BillOfMaterial getBillOfMaterialApproval() {
        return billOfMaterialApproval;
    }

    public void setBillOfMaterialApproval(BillOfMaterial billOfMaterialApproval) {
        this.billOfMaterialApproval = billOfMaterialApproval;
    }
    
    
}
