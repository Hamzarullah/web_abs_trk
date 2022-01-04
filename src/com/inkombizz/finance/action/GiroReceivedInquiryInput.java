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
import com.inkombizz.finance.model.GiroReceived;
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
    @Result(name="success", location="finance/giro-received-inquiry-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroReceivedInquiryInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GiroReceived giroReceivedInquiry;
    private Date giroReceivedInquiryFirstDate;
    private Date giroReceivedInquiryLastDate;
    private String giroReceivedInquiryTransactionDateDaysName = "";
    private String giroReceivedInquiryAssignmentDateDaysName = "";
    private Date transactionDate;
    
    @Override
    public String execute() {
        try {
            GiroReceivedInquiryBLL giroReceivedInquiryBLL = new GiroReceivedInquiryBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedInquiryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
                giroReceivedInquiry = (GiroReceived) hbmSession.hSession.get(GiroReceived.class, giroReceivedInquiry.getCode());
                
                giroReceivedInquiry.setTransactionDate(giroReceivedInquiry.getTransactionDate());
                giroReceivedInquiry.setDueDate(giroReceivedInquiry.getDueDate());
                
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

    public GiroReceived getGiroReceivedInquiry() {
        return giroReceivedInquiry;
    }

    public void setGiroReceivedInquiry(GiroReceived giroReceivedInquiry) {
        this.giroReceivedInquiry = giroReceivedInquiry;
    }

    public Date getGiroReceivedInquiryFirstDate() {
        return giroReceivedInquiryFirstDate;
    }

    public void setGiroReceivedInquiryFirstDate(Date giroReceivedInquiryFirstDate) {
        this.giroReceivedInquiryFirstDate = giroReceivedInquiryFirstDate;
    }

    public Date getGiroReceivedInquiryLastDate() {
        return giroReceivedInquiryLastDate;
    }

    public void setGiroReceivedInquiryLastDate(Date giroReceivedInquiryLastDate) {
        this.giroReceivedInquiryLastDate = giroReceivedInquiryLastDate;
    }

    public String getGiroReceivedInquiryTransactionDateDaysName() {
        return giroReceivedInquiryTransactionDateDaysName;
    }

    public void setGiroReceivedInquiryTransactionDateDaysName(String giroReceivedInquiryTransactionDateDaysName) {
        this.giroReceivedInquiryTransactionDateDaysName = giroReceivedInquiryTransactionDateDaysName;
    }

    public String getGiroReceivedInquiryAssignmentDateDaysName() {
        return giroReceivedInquiryAssignmentDateDaysName;
    }

    public void setGiroReceivedInquiryAssignmentDateDaysName(String giroReceivedInquiryAssignmentDateDaysName) {
        this.giroReceivedInquiryAssignmentDateDaysName = giroReceivedInquiryAssignmentDateDaysName;
    }
    
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

}