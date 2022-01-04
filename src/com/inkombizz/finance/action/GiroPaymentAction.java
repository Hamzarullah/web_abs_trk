
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/giro-payment.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroPaymentAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroPaymentSearchFirstDate;
    private Date giroPaymentSearchLastDate;
    
    @Override
    public String execute() {
        try {
            GiroPaymentBLL cashPaymentBLL = new GiroPaymentBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(cashPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroPaymentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroPaymentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroPaymentSearchFirstDate() {
        return giroPaymentSearchFirstDate;
    }

    public void setGiroPaymentSearchFirstDate(Date giroPaymentSearchFirstDate) {
        this.giroPaymentSearchFirstDate = giroPaymentSearchFirstDate;
    }

    public Date getGiroPaymentSearchLastDate() {
        return giroPaymentSearchLastDate;
    }

    public void setGiroPaymentSearchLastDate(Date giroPaymentSearchLastDate) {
        this.giroPaymentSearchLastDate = giroPaymentSearchLastDate;
    }

    
}
