
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorDebitNoteBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/vendor-debit-note.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDebitNoteAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date vendorDebitNoteSearchFirstDate;
    private Date vendorDebitNoteSearchLastDate;
    
    @Override
    public String execute() {
        try {
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(vendorDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            vendorDebitNoteSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            vendorDebitNoteSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getVendorDebitNoteSearchFirstDate() {
        return vendorDebitNoteSearchFirstDate;
    }

    public void setVendorDebitNoteSearchFirstDate(Date vendorDebitNoteSearchFirstDate) {
        this.vendorDebitNoteSearchFirstDate = vendorDebitNoteSearchFirstDate;
    }

    public Date getVendorDebitNoteSearchLastDate() {
        return vendorDebitNoteSearchLastDate;
    }

    public void setVendorDebitNoteSearchLastDate(Date vendorDebitNoteSearchLastDate) {
        this.vendorDebitNoteSearchLastDate = vendorDebitNoteSearchLastDate;
    }

    
}
