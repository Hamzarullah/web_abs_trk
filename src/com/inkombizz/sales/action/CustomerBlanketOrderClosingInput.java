
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-blanket-order-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerBlanketOrderClosingInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerBlanketOrder blanketOrderClosing;    
     private Date blanketOrderClosingTransactionDate;
        
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerBlanketOrderBLL blanketOrderClosingBLL = new CustomerBlanketOrderBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderClosingBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }

            blanketOrderClosing = (CustomerBlanketOrder) hbmSession.hSession.get(CustomerBlanketOrder.class, blanketOrderClosing.getCode());
            blanketOrderClosingTransactionDate = blanketOrderClosing.getTransactionDate();
            blanketOrderClosing.setCustomerBlanketOrderCode(blanketOrderClosing.getCode());
            blanketOrderClosing.setCustomerPurchaseOrderCode(blanketOrderClosing.getCode());
            blanketOrderClosing.setCustomerPurchaseOrderNo(blanketOrderClosing.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
            blanketOrderClosing.setRetentionPercent(blanketOrderClosing.getCustomerPurchaseOrder().getRetentionPercent());
            blanketOrderClosing.setPartialShipmentStatus(blanketOrderClosing.getCustomerPurchaseOrder().getPartialShipmentStatus());
            
            return SUCCESS;
                
        } catch (Exception e) {
            e.printStackTrace();
        }
   
        return SUCCESS;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerBlanketOrder getBlanketOrderClosing() {
        return blanketOrderClosing;
    }

    public void setBlanketOrderClosing(CustomerBlanketOrder blanketOrderClosing) {
        this.blanketOrderClosing = blanketOrderClosing;
    }

    public Date getBlanketOrderClosingTransactionDate() {
        return blanketOrderClosingTransactionDate;
    }

    public void setBlanketOrderClosingTransactionDate(Date blanketOrderClosingTransactionDate) {
        this.blanketOrderClosingTransactionDate = blanketOrderClosingTransactionDate;
    }

    
    
}
