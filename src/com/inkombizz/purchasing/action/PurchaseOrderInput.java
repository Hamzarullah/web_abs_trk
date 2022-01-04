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
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.purchasing.bll.PurchaseOrderBLL;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="purchasing/purchase-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PurchaseOrder purchaseOrder;    
    private Currency currency;
    private Branch branch;
    private EnumActivity.ENUM_Activity enumPurchaseOrderActivity;
    private Date purchaseOrderTransactionDate;
    private Date purchaseOrderDateFirstSession;
    private Date purchaseOrderDateLastSession;
    
    
    @Override
    public String execute() throws Exception {
  
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession); 
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            purchaseOrderDateFirstSession = firstDate;
            purchaseOrderDateLastSession = lastDate;
            
            switch(enumPurchaseOrderActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
                    purchaseOrder = new PurchaseOrder();
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                    currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                    
                    branch = (Branch) hbmSession.hSession.get(Branch.class,user.getBranch().getCode());

                    purchaseOrder.setCode("AUTO");
                    purchaseOrder.setTransactionDate(new Date());
                    purchaseOrder.setBranch(user.getBranch());
                    purchaseOrder.setCurrency(currency);
                    purchaseOrder.setVatPercent(BaseSession.loadProgramSession().getSetup().getVatPercent());
                    
                    purchaseOrder.setBillTo(branch.getBillTo());
                    purchaseOrder.setShipTo(branch.getShipTo());
                    
                    purchaseOrder.setDeliveryDateStart(new Date());
                    purchaseOrder.setDeliveryDateEnd(new Date());
                    purchaseOrderTransactionDate=new Date();
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    purchaseOrder = (PurchaseOrder) hbmSession.hSession.get(PurchaseOrder.class, purchaseOrder.getCode());
                    purchaseOrderTransactionDate=purchaseOrder.getTransactionDate();
                
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

    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public EnumActivity.ENUM_Activity getEnumPurchaseOrderActivity() {
        return enumPurchaseOrderActivity;
    }

    public void setEnumPurchaseOrderActivity(EnumActivity.ENUM_Activity enumPurchaseOrderActivity) {
        this.enumPurchaseOrderActivity = enumPurchaseOrderActivity;
    }

    public Date getPurchaseOrderTransactionDate() {
        return purchaseOrderTransactionDate;
    }

    public void setPurchaseOrderTransactionDate(Date purchaseOrderTransactionDate) {
        this.purchaseOrderTransactionDate = purchaseOrderTransactionDate;
    }

    public Date getPurchaseOrderDateFirstSession() {
        return purchaseOrderDateFirstSession;
    }

    public void setPurchaseOrderDateFirstSession(Date purchaseOrderDateFirstSession) {
        this.purchaseOrderDateFirstSession = purchaseOrderDateFirstSession;
    }

    public Date getPurchaseOrderDateLastSession() {
        return purchaseOrderDateLastSession;
    }

    public void setPurchaseOrderDateLastSession(Date purchaseOrderDateLastSession) {
        this.purchaseOrderDateLastSession = purchaseOrderDateLastSession;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    
    
}
