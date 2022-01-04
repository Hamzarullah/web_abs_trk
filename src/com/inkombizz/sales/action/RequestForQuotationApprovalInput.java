
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.RequestForQuotationBLL;
import com.inkombizz.sales.model.RequestForQuotation;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/request-for-quotation-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class RequestForQuotationApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private RequestForQuotation requestForQuotationApproval;
    private Boolean requestForQuotationApprovalUpdateMode = Boolean.FALSE;
    private Date requestForQuotationApprovalTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            
            if(requestForQuotationApprovalUpdateMode){
                 if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                requestForQuotationApproval = requestForQuotationBLL.get(this.requestForQuotationApproval.getCode());
                requestForQuotationApprovalTransactionDate = requestForQuotationApproval.getTransactionDate();
            }
            
                    
            return SUCCESS;
                
        } catch (Exception e) {
            e.printStackTrace();
        }
   
        return SUCCESS;
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public RequestForQuotation getRequestForQuotationApproval() {
        return requestForQuotationApproval;
    }

    public void setRequestForQuotationApproval(RequestForQuotation requestForQuotationApproval) {
        this.requestForQuotationApproval = requestForQuotationApproval;
    }

    public Boolean getRequestForQuotationApprovalUpdateMode() {
        return requestForQuotationApprovalUpdateMode;
    }

    public void setRequestForQuotationApprovalUpdateMode(Boolean requestForQuotationApprovalUpdateMode) {
        this.requestForQuotationApprovalUpdateMode = requestForQuotationApprovalUpdateMode;
    }

    public Date getRequestForQuotationApprovalTransactionDate() {
        return requestForQuotationApprovalTransactionDate;
    }

    public void setRequestForQuotationApprovalTransactionDate(Date requestForQuotationApprovalTransactionDate) {
        this.requestForQuotationApprovalTransactionDate = requestForQuotationApprovalTransactionDate;
    }
    
    
}
