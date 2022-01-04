
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Currency;
import com.inkombizz.sales.bll.RequestForQuotationBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.sales.model.RequestForQuotation;
import com.inkombizz.sales.model.RequestForQuotationTemp;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;

@Results({
    @Result(name="success", location="sales/request-for-quotation-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class RequestForQuotationInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private RequestForQuotation requestForQuotation =new RequestForQuotation();
    private Boolean requestForQuotationUpdateMode = Boolean.FALSE;
    private Boolean requestForQuotationCloneMode = Boolean.FALSE;
    private Boolean requestForQuotationReviseMode = Boolean.FALSE;
    private Date requestForQuotationTransactionDate;
    private String code="";
    private RequestForQuotationTemp requestForQuotationTemp = new RequestForQuotationTemp();
    
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            RequestForQuotationBLL requestForQuotationBLL = new RequestForQuotationBLL(hbmSession); 
            
            if(requestForQuotationUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                requestForQuotation = (RequestForQuotation) hbmSession.hSession.get(RequestForQuotation.class, requestForQuotation.getCode());
                requestForQuotation.setTransactionDate(requestForQuotation.getTransactionDate());
                requestForQuotationTransactionDate = requestForQuotation.getTransactionDate();
                requestForQuotation.setRefRfqCode(requestForQuotation.getRefRfqCode());
                
            }else if(requestForQuotationCloneMode){
                if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                requestForQuotation = (RequestForQuotation) hbmSession.hSession.get(RequestForQuotation.class, requestForQuotation.getCode());
                requestForQuotation.setTransactionDate(new Date());
                requestForQuotationTransactionDate = new Date();
                requestForQuotation.setCode("AUTO");
                requestForQuotation.setRfqNo("AUTO");
                requestForQuotation.setRefRfqCode("");
                
            }else if(requestForQuotationReviseMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                String RefRfqCode=requestForQuotation.getCode();
                requestForQuotation = (RequestForQuotation) hbmSession.hSession.get(RequestForQuotation.class, requestForQuotation.getCode());
                requestForQuotation.setTransactionDate(new Date());
                requestForQuotationTransactionDate = new Date();
                String newCode = requestForQuotationBLL.createRevise(requestForQuotation);
                requestForQuotation.setCode(newCode);
                requestForQuotation.setRefRfqCode(RefRfqCode);
            
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(requestForQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }            
                
                //module = (Module) hbmSession.hSession.get(Module.class, requestForQuotationBLL.MODULECODE);
                
                requestForQuotation = new RequestForQuotation();
                requestForQuotation.setCode("AUTO");
                requestForQuotation.setRefRfqCode("");
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                requestForQuotation.setBranch(user.getBranch());               
                
                Currency currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                requestForQuotation.setCurrency(currency);
                        
                requestForQuotation.setTransactionDate(new Date());
                requestForQuotationTransactionDate = new Date();
                requestForQuotation.setRegisteredDate(new Date());
                requestForQuotation.setPreBidMeeting(new Date());
                requestForQuotation.setSendToFactoryDate(new Date());
                requestForQuotation.setSubmittedDateToCustomer(new Date());
                requestForQuotation.setApprovalDate(new Date());
                
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

    public RequestForQuotation getRequestForQuotation() {
        return requestForQuotation;
    }

    public void setRequestForQuotation(RequestForQuotation requestForQuotation) {
        this.requestForQuotation = requestForQuotation;
    }

    public Boolean getRequestForQuotationUpdateMode() {
        return requestForQuotationUpdateMode;
    }

    public void setRequestForQuotationUpdateMode(Boolean requestForQuotationUpdateMode) {
        this.requestForQuotationUpdateMode = requestForQuotationUpdateMode;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Boolean getRequestForQuotationCloneMode() {
        return requestForQuotationCloneMode;
    }

    public void setRequestForQuotationCloneMode(Boolean requestForQuotationCloneMode) {
        this.requestForQuotationCloneMode = requestForQuotationCloneMode;
    }

    public Boolean getRequestForQuotationReviseMode() {
        return requestForQuotationReviseMode;
    }

    public void setRequestForQuotationReviseMode(Boolean requestForQuotationReviseMode) {
        this.requestForQuotationReviseMode = requestForQuotationReviseMode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public RequestForQuotationTemp getRequestForQuotationTemp() {
        return requestForQuotationTemp;
    }

    public void setRequestForQuotationTemp(RequestForQuotationTemp requestForQuotationTemp) {
        this.requestForQuotationTemp = requestForQuotationTemp;
    }

    public Date getRequestForQuotationTransactionDate() {
        return requestForQuotationTransactionDate;
    }

    public void setRequestForQuotationTransactionDate(Date requestForQuotationTransactionDate) {
        this.requestForQuotationTransactionDate = requestForQuotationTransactionDate;
    }
    
}
