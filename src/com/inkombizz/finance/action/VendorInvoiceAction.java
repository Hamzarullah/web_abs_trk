/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorInvoiceBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author sukha
 */
@Results({
    @Result(name="success", location="finance/vendor-invoice.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorInvoiceAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date vendorInvoiceSearchFirstDate;
    private Date vendorInvoiceSearchLastDate;
    private Date vendorInvoiceSearchFirstDueDate;
    private Date vendorInvoiceSearchLastDueDate;
    
    @Override
    public String execute() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(vendorInvoiceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            this.vendorInvoiceSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
            this.vendorInvoiceSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
            
            this.vendorInvoiceSearchFirstDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
            this.vendorInvoiceSearchLastDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getVendorInvoiceSearchFirstDate() {
        return vendorInvoiceSearchFirstDate;
    }

    public void setVendorInvoiceSearchFirstDate(Date vendorInvoiceSearchFirstDate) {
        this.vendorInvoiceSearchFirstDate = vendorInvoiceSearchFirstDate;
    }

    public Date getVendorInvoiceSearchLastDate() {
        return vendorInvoiceSearchLastDate;
    }

    public void setVendorInvoiceSearchLastDate(Date vendorInvoiceSearchLastDate) {
        this.vendorInvoiceSearchLastDate = vendorInvoiceSearchLastDate;
    }

    public Date getVendorInvoiceSearchFirstDueDate() {
        return vendorInvoiceSearchFirstDueDate;
    }

    public void setVendorInvoiceSearchFirstDueDate(Date vendorInvoiceSearchFirstDueDate) {
        this.vendorInvoiceSearchFirstDueDate = vendorInvoiceSearchFirstDueDate;
    }

    public Date getVendorInvoiceSearchLastDueDate() {
        return vendorInvoiceSearchLastDueDate;
    }

    public void setVendorInvoiceSearchLastDueDate(Date vendorInvoiceSearchLastDueDate) {
        this.vendorInvoiceSearchLastDueDate = vendorInvoiceSearchLastDueDate;
    }
    
   
    
}
