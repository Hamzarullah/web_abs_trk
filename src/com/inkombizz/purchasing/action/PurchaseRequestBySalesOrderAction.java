
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestBySalesOrderBLL;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-request-by-sales-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestBySalesOrderAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestBySalesOrder purchaseRequestBySalesOrder=new PurchaseRequestBySalesOrder();
    
    @Override
    public String execute() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBySalesOrderBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBySalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public PurchaseRequestBySalesOrder getPurchaseRequestBySalesOrder() {
        return purchaseRequestBySalesOrder;
    }

    public void setPurchaseRequestBySalesOrder(PurchaseRequestBySalesOrder purchaseRequestBySalesOrder) {
        this.purchaseRequestBySalesOrder = purchaseRequestBySalesOrder;
    }

    
    
}
