/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="purchasing/purchase-request-non-item-material-request-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestNonItemMaterialRequestApprovalAction extends ActionSupport{
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval=new PurchaseRequestNonItemMaterialRequest();
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestApprovalBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestApprovalBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
                        
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequestApproval() {
        return purchaseRequestNonItemMaterialRequestApproval;
    }

    public void setPurchaseRequestNonItemMaterialRequestApproval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval) {
        this.purchaseRequestNonItemMaterialRequestApproval = purchaseRequestNonItemMaterialRequestApproval;
    }

}
