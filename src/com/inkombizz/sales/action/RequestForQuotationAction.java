
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.RequestForQuotationBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/request-for-quotation.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class RequestForQuotationAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date requestForQuotationSearchFirstDate;
    private Date requestForQuotationSearchLastDate;
    
    @Override
    public String execute() {
        try {
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            requestForQuotationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            requestForQuotationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
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

    public Date getRequestForQuotationSearchFirstDate() {
        return requestForQuotationSearchFirstDate;
    }

    public void setRequestForQuotationSearchFirstDate(Date requestForQuotationSearchFirstDate) {
        this.requestForQuotationSearchFirstDate = requestForQuotationSearchFirstDate;
    }

    public Date getRequestForQuotationSearchLastDate() {
        return requestForQuotationSearchLastDate;
    }

    public void setRequestForQuotationSearchLastDate(Date requestForQuotationSearchLastDate) {
        this.requestForQuotationSearchLastDate = requestForQuotationSearchLastDate;
    }


    
}
