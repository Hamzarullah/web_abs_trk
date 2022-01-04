/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseOrderBLL;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="purchasing/purchase-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseOrderAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseOrder purchaseOrder = new PurchaseOrder();
    
    @Override
    public String execute() {
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
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
    
    
}
