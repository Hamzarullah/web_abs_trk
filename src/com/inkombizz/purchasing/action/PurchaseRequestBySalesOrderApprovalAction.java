
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestBySalesOrderBLL;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="purchasing/purchase-request-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestBySalesOrderApprovalAction extends ActionSupport{
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestBySalesOrder PurchaseRequestApproval=new PurchaseRequestBySalesOrder();
    
    @Override
    public String execute() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public PurchaseRequestBySalesOrder getPurchaseRequestApproval() {
        return PurchaseRequestApproval;
    }

    public void setPurchaseRequestApproval(PurchaseRequestBySalesOrder PurchaseRequestApproval) {
        this.PurchaseRequestApproval = PurchaseRequestApproval;
    }

    
    
}
