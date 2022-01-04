
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrder;

@Results({
    @Result(name="success", location="ppic/production-planning-order-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ProductionPlanningOrderApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private ProductionPlanningOrder productionPlanningOrderApproval;
    private boolean productionPlanningOrderApprovalUpdateMode = false;
                
    @Override
    public String execute() throws Exception {
  
        try {                
            ProductionPlanningOrderBLL productionPlanningOrderBLL = new ProductionPlanningOrderBLL(hbmSession);

                if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningOrderBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }

                productionPlanningOrderApproval = productionPlanningOrderBLL.get(this.productionPlanningOrderApproval.getCode());
            
            
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

    public ProductionPlanningOrder getProductionPlanningOrderApproval() {
        return productionPlanningOrderApproval;
    }

    public void setProductionPlanningOrderApproval(ProductionPlanningOrder productionPlanningOrderApproval) {
        this.productionPlanningOrderApproval = productionPlanningOrderApproval;
    }

    public boolean isProductionPlanningOrderApprovalUpdateMode() {
        return productionPlanningOrderApprovalUpdateMode;
    }

    public void setProductionPlanningOrderApprovalUpdateMode(boolean productionPlanningOrderApprovalUpdateMode) {
        this.productionPlanningOrderApprovalUpdateMode = productionPlanningOrderApprovalUpdateMode;
    }

   
    
    
}
