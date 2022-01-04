/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedRejectBLL;
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
    @Result(name="success", location="finance/giro-received-reject-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroReceivedRejectInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GiroReceived giroReceivedReject;
    private Date giroReceivedRejectFirstDate;
    private Date giroReceivedRejectLastDate;
    private String giroReceivedRejectTransactionDateDaysName = "";
    private String giroReceivedRejectAssignmentDateDaysName = "";
    private Date transactionDate;
    
    @Override
    public String execute() {
        try {
            GiroReceivedRejectBLL giroReceivedRejectBLL = new GiroReceivedRejectBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedRejectBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
                giroReceivedReject = (GiroReceived) hbmSession.hSession.get(GiroReceived.class, giroReceivedReject.getCode());
                giroReceivedReject.setTransactionDate(giroReceivedReject.getTransactionDate());
                giroReceivedReject.setDueDate(giroReceivedReject.getDueDate());
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

    public GiroReceived getGiroReceivedReject() {
        return giroReceivedReject;
    }

    public void setGiroReceivedReject(GiroReceived giroReceivedReject) {
        this.giroReceivedReject = giroReceivedReject;
    }

    public Date getGiroReceivedRejectFirstDate() {
        return giroReceivedRejectFirstDate;
    }

    public void setGiroReceivedRejectFirstDate(Date giroReceivedRejectFirstDate) {
        this.giroReceivedRejectFirstDate = giroReceivedRejectFirstDate;
    }

    public Date getGiroReceivedRejectLastDate() {
        return giroReceivedRejectLastDate;
    }

    public void setGiroReceivedRejectLastDate(Date giroReceivedRejectLastDate) {
        this.giroReceivedRejectLastDate = giroReceivedRejectLastDate;
    }

    public String getGiroReceivedRejectTransactionDateDaysName() {
        return giroReceivedRejectTransactionDateDaysName;
    }

    public void setGiroReceivedRejectTransactionDateDaysName(String giroReceivedRejectTransactionDateDaysName) {
        this.giroReceivedRejectTransactionDateDaysName = giroReceivedRejectTransactionDateDaysName;
    }

    public String getGiroReceivedRejectAssignmentDateDaysName() {
        return giroReceivedRejectAssignmentDateDaysName;
    }

    public void setGiroReceivedRejectAssignmentDateDaysName(String giroReceivedRejectAssignmentDateDaysName) {
        this.giroReceivedRejectAssignmentDateDaysName = giroReceivedRejectAssignmentDateDaysName;
    }
    
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

}