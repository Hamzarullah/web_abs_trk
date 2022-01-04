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
    @Result(name="success", location="purchasing/purchase-order-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseOrderApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PurchaseOrder purchaseOrderApproval;    
    private Currency currency;
    private EnumActivity.ENUM_Activity enumPurchaseOrderApprovalActivity;
    private Date purchaseOrderApprovalTransactionDate;
    private Date purchaseOrderApprovalDateFirstSession;
    private Date purchaseOrderApprovalDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession); 
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);

            purchaseOrderApprovalDateFirstSession = firstDate;
            purchaseOrderApprovalDateLastSession = lastDate;
            
            switch(enumPurchaseOrderApprovalActivity){
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    purchaseOrderApproval = (PurchaseOrder) hbmSession.hSession.get(PurchaseOrder.class, purchaseOrderApproval.getCode());
                    purchaseOrderApprovalTransactionDate=purchaseOrderApproval.getTransactionDate();
                
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

    public PurchaseOrder getPurchaseOrderApproval() {
        return purchaseOrderApproval;
    }

    public void setPurchaseOrderApproval(PurchaseOrder purchaseOrderApproval) {
        this.purchaseOrderApproval = purchaseOrderApproval;
    }

    public Date getPurchaseOrderApprovalTransactionDate() {
        return purchaseOrderApprovalTransactionDate;
    }

    public void setPurchaseOrderApprovalTransactionDate(Date purchaseOrderApprovalTransactionDate) {
        this.purchaseOrderApprovalTransactionDate = purchaseOrderApprovalTransactionDate;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public EnumActivity.ENUM_Activity getEnumPurchaseOrderApprovalActivity() {
        return enumPurchaseOrderApprovalActivity;
    }

    public void setEnumPurchaseOrderApprovalActivity(EnumActivity.ENUM_Activity enumPurchaseOrderApprovalActivity) {
        this.enumPurchaseOrderApprovalActivity = enumPurchaseOrderApprovalActivity;
    }

    public Date getPurchaseOrderApprovalDateFirstSession() {
        return purchaseOrderApprovalDateFirstSession;
    }

    public void setPurchaseOrderApprovalDateFirstSession(Date purchaseOrderApprovalDateFirstSession) {
        this.purchaseOrderApprovalDateFirstSession = purchaseOrderApprovalDateFirstSession;
    }

    public Date getPurchaseOrderApprovalDateLastSession() {
        return purchaseOrderApprovalDateLastSession;
    }

    public void setPurchaseOrderApprovalDateLastSession(Date purchaseOrderApprovalDateLastSession) {
        this.purchaseOrderApprovalDateLastSession = purchaseOrderApprovalDateLastSession;
    }
    
    
    
}
