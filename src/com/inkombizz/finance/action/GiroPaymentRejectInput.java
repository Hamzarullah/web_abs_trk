/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentRejectBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentRejectTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author egie
 */
@Results({
    @Result(name="success", location="finance/giro-payment-reject-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroPaymentRejectInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GiroPayment giroPaymentRejected;
    private Date giroPaymentRejectFirstDate;
    private Date giroPaymentRejectLastDate;
    private String giroPaymentRejectTransactionDateDaysName = "";
    private String giroPaymentRejectAssignmentDateDaysName = "";
    private Date transactionDate;
    
    @Override
    public String execute() {
        try {
            GiroPaymentRejectBLL giroPaymentRejectBLL = new GiroPaymentRejectBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentRejectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
                giroPaymentRejected = (GiroPayment) hbmSession.hSession.get(GiroPayment.class, giroPaymentRejected.getCode());
                
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

    public GiroPayment getGiroPaymentRejected() {
        return giroPaymentRejected;
    }

    public void setGiroPaymentRejected(GiroPayment giroPaymentRejected) {
        this.giroPaymentRejected = giroPaymentRejected;
    }

    public Date getGiroPaymentRejectFirstDate() {
        return giroPaymentRejectFirstDate;
    }

    public void setGiroPaymentRejectFirstDate(Date giroPaymentRejectFirstDate) {
        this.giroPaymentRejectFirstDate = giroPaymentRejectFirstDate;
    }

    public Date getGiroPaymentRejectLastDate() {
        return giroPaymentRejectLastDate;
    }

    public void setGiroPaymentRejectLastDate(Date giroPaymentRejectLastDate) {
        this.giroPaymentRejectLastDate = giroPaymentRejectLastDate;
    }

    public String getGiroPaymentRejectTransactionDateDaysName() {
        return giroPaymentRejectTransactionDateDaysName;
    }

    public void setGiroPaymentRejectTransactionDateDaysName(String giroPaymentRejectTransactionDateDaysName) {
        this.giroPaymentRejectTransactionDateDaysName = giroPaymentRejectTransactionDateDaysName;
    }

    public String getGiroPaymentRejectAssignmentDateDaysName() {
        return giroPaymentRejectAssignmentDateDaysName;
    }

    public void setGiroPaymentRejectAssignmentDateDaysName(String giroPaymentRejectAssignmentDateDaysName) {
        this.giroPaymentRejectAssignmentDateDaysName = giroPaymentRejectAssignmentDateDaysName;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    
    
}