/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedInquiryBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Rayis
 */
@Results({
    @Result(name="success", location="finance/giro-received-inquiry.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroReceivedInquiryAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date giroReceivedInquirySearchFirstDate;
    private Date giroReceivedInquirySearchLastDate;
    private Date giroReceivedInquirySearchFirstDateDueDate;
    private Date giroReceivedInquirySearchLastDateDueDate;
    
    @Override
    public String execute() {
        try {
            GiroReceivedInquiryBLL giroReceivedInquiryBLL = new GiroReceivedInquiryBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedInquiryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            giroReceivedInquirySearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroReceivedInquirySearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            giroReceivedInquirySearchFirstDateDueDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            giroReceivedInquirySearchLastDateDueDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getGiroReceivedInquirySearchFirstDate() {
        return giroReceivedInquirySearchFirstDate;
    }

    public void setGiroReceivedInquirySearchFirstDate(Date giroReceivedInquirySearchFirstDate) {
        this.giroReceivedInquirySearchFirstDate = giroReceivedInquirySearchFirstDate;
    }

    public Date getGiroReceivedInquirySearchLastDate() {
        return giroReceivedInquirySearchLastDate;
    }

    public void setGiroReceivedInquirySearchLastDate(Date giroReceivedInquirySearchLastDate) {
        this.giroReceivedInquirySearchLastDate = giroReceivedInquirySearchLastDate;
    }

    public Date getGiroReceivedInquirySearchFirstDateDueDate() {
        return giroReceivedInquirySearchFirstDateDueDate;
    }

    public void setGiroReceivedInquirySearchFirstDateDueDate(Date giroReceivedInquirySearchFirstDateDueDate) {
        this.giroReceivedInquirySearchFirstDateDueDate = giroReceivedInquirySearchFirstDateDueDate;
    }

    public Date getGiroReceivedInquirySearchLastDateDueDate() {
        return giroReceivedInquirySearchLastDateDueDate;
    }

    public void setGiroReceivedInquirySearchLastDateDueDate(Date giroReceivedInquirySearchLastDateDueDate) {
        this.giroReceivedInquirySearchLastDateDueDate = giroReceivedInquirySearchLastDateDueDate;
    }
    
}
