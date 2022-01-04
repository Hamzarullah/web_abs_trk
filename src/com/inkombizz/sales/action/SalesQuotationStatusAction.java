
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.SalesQuotationBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/sales-quotation-status.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class SalesQuotationStatusAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date salesQuotationStatusSearchFirstDate;
    private Date salesQuotationStatusSearchLastDate;
    
    @Override
    public String execute() {
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE_STATUS, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            salesQuotationStatusSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            salesQuotationStatusSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
            
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

    public Date getSalesQuotationStatusSearchFirstDate() {
        return salesQuotationStatusSearchFirstDate;
    }

    public void setSalesQuotationStatusSearchFirstDate(Date salesQuotationStatusSearchFirstDate) {
        this.salesQuotationStatusSearchFirstDate = salesQuotationStatusSearchFirstDate;
    }

    public Date getSalesQuotationStatusSearchLastDate() {
        return salesQuotationStatusSearchLastDate;
    }

    public void setSalesQuotationStatusSearchLastDate(Date salesQuotationStatusSearchLastDate) {
        this.salesQuotationStatusSearchLastDate = salesQuotationStatusSearchLastDate;
    }

    

}
