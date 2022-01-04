
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/giro-received.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroReceivedAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroReceivedSearchFirstDate;
    private Date giroReceivedSearchLastDate;
    
    @Override
    public String execute() {
        try {
            GiroReceivedBLL cashPaymentBLL = new GiroReceivedBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(cashPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroReceivedSearchFirstDate() {
        return giroReceivedSearchFirstDate;
    }

    public void setGiroReceivedSearchFirstDate(Date giroReceivedSearchFirstDate) {
        this.giroReceivedSearchFirstDate = giroReceivedSearchFirstDate;
    }

    public Date getGiroReceivedSearchLastDate() {
        return giroReceivedSearchLastDate;
    }

    public void setGiroReceivedSearchLastDate(Date giroReceivedSearchLastDate) {
        this.giroReceivedSearchLastDate = giroReceivedSearchLastDate;
    }

    
    
}
