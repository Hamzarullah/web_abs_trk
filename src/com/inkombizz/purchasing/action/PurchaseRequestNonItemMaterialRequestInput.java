
package com.inkombizz.purchasing.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequest;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="purchasing/purchase-request-non-item-material-request-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PurchaseRequestNonItemMaterialRequestInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest =new PurchaseRequestNonItemMaterialRequest();
    private Boolean purchaseRequestNonItemMaterialRequestUpdateMode= Boolean.FALSE;
    
    @Override
    public String execute() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
                        
            if(purchaseRequestNonItemMaterialRequestUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                purchaseRequestNonItemMaterialRequest = (PurchaseRequestNonItemMaterialRequest) hbmSession.hSession.get(PurchaseRequestNonItemMaterialRequest.class, purchaseRequestNonItemMaterialRequest.getCode());
                                
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }           

                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonItemMaterialRequest.setTransactionDate(new Date());
                purchaseRequestNonItemMaterialRequest.setCode("AUTO");
                purchaseRequestNonItemMaterialRequest.setBranch(user.getBranch());
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

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequest() {
        return purchaseRequestNonItemMaterialRequest;
    }

    public void setPurchaseRequestNonItemMaterialRequest(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest) {
        this.purchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequest;
    }

    public Boolean getPurchaseRequestNonItemMaterialRequestUpdateMode() {
        return purchaseRequestNonItemMaterialRequestUpdateMode;
    }

    public void setPurchaseRequestNonItemMaterialRequestUpdateMode(Boolean purchaseRequestNonItemMaterialRequestUpdateMode) {
        this.purchaseRequestNonItemMaterialRequestUpdateMode = purchaseRequestNonItemMaterialRequestUpdateMode;
    }

    public Boolean getPurchaseRequestNonSalesOrderUpdateMode() {
        return purchaseRequestNonItemMaterialRequestUpdateMode;
    }

    public void setPurchaseRequestNonSalesOrderUpdateMode(Boolean purchaseRequestNonItemMaterialRequestUpdateMode) {
        this.purchaseRequestNonItemMaterialRequestUpdateMode = purchaseRequestNonItemMaterialRequestUpdateMode;
    }
    
    

}
