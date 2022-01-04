
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.RequestForQuotationBLL;
import com.inkombizz.sales.model.RequestForQuotation;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/request-for-quotation-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class RequestForQuotationClosingInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private RequestForQuotation requestForQuotationClosing;
    private Boolean requestForQuotationClosingUpdateMode = Boolean.FALSE;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession);
            
            if(requestForQuotationClosingUpdateMode){
                 if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                requestForQuotationClosing = requestForQuotationBLL.get(this.requestForQuotationClosing.getCode());
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

    public RequestForQuotation getRequestForQuotationClosing() {
        return requestForQuotationClosing;
    }

    public void setRequestForQuotationClosing(RequestForQuotation requestForQuotationClosing) {
        this.requestForQuotationClosing = requestForQuotationClosing;
    }

    public Boolean getRequestForQuotationClosingUpdateMode() {
        return requestForQuotationClosingUpdateMode;
    }

    public void setRequestForQuotationClosingUpdateMode(Boolean requestForQuotationClosingUpdateMode) {
        this.requestForQuotationClosingUpdateMode = requestForQuotationClosingUpdateMode;
    }
    
    
}
