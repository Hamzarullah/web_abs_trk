
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-request-non-item-material-request.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestNonItemMaterialRequestAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest=new PurchaseRequestNonItemMaterialRequest();
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequest() {
        return purchaseRequestNonItemMaterialRequest;
    }

    public void setPurchaseRequestNonItemMaterialRequest(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest) {
        this.purchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequest;
    }

    
}
