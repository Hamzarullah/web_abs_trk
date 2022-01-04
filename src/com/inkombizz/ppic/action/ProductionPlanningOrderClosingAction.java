
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="ppic/production-planning-order-closing.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ProductionPlanningOrderClosingAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ProductionPlanningOrder productionPlanningOrderClosing=new ProductionPlanningOrder();
    Date productionPlanningOrderClosingSearchFirstDate;
    Date productionPlanningOrderClosingSearchLastDate;

    
    @Override
    public String execute() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            } 
            
            productionPlanningOrderClosingSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            productionPlanningOrderClosingSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

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

    public ProductionPlanningOrder getProductionPlanningOrderClosing() {
        return productionPlanningOrderClosing;
    }

    public void setProductionPlanningOrderClosing(ProductionPlanningOrder productionPlanningOrderClosing) {
        this.productionPlanningOrderClosing = productionPlanningOrderClosing;
    }

    public Date getProductionPlanningOrderClosingSearchFirstDate() {
        return productionPlanningOrderClosingSearchFirstDate;
    }

    public void setProductionPlanningOrderClosingSearchFirstDate(Date productionPlanningOrderClosingSearchFirstDate) {
        this.productionPlanningOrderClosingSearchFirstDate = productionPlanningOrderClosingSearchFirstDate;
    }

    public Date getProductionPlanningOrderClosingSearchLastDate() {
        return productionPlanningOrderClosingSearchLastDate;
    }

    public void setProductionPlanningOrderClosingSearchLastDate(Date productionPlanningOrderClosingSearchLastDate) {
        this.productionPlanningOrderClosingSearchLastDate = productionPlanningOrderClosingSearchLastDate;
    }

    
    

    
}
