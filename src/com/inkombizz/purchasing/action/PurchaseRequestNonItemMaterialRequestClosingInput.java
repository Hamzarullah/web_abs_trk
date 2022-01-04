
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-request-non-item-material-request-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class PurchaseRequestNonItemMaterialRequestClosingInput extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing =new PurchaseRequestNonItemMaterialRequest();
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestClosingBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
                 
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestClosingBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }            

            purchaseRequestNonItemMaterialRequestClosing = (PurchaseRequestNonItemMaterialRequest) hbmSession.hSession.get(PurchaseRequestNonItemMaterialRequest.class, purchaseRequestNonItemMaterialRequestClosing.getCode());
            
                    
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

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequestClosing() {
        return purchaseRequestNonItemMaterialRequestClosing;
    }

    public void setPurchaseRequestNonItemMaterialRequestClosing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing) {
        this.purchaseRequestNonItemMaterialRequestClosing = purchaseRequestNonItemMaterialRequestClosing;
    }
    
    
}
