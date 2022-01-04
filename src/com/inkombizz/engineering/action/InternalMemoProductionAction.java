
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
    @Result(name="success", location="engineering/internal-memo-production.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoProductionAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date internalMemoProductionSearchFirstDate;
    private Date internalMemoProductionSearchLastDate;
    
    @Override
    public String execute() {
        try {
            InternalMemoProductionBLL internalMemoProductioBLL = new InternalMemoProductionBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductioBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            internalMemoProductionSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            internalMemoProductionSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
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

    public Date getInternalMemoProductionSearchFirstDate() {
        return internalMemoProductionSearchFirstDate;
    }

    public void setInternalMemoProductionSearchFirstDate(Date internalMemoProductionSearchFirstDate) {
        this.internalMemoProductionSearchFirstDate = internalMemoProductionSearchFirstDate;
    }

    public Date getInternalMemoProductionSearchLastDate() {
        return internalMemoProductionSearchLastDate;
    }

    public void setInternalMemoProductionSearchLastDate(Date internalMemoProductionSearchLastDate) {
        this.internalMemoProductionSearchLastDate = internalMemoProductionSearchLastDate;
    }

  


    
}
