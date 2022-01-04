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
    @Result(name="success", location="purchasing/purchase-order-update-information-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseOrderUpdateInformationInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PurchaseOrder purchaseOrderUpdateInformation;    
    private Date purchaseOrderUpdateInformationTransactionDate;
    private Date purchaseOrderUpdateInformationDateFirstSession;
    private Date purchaseOrderUpdateInformationDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession); 
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            purchaseOrderUpdateInformationDateFirstSession = firstDate;
            purchaseOrderUpdateInformationDateLastSession = lastDate;

            if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }

            purchaseOrderUpdateInformation = (PurchaseOrder) hbmSession.hSession.get(PurchaseOrder.class, purchaseOrderUpdateInformation.getCode());
            purchaseOrderUpdateInformationTransactionDate=purchaseOrderUpdateInformation.getTransactionDate();

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

    public PurchaseOrder getPurchaseOrderUpdateInformation() {
        return purchaseOrderUpdateInformation;
    }

    public void setPurchaseOrderUpdateInformation(PurchaseOrder purchaseOrderUpdateInformation) {
        this.purchaseOrderUpdateInformation = purchaseOrderUpdateInformation;
    }

    public Date getPurchaseOrderUpdateInformationTransactionDate() {
        return purchaseOrderUpdateInformationTransactionDate;
    }

    public void setPurchaseOrderUpdateInformationTransactionDate(Date purchaseOrderUpdateInformationTransactionDate) {
        this.purchaseOrderUpdateInformationTransactionDate = purchaseOrderUpdateInformationTransactionDate;
    }

    public Date getPurchaseOrderUpdateInformationDateFirstSession() {
        return purchaseOrderUpdateInformationDateFirstSession;
    }

    public void setPurchaseOrderUpdateInformationDateFirstSession(Date purchaseOrderUpdateInformationDateFirstSession) {
        this.purchaseOrderUpdateInformationDateFirstSession = purchaseOrderUpdateInformationDateFirstSession;
    }

    public Date getPurchaseOrderUpdateInformationDateLastSession() {
        return purchaseOrderUpdateInformationDateLastSession;
    }

    public void setPurchaseOrderUpdateInformationDateLastSession(Date purchaseOrderUpdateInformationDateLastSession) {
        this.purchaseOrderUpdateInformationDateLastSession = purchaseOrderUpdateInformationDateLastSession;
    }
    
    
    
}
