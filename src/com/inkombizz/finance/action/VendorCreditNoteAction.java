
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorCreditNoteBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/vendor-credit-note.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorCreditNoteAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date vendorCreditNoteSearchFirstDate;
    private Date vendorCreditNoteSearchLastDate;
    
    @Override
    public String execute() {
        try {
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(vendorCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            vendorCreditNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            vendorCreditNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getVendorCreditNoteSearchFirstDate() {
        return vendorCreditNoteSearchFirstDate;
    }

    public void setVendorCreditNoteSearchFirstDate(Date vendorCreditNoteSearchFirstDate) {
        this.vendorCreditNoteSearchFirstDate = vendorCreditNoteSearchFirstDate;
    }

    public Date getVendorCreditNoteSearchLastDate() {
        return vendorCreditNoteSearchLastDate;
    }

    public void setVendorCreditNoteSearchLastDate(Date vendorCreditNoteSearchLastDate) {
        this.vendorCreditNoteSearchLastDate = vendorCreditNoteSearchLastDate;
    }

    
}
