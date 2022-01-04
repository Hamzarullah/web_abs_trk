
package com.inkombizz.system.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.system.bll.TransactionLogBLL;
import com.inkombizz.utils.DateUtils;
import java.util.Date;

@Results({
    @Result(name="success", location="system/transaction-log.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class TransactionLogAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    Date transactionLogSearchFirstDate;
    Date transactionLogSearchLastDate;
    
    @Override
    public String execute() {
        try {
            TransactionLogBLL transactionLogBLL = new TransactionLogBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(transactionLogBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            transactionLogSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            transactionLogSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getTransactionLogSearchFirstDate() {
        return transactionLogSearchFirstDate;
    }

    public void setTransactionLogSearchFirstDate(Date transactionLogSearchFirstDate) {
        this.transactionLogSearchFirstDate = transactionLogSearchFirstDate;
    }

    public Date getTransactionLogSearchLastDate() {
        return transactionLogSearchLastDate;
    }

    public void setTransactionLogSearchLastDate(Date transactionLogSearchLastDate) {
        this.transactionLogSearchLastDate = transactionLogSearchLastDate;
    }

    
    
}
