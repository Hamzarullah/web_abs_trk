
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CustomerCreditNoteBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/customer-credit-note.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerCreditNoteAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date customerCreditNoteSearchFirstDate;
    private Date customerCreditNoteSearchLastDate;
    
    @Override
    public String execute() {
        try {
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(customerCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            customerCreditNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            customerCreditNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getCustomerCreditNoteSearchFirstDate() {
        return customerCreditNoteSearchFirstDate;
    }

    public void setCustomerCreditNoteSearchFirstDate(Date customerCreditNoteSearchFirstDate) {
        this.customerCreditNoteSearchFirstDate = customerCreditNoteSearchFirstDate;
    }

    public Date getCustomerCreditNoteSearchLastDate() {
        return customerCreditNoteSearchLastDate;
    }

    public void setCustomerCreditNoteSearchLastDate(Date customerCreditNoteSearchLastDate) {
        this.customerCreditNoteSearchLastDate = customerCreditNoteSearchLastDate;
    }

}
