
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-sales-order-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerSalesOrderClosingInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerSalesOrder salesOrderClosing;    
     private Date salesOrderClosingTransactionDate;
        
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerSalesOrderBLL salesOrderClosingBLL = new CustomerSalesOrderBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(salesOrderClosingBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }

            salesOrderClosing = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, salesOrderClosing.getCode());
            salesOrderClosingTransactionDate = salesOrderClosing.getTransactionDate();
            salesOrderClosing.setCustomerSalesOrderCode(salesOrderClosing.getCode());
            salesOrderClosing.setCustomerPurchaseOrderCode(salesOrderClosing.getCode());
            salesOrderClosing.setCustomerPurchaseOrderNo(salesOrderClosing.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
            salesOrderClosing.setRetentionPercent(salesOrderClosing.getCustomerPurchaseOrder().getRetentionPercent());
            salesOrderClosing.setPartialShipmentStatus(salesOrderClosing.getCustomerPurchaseOrder().getPartialShipmentStatus());
            
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

    public CustomerSalesOrder getSalesOrderClosing() {
        return salesOrderClosing;
    }

    public void setSalesOrderClosing(CustomerSalesOrder salesOrderClosing) {
        this.salesOrderClosing = salesOrderClosing;
    }

    public Date getSalesOrderClosingTransactionDate() {
        return salesOrderClosingTransactionDate;
    }

    public void setSalesOrderClosingTransactionDate(Date salesOrderClosingTransactionDate) {
        this.salesOrderClosingTransactionDate = salesOrderClosingTransactionDate;
    }

    
    
}
