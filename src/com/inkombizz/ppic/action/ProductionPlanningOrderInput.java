
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="ppic/production-planning-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ProductionPlanningOrderInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private ProductionPlanningOrder productionPlanningOrder=new ProductionPlanningOrder();
    private boolean productionPlanningOrderUpdateMode = false;
    private Date productionPlanningOrderDateFirstSession;
    private Date productionPlanningOrderDateLastSession;
    
    @Override
    public String execute(){
  
        try {                
            ProductionPlanningOrderBLL productionPlanningOrderBLL = new ProductionPlanningOrderBLL(hbmSession);  
            
            productionPlanningOrderDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            productionPlanningOrderDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                    
                                
            if(productionPlanningOrderUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                productionPlanningOrder = (ProductionPlanningOrder) hbmSession.hSession.get(ProductionPlanningOrder.class, productionPlanningOrder.getCode());
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                productionPlanningOrder = new ProductionPlanningOrder();
                productionPlanningOrder.setCode("AUTO");

                productionPlanningOrder.setTransactionDate(new Date());
                productionPlanningOrder.setTargetDate(new Date());
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                productionPlanningOrder.setBranch(user.getBranch());
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

    public ProductionPlanningOrder getProductionPlanningOrder() {
        return productionPlanningOrder;
    }

    public void setProductionPlanningOrder(ProductionPlanningOrder productionPlanningOrder) {
        this.productionPlanningOrder = productionPlanningOrder;
    }

    public boolean isProductionPlanningOrderUpdateMode() {
        return productionPlanningOrderUpdateMode;
    }

    public void setProductionPlanningOrderUpdateMode(boolean productionPlanningOrderUpdateMode) {
        this.productionPlanningOrderUpdateMode = productionPlanningOrderUpdateMode;
    }

    public Date getProductionPlanningOrderDateFirstSession() {
        return productionPlanningOrderDateFirstSession;
    }

    public void setProductionPlanningOrderDateFirstSession(Date productionPlanningOrderDateFirstSession) {
        this.productionPlanningOrderDateFirstSession = productionPlanningOrderDateFirstSession;
    }

    public Date getProductionPlanningOrderDateLastSession() {
        return productionPlanningOrderDateLastSession;
    }

    public void setProductionPlanningOrderDateLastSession(Date productionPlanningOrderDateLastSession) {
        this.productionPlanningOrderDateLastSession = productionPlanningOrderDateLastSession;
    }

    
}
