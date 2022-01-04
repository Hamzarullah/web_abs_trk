/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Currency;
import com.inkombizz.purchasing.bll.PurchaseOrderBLL;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-order-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseOrderClosingInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PurchaseOrder purchaseOrderClosing;    
    private Currency currency;
    private EnumActivity.ENUM_Activity enumPurchaseOrderClosingActivity;
    private Date purchaseOrderClosingTransactionDate;
    private Date purchaseOrderClosingDateFirstSession;
    private Date purchaseOrderClosingDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession); 
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            purchaseOrderClosingDateFirstSession = firstDate;
            purchaseOrderClosingDateLastSession = lastDate;
            
            switch(enumPurchaseOrderClosingActivity){
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    purchaseOrderClosing = (PurchaseOrder) hbmSession.hSession.get(PurchaseOrder.class, purchaseOrderClosing.getCode());
                    purchaseOrderClosingTransactionDate=purchaseOrderClosing.getTransactionDate();
                
                    break;
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

    public PurchaseOrder getPurchaseOrderClosing() {
        return purchaseOrderClosing;
    }

    public void setPurchaseOrderClosing(PurchaseOrder purchaseOrderClosing) {
        this.purchaseOrderClosing = purchaseOrderClosing;
    }

    public Date getPurchaseOrderClosingTransactionDate() {
        return purchaseOrderClosingTransactionDate;
    }

    public void setPurchaseOrderClosingTransactionDate(Date purchaseOrderClosingTransactionDate) {
        this.purchaseOrderClosingTransactionDate = purchaseOrderClosingTransactionDate;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public EnumActivity.ENUM_Activity getEnumPurchaseOrderClosingActivity() {
        return enumPurchaseOrderClosingActivity;
    }

    public void setEnumPurchaseOrderClosingActivity(EnumActivity.ENUM_Activity enumPurchaseOrderClosingActivity) {
        this.enumPurchaseOrderClosingActivity = enumPurchaseOrderClosingActivity;
    }

    public Date getPurchaseOrderClosingDateFirstSession() {
        return purchaseOrderClosingDateFirstSession;
    }

    public void setPurchaseOrderClosingDateFirstSession(Date purchaseOrderClosingDateFirstSession) {
        this.purchaseOrderClosingDateFirstSession = purchaseOrderClosingDateFirstSession;
    }

    public Date getPurchaseOrderClosingDateLastSession() {
        return purchaseOrderClosingDateLastSession;
    }

    public void setPurchaseOrderClosingDateLastSession(Date purchaseOrderClosingDateLastSession) {
        this.purchaseOrderClosingDateLastSession = purchaseOrderClosingDateLastSession;
    }
    
}
