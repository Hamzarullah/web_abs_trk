
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CustomerDebitNoteBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/customer-debit-note.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDebitNoteAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date customerDebitNoteSearchFirstDate;
    private Date customerDebitNoteSearchLastDate;
    
    @Override
    public String execute() {
        try {
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(customerDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            customerDebitNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            customerDebitNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getCustomerDebitNoteSearchFirstDate() {
        return customerDebitNoteSearchFirstDate;
    }

    public void setCustomerDebitNoteSearchFirstDate(Date customerDebitNoteSearchFirstDate) {
        this.customerDebitNoteSearchFirstDate = customerDebitNoteSearchFirstDate;
    }

    public Date getCustomerDebitNoteSearchLastDate() {
        return customerDebitNoteSearchLastDate;
    }

    public void setCustomerDebitNoteSearchLastDate(Date customerDebitNoteSearchLastDate) {
        this.customerDebitNoteSearchLastDate = customerDebitNoteSearchLastDate;
    }

}
