/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentInquiryBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/giro-payment-inquiry.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class GiroPaymentInquiryAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroPaymentInquirySearchFirstDate;
    private Date giroPaymentInquirySearchLastDate;
    private Date giroPaymentInquirySearchFirstDateDueDate;
    private Date giroPaymentInquirySearchLastDateDueDate;
    
    @Override
    public String execute() {
        try {
            GiroPaymentInquiryBLL giroPaymentInquiryBLL = new GiroPaymentInquiryBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentInquiryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroPaymentInquirySearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroPaymentInquirySearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            giroPaymentInquirySearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroPaymentInquirySearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroPaymentInquirySearchFirstDate() {
        return giroPaymentInquirySearchFirstDate;
    }

    public void setGiroPaymentInquirySearchFirstDate(Date giroPaymentInquirySearchFirstDate) {
        this.giroPaymentInquirySearchFirstDate = giroPaymentInquirySearchFirstDate;
    }

    public Date getGiroPaymentInquirySearchLastDate() {
        return giroPaymentInquirySearchLastDate;
    }

    public void setGiroPaymentInquirySearchLastDate(Date giroPaymentInquirySearchLastDate) {
        this.giroPaymentInquirySearchLastDate = giroPaymentInquirySearchLastDate;
    }

    public Date getGiroPaymentInquirySearchFirstDateDueDate() {
        return giroPaymentInquirySearchFirstDateDueDate;
    }

    public void setGiroPaymentInquirySearchFirstDateDueDate(Date giroPaymentInquirySearchFirstDateDueDate) {
        this.giroPaymentInquirySearchFirstDateDueDate = giroPaymentInquirySearchFirstDateDueDate;
    }

    public Date getGiroPaymentInquirySearchLastDateDueDate() {
        return giroPaymentInquirySearchLastDateDueDate;
    }

    public void setGiroPaymentInquirySearchLastDateDueDate(Date giroPaymentInquirySearchLastDateDueDate) {
        this.giroPaymentInquirySearchLastDateDueDate = giroPaymentInquirySearchLastDateDueDate;
    }
    
}
