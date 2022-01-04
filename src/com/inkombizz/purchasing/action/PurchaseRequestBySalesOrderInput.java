
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestBySalesOrderBLL;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-request-by-sales-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestBySalesOrderInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestBySalesOrder purchaseRequestBySalesOrder =new PurchaseRequestBySalesOrder();
    private Boolean purchaseRequestBySalesOrderUpdateMode= Boolean.FALSE;
    
    @Override
    public String execute() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBySalesOrderBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            if(purchaseRequestBySalesOrderUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBySalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                purchaseRequestBySalesOrder = (PurchaseRequestBySalesOrder) hbmSession.hSession.get(PurchaseRequestBySalesOrder.class, purchaseRequestBySalesOrder.getCode());
                purchaseRequestBySalesOrder.setTransactionDate(purchaseRequestBySalesOrder.getTransactionDate());
                
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBySalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }           

                purchaseRequestBySalesOrder.setTransactionDate(new Date());
                purchaseRequestBySalesOrder.setCode("AUTO");
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

    public Boolean getPurchaseRequestBySalesOrderUpdateMode() {
        return purchaseRequestBySalesOrderUpdateMode;
    }

    public void setPurchaseRequestBySalesOrderUpdateMode(Boolean purchaseRequestBySalesOrderUpdateMode) {
        this.purchaseRequestBySalesOrderUpdateMode = purchaseRequestBySalesOrderUpdateMode;
    }

    
}
