
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentRejectBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/giro-payment-reject.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class GiroPaymentRejectAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroPaymentRejectSearchFirstDate;
    private Date giroPaymentRejectSearchLastDate;
    private Date giroPaymentRejectSearchFirstDateDueDate;
    private Date giroPaymentRejectSearchLastDateDueDate;
    
    @Override
    public String execute() {
        try {
            GiroPaymentRejectBLL giroPaymentRejectBLL = new GiroPaymentRejectBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentRejectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroPaymentRejectSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroPaymentRejectSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            giroPaymentRejectSearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroPaymentRejectSearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroPaymentRejectSearchFirstDate() {
        return giroPaymentRejectSearchFirstDate;
    }

    public void setGiroPaymentRejectSearchFirstDate(Date giroPaymentRejectSearchFirstDate) {
        this.giroPaymentRejectSearchFirstDate = giroPaymentRejectSearchFirstDate;
    }

    public Date getGiroPaymentRejectSearchLastDate() {
        return giroPaymentRejectSearchLastDate;
    }

    public void setGiroPaymentRejectSearchLastDate(Date giroPaymentRejectSearchLastDate) {
        this.giroPaymentRejectSearchLastDate = giroPaymentRejectSearchLastDate;
    }

    public Date getGiroPaymentRejectSearchFirstDateDueDate() {
        return giroPaymentRejectSearchFirstDateDueDate;
    }

    public void setGiroPaymentRejectSearchFirstDateDueDate(Date giroPaymentRejectSearchFirstDateDueDate) {
        this.giroPaymentRejectSearchFirstDateDueDate = giroPaymentRejectSearchFirstDateDueDate;
    }

    public Date getGiroPaymentRejectSearchLastDateDueDate() {
        return giroPaymentRejectSearchLastDateDueDate;
    }

    public void setGiroPaymentRejectSearchLastDateDueDate(Date giroPaymentRejectSearchLastDateDueDate) {
        this.giroPaymentRejectSearchLastDateDueDate = giroPaymentRejectSearchLastDateDueDate;
    }
    
    
    
}
