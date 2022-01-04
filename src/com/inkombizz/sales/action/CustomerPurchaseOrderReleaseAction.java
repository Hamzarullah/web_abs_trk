
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerPurchaseOrderReleaseBLL;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-purchase-order-release.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerPurchaseOrderReleaseAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerPurchaseOrder customerPurchaseOrderRelease=new CustomerPurchaseOrder();
    
    @Override
    public String execute() {
        try {
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderReleaseBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderReleaseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            customerPurchaseOrderRelease.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1));
            customerPurchaseOrderRelease.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12));
    
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

    public CustomerPurchaseOrder getCustomerPurchaseOrderRelease() {
        return customerPurchaseOrderRelease;
    }

    public void setCustomerPurchaseOrderRelease(CustomerPurchaseOrder customerPurchaseOrderRelease) {
        this.customerPurchaseOrderRelease = customerPurchaseOrderRelease;
    }

    
    
}
