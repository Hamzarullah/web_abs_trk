
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
    @Result(name="success", location="ppic/production-planning-order-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ProductionPlanningOrderApprovalAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ProductionPlanningOrder productionPlanningOrderApproval=new ProductionPlanningOrder();
    Date productionPlanningOrderApprovalSearchFirstDate;
    Date productionPlanningOrderApprovalSearchLastDate;

    
    @Override
    public String execute() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            } 
            
            productionPlanningOrderApprovalSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            productionPlanningOrderApprovalSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

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

    public ProductionPlanningOrder getProductionPlanningOrderApproval() {
        return productionPlanningOrderApproval;
    }

    public void setProductionPlanningOrderApproval(ProductionPlanningOrder productionPlanningOrderApproval) {
        this.productionPlanningOrderApproval = productionPlanningOrderApproval;
    }

    public Date getProductionPlanningOrderApprovalSearchFirstDate() {
        return productionPlanningOrderApprovalSearchFirstDate;
    }

    public void setProductionPlanningOrderApprovalSearchFirstDate(Date productionPlanningOrderApprovalSearchFirstDate) {
        this.productionPlanningOrderApprovalSearchFirstDate = productionPlanningOrderApprovalSearchFirstDate;
    }

    public Date getProductionPlanningOrderApprovalSearchLastDate() {
        return productionPlanningOrderApprovalSearchLastDate;
    }

    public void setProductionPlanningOrderApprovalSearchLastDate(Date productionPlanningOrderApprovalSearchLastDate) {
        this.productionPlanningOrderApprovalSearchLastDate = productionPlanningOrderApprovalSearchLastDate;
    }

    
    

    
}
