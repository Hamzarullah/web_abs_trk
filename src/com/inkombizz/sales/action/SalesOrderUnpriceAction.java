
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/sales-order-unprice.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class SalesOrderUnpriceAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerSalesOrder salesOrderUnprice=new CustomerSalesOrder();
    
    @Override
    public String execute() {
        try {
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(salesOrderByCustomerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            salesOrderUnprice.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            salesOrderUnprice.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
    
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

    public CustomerSalesOrder getSalesOrderUnprice() {
        return salesOrderUnprice;
    }

    public void setSalesOrderUnprice(CustomerSalesOrder salesOrderUnprice) {
        this.salesOrderUnprice = salesOrderUnprice;
    }
    
    
}
