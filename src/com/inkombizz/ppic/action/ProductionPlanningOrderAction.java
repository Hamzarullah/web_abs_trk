
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="ppic/production-planning-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ProductionPlanningOrderAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ProductionPlanningOrder productionPlanningOrder=new ProductionPlanningOrder();

    
    @Override
    public String execute() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           

            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ProductionPlanningOrder getProductionPlanningOrder() {
        return productionPlanningOrder;
    }

    public void setProductionPlanningOrder(ProductionPlanningOrder productionPlanningOrder) {
        this.productionPlanningOrder = productionPlanningOrder;
    }

    
}
