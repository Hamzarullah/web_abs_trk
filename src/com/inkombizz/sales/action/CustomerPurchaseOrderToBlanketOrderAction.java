
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerPurchaseOrderToBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-purchase-order-to-blanket-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerPurchaseOrderToBlanketOrderAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder=new CustomerPurchaseOrder();
    
    @Override
    public String execute() {
        try {
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrderToBlankerOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderToBlankerOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            customerPurchaseOrderToBlanketOrder.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1));
            customerPurchaseOrderToBlanketOrder.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12));
    
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrderToBlanketOrder() {
        return customerPurchaseOrderToBlanketOrder;
    }

    public void setCustomerPurchaseOrderToBlanketOrder(CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder) {
        this.customerPurchaseOrderToBlanketOrder = customerPurchaseOrderToBlanketOrder;
    }
    
    
}
