
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-blanket-order-closing.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerBlanketOrderClosingAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerBlanketOrder blanketOrderClosing=new CustomerBlanketOrder();
    private Date firstDate;
    private Date lastDate;
    
    @Override
    public String execute() {
        try {
            CustomerBlanketOrderBLL blanketOrderClosingBLL = new CustomerBlanketOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderClosingBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            blanketOrderClosing.setTransactionFirstDateBo(firstDate);
            blanketOrderClosing.setTransactionLastDateBo(lastDate);
    
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

    public CustomerBlanketOrder getBlanketOrderClosing() {
        return blanketOrderClosing;
    }

    public void setBlanketOrderClosing(CustomerBlanketOrder blanketOrderClosing) {
        this.blanketOrderClosing = blanketOrderClosing;
    }
    
    
    
}
