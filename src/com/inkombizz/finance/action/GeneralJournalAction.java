
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GeneralJournalBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/general-journal.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GeneralJournalAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    Date generalJournalSearchFirstDate;
    Date generalJournalSearchLastDate;
    
    @Override
    public String execute() {
        try {
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(generalJournalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            generalJournalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            generalJournalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGeneralJournalSearchFirstDate() {
        return generalJournalSearchFirstDate;
    }

    public void setGeneralJournalSearchFirstDate(Date generalJournalSearchFirstDate) {
        this.generalJournalSearchFirstDate = generalJournalSearchFirstDate;
    }

    public Date getGeneralJournalSearchLastDate() {
        return generalJournalSearchLastDate;
    }

    public void setGeneralJournalSearchLastDate(Date generalJournalSearchLastDate) {
        this.generalJournalSearchLastDate = generalJournalSearchLastDate;
    }

    
    
}
