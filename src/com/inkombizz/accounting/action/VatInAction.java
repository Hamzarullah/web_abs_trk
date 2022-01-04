
package com.inkombizz.accounting.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="accounting/vat-in.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VatInAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    Date vatInSearchFirstDate;
    Date vatInSearchLastDate;
    
    @Override
    public String execute() {
        try {
           
            vatInSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            vatInSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
            
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

    public Date getVatInSearchFirstDate() {
        return vatInSearchFirstDate;
    }

    public void setVatInSearchFirstDate(Date vatInSearchFirstDate) {
        this.vatInSearchFirstDate = vatInSearchFirstDate;
    }

    public Date getVatInSearchLastDate() {
        return vatInSearchLastDate;
    }

    public void setVatInSearchLastDate(Date vatInSearchLastDate) {
        this.vatInSearchLastDate = vatInSearchLastDate;
    }

}

