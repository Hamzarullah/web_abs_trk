
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedRejectBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/giro-received-reject.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class GiroReceivedRejectAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroReceivedRejectSearchFirstDate;
    private Date giroReceivedRejectSearchLastDate;
    
    private Date giroReceivedRejectSearchFirstDateDueDate;
    private Date giroReceivedRejectSearchLastDateDueDate;
    
    @Override
    public String execute() {
        try {
            GiroReceivedRejectBLL giroReceivedRejectBLL = new GiroReceivedRejectBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedRejectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroReceivedRejectSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroReceivedRejectSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            giroReceivedRejectSearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroReceivedRejectSearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroReceivedRejectSearchFirstDate() {
        return giroReceivedRejectSearchFirstDate;
    }

    public void setGiroReceivedRejectSearchFirstDate(Date giroReceivedRejectSearchFirstDate) {
        this.giroReceivedRejectSearchFirstDate = giroReceivedRejectSearchFirstDate;
    }

    public Date getGiroReceivedRejectSearchLastDate() {
        return giroReceivedRejectSearchLastDate;
    }

    public void setGiroReceivedRejectSearchLastDate(Date giroReceivedRejectSearchLastDate) {
        this.giroReceivedRejectSearchLastDate = giroReceivedRejectSearchLastDate;
    }

    public Date getGiroReceivedRejectSearchFirstDateDueDate() {
        return giroReceivedRejectSearchFirstDateDueDate;
    }

    public void setGiroReceivedRejectSearchFirstDateDueDate(Date giroReceivedRejectSearchFirstDateDueDate) {
        this.giroReceivedRejectSearchFirstDateDueDate = giroReceivedRejectSearchFirstDateDueDate;
    }

    public Date getGiroReceivedRejectSearchLastDateDueDate() {
        return giroReceivedRejectSearchLastDateDueDate;
    }

    public void setGiroReceivedRejectSearchLastDateDueDate(Date giroReceivedRejectSearchLastDateDueDate) {
        this.giroReceivedRejectSearchLastDateDueDate = giroReceivedRejectSearchLastDateDueDate;
    }

    
}
