
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.SalesQuotationBLL;
import com.inkombizz.sales.model.SalesQuotation;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/sales-quotation-status-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class SalesQuotationStatusInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private SalesQuotation salesQuotationStatus;
    private Boolean salesQuotationStatusUpdateMode = Boolean.FALSE;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            
            if(salesQuotationStatusUpdateMode){
                 if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE_STATUS, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                salesQuotationStatus = salesQuotationBLL.get(this.salesQuotationStatus.getCode());
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

    public Boolean getSalesQuotationStatusUpdateMode() {
        return salesQuotationStatusUpdateMode;
    }

    public void setSalesQuotationStatusUpdateMode(Boolean salesQuotationStatusUpdateMode) {
        this.salesQuotationStatusUpdateMode = salesQuotationStatusUpdateMode;
    }

    public SalesQuotation getSalesQuotationStatus() {
        return salesQuotationStatus;
    }

    public void setSalesQuotationStatus(SalesQuotation salesQuotationStatus) {
        this.salesQuotationStatus = salesQuotationStatus;
    }
    
    
}
