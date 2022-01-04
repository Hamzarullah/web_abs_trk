
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-sales-order-closing.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerSalesOrderClosingAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerSalesOrder salesOrderClosing=new CustomerSalesOrder();
    private Date firstDate;
    private Date lastDate;
    
    @Override
    public String execute() {
        try {
            CustomerSalesOrderBLL salesOrderClosingBLL = new CustomerSalesOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(salesOrderClosingBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            salesOrderClosing.setTransactionFirstDate(firstDate);
            salesOrderClosing.setTransactionLastDate(lastDate);
    
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

    public CustomerSalesOrder getSalesOrderClosing() {
        return salesOrderClosing;
    }

    public void setSalesOrderClosing(CustomerSalesOrder salesOrderClosing) {
        this.salesOrderClosing = salesOrderClosing;
    }
    
    
    
}
