
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;



@Results({
    @Result(name="success", location="purchasing/purchase-request-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestBySalesOrderApprovalInput extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestBySalesOrder purchaseRequestApproval =new PurchaseRequestBySalesOrder();
    
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonSoBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
                 
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonSoBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }            

            purchaseRequestApproval = (PurchaseRequestBySalesOrder) hbmSession.hSession.get(PurchaseRequestBySalesOrder.class, purchaseRequestApproval.getCode());
                    
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

    public PurchaseRequestBySalesOrder getPurchaseRequestApproval() {
        return purchaseRequestApproval;
    }

    public void setPurchaseRequestApproval(PurchaseRequestBySalesOrder purchaseRequestApproval) {
        this.purchaseRequestApproval = purchaseRequestApproval;
    }

    
    
}
