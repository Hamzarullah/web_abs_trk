
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="purchasing/purchase-request-non-item-material-request-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestNonItemMaterialRequestApprovalInput extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval =new PurchaseRequestNonItemMaterialRequest();    
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
                 
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }            

            purchaseRequestNonItemMaterialRequestApproval = (PurchaseRequestNonItemMaterialRequest) hbmSession.hSession.get(PurchaseRequestNonItemMaterialRequest.class, purchaseRequestNonItemMaterialRequestApproval.getCode());
            purchaseRequestNonItemMaterialRequestApproval.setApprovalStatus("");
                    
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
