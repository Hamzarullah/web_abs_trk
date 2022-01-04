
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
    @Result(name="success", location="sales/sales-quotation.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class SalesQuotationAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date salesQuotationSearchFirstDate;
    private Date salesQuotationSearchLastDate;
    
    @Override
    public String execute() {
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            salesQuotationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            salesQuotationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
            
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

    public Date getSalesQuotationSearchFirstDate() {
        return salesQuotationSearchFirstDate;
    }

    public void setSalesQuotationSearchFirstDate(Date salesQuotationSearchFirstDate) {
        this.salesQuotationSearchFirstDate = salesQuotationSearchFirstDate;
    }

    public Date getSalesQuotationSearchLastDate() {
        return salesQuotationSearchLastDate;
    }

    public void setSalesQuotationSearchLastDate(Date salesQuotationSearchLastDate) {
        this.salesQuotationSearchLastDate = salesQuotationSearchLastDate;
    }

}
