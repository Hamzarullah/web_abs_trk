
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.RequestForQuotationBLL;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Results({
    @Result(name="success", location="sales/request-for-quotation-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class RequestForQuotationApprovalAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    Date requestForQuotationApprovalSearchFirstDate;
    Date requestForQuotationApprovalSearchLastDate;
    private User user;

    @Override
    public String execute() {
        try {
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            requestForQuotationApprovalSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            requestForQuotationApprovalSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
            
            user = (User) hbmSession.hSession.get(User.class,BaseSession.loadProgramSession().getUserCode());
            
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getRequestForQuotationApprovalSearchFirstDate() {
        return requestForQuotationApprovalSearchFirstDate;
    }

    public void setRequestForQuotationApprovalSearchFirstDate(Date requestForQuotationApprovalSearchFirstDate) {
        this.requestForQuotationApprovalSearchFirstDate = requestForQuotationApprovalSearchFirstDate;
    }

    public Date getRequestForQuotationApprovalSearchLastDate() {
        return requestForQuotationApprovalSearchLastDate;
    }

    public void setRequestForQuotationApprovalSearchLastDate(Date requestForQuotationApprovalSearchLastDate) {
        this.requestForQuotationApprovalSearchLastDate = requestForQuotationApprovalSearchLastDate;
    }
    
}
