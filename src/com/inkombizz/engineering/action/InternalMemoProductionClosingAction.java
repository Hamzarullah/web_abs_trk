
package com.inkombizz.engineering.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.bll.InternalMemoProductionBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="engineering/internal-memo-production-closing.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoProductionClosingAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date internalMemoProductionClosingSearchFirstDate;
    private Date internalMemoProductionClosingSearchLastDate;
    
    @Override
    public String execute() {
        try {
            InternalMemoProductionBLL internalMemoProductioBLL = new InternalMemoProductionBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductioBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            internalMemoProductionClosingSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            internalMemoProductionClosingSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
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

    public Date getInternalMemoProductionClosingSearchFirstDate() {
        return internalMemoProductionClosingSearchFirstDate;
    }

    public void setInternalMemoProductionClosingSearchFirstDate(Date internalMemoProductionClosingSearchFirstDate) {
        this.internalMemoProductionClosingSearchFirstDate = internalMemoProductionClosingSearchFirstDate;
    }

    public Date getInternalMemoProductionClosingSearchLastDate() {
        return internalMemoProductionClosingSearchLastDate;
    }

    public void setInternalMemoProductionClosingSearchLastDate(Date internalMemoProductionClosingSearchLastDate) {
        this.internalMemoProductionClosingSearchLastDate = internalMemoProductionClosingSearchLastDate;
    }

    
}
