
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.inventory.bll.PickingListSalesOrderBLL;
import com.inkombizz.inventory.model.PickingListSalesOrder;
import com.inkombizz.utils.DateUtils;

@Results({
    @Result(name="success", location="inventory/picking-list-sales-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PickingListSalesOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private PickingListSalesOrder pickingListSalesOrder;
        
    private Boolean pickingListSalesOrderUpdateMode = Boolean.FALSE;
    private Date pickingListSalesOrderTransactionDateFirstSession;
    private Date pickingListSalesOrderTransactionDateLastSession;
    private Date pickingListSalesOrderTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
                       
            if (!BaseSession.loadProgramSession().hasAuthority(pickingListSalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                return "redirect";
            }
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            pickingListSalesOrderTransactionDateFirstSession = firstDate;
            pickingListSalesOrderTransactionDateLastSession = lastDate;
            
            
            if(pickingListSalesOrderUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(pickingListSalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }      
                
                pickingListSalesOrder = pickingListSalesOrderBLL.get(pickingListSalesOrder.getCode());
                pickingListSalesOrderTransactionDate=pickingListSalesOrder.getTransactionDate();
                
            }else{        
                if (!BaseSession.loadProgramSession().hasAuthority(pickingListSalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                pickingListSalesOrder = new PickingListSalesOrder();
                pickingListSalesOrder.setCode("AUTO");
                pickingListSalesOrder.setTransactionDate(new Date());
                pickingListSalesOrderTransactionDate=pickingListSalesOrder.getTransactionDate();
                
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

    public PickingListSalesOrder getPickingListSalesOrder() {
        return pickingListSalesOrder;
    }

    public void setPickingListSalesOrder(PickingListSalesOrder pickingListSalesOrder) {
        this.pickingListSalesOrder = pickingListSalesOrder;
    }

    public Boolean getPickingListSalesOrderUpdateMode() {
        return pickingListSalesOrderUpdateMode;
    }

    public void setPickingListSalesOrderUpdateMode(Boolean pickingListSalesOrderUpdateMode) {
        this.pickingListSalesOrderUpdateMode = pickingListSalesOrderUpdateMode;
    }

    public Date getPickingListSalesOrderTransactionDateFirstSession() {
        return pickingListSalesOrderTransactionDateFirstSession;
    }

    public void setPickingListSalesOrderTransactionDateFirstSession(Date pickingListSalesOrderTransactionDateFirstSession) {
        this.pickingListSalesOrderTransactionDateFirstSession = pickingListSalesOrderTransactionDateFirstSession;
    }

    public Date getPickingListSalesOrderTransactionDateLastSession() {
        return pickingListSalesOrderTransactionDateLastSession;
    }

    public void setPickingListSalesOrderTransactionDateLastSession(Date pickingListSalesOrderTransactionDateLastSession) {
        this.pickingListSalesOrderTransactionDateLastSession = pickingListSalesOrderTransactionDateLastSession;
    }

    public Date getPickingListSalesOrderTransactionDate() {
        return pickingListSalesOrderTransactionDate;
    }

    public void setPickingListSalesOrderTransactionDate(Date pickingListSalesOrderTransactionDate) {
        this.pickingListSalesOrderTransactionDate = pickingListSalesOrderTransactionDate;
    }

    
    
}
