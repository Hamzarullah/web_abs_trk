/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentInquiryBLL;
import com.inkombizz.finance.model.GiroPayment;
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
    @Result(name="success", location="finance/giro-payment-inquiry-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroPaymentInquiryInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GiroPayment giroPaymentInquiry;
    private Date giroPaymentInquiryFirstDate;
    private Date giroPaymentInquiryLastDate;
    private String giroPaymentInquiryTransactionDateDaysName = "";
    private String giroPaymentInquiryAssignmentDateDaysName = "";
    private Date transactionDate;
    
    @Override
    public String execute() {
        try {
            GiroPaymentInquiryBLL giroPaymentInquiryBLL = new GiroPaymentInquiryBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentInquiryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
                giroPaymentInquiry = (GiroPayment) hbmSession.hSession.get(GiroPayment.class, giroPaymentInquiry.getCode());
                
            return SUCCESS;
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public GiroPayment getGiroPaymentInquiry() {
        return giroPaymentInquiry;
    }

    public void setGiroPaymentInquiry(GiroPayment giroPaymentInquiry) {
        this.giroPaymentInquiry = giroPaymentInquiry;
    }

    public Date getGiroPaymentInquiryFirstDate() {
        return giroPaymentInquiryFirstDate;
    }

    public void setGiroPaymentInquiryFirstDate(Date giroPaymentInquiryFirstDate) {
        this.giroPaymentInquiryFirstDate = giroPaymentInquiryFirstDate;
    }

    public Date getGiroPaymentInquiryLastDate() {
        return giroPaymentInquiryLastDate;
    }

    public void setGiroPaymentInquiryLastDate(Date giroPaymentInquiryLastDate) {
        this.giroPaymentInquiryLastDate = giroPaymentInquiryLastDate;
    }

    public String getGiroPaymentInquiryTransactionDateDaysName() {
        return giroPaymentInquiryTransactionDateDaysName;
    }

    public void setGiroPaymentInquiryTransactionDateDaysName(String giroPaymentInquiryTransactionDateDaysName) {
        this.giroPaymentInquiryTransactionDateDaysName = giroPaymentInquiryTransactionDateDaysName;
    }

    public String getGiroPaymentInquiryAssignmentDateDaysName() {
        return giroPaymentInquiryAssignmentDateDaysName;
    }

    public void setGiroPaymentInquiryAssignmentDateDaysName(String giroPaymentInquiryAssignmentDateDaysName) {
        this.giroPaymentInquiryAssignmentDateDaysName = giroPaymentInquiryAssignmentDateDaysName;
    }
    
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

}