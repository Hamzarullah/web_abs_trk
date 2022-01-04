
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-blanket-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerBlanketOrderAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerBlanketOrder blanketOrder=new CustomerBlanketOrder();
    
    @Override
    public String execute() {
        try {
            CustomerBlanketOrderBLL blankerOrderBLL = new CustomerBlanketOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(blankerOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            blanketOrder.setTransactionFirstDateBo(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            blanketOrder.setTransactionLastDateBo(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
    
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

    public CustomerBlanketOrder getBlanketOrder() {
        return blanketOrder;
    }

    public void setBlanketOrder(CustomerBlanketOrder blanketOrder) {
        this.blanketOrder = blanketOrder;
    }
    
    
}
