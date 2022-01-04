
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.PickingListSalesOrderBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="inventory/picking-list-sales-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PickingListSalesOrderAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date pickingListSalesOrderSearchFirstDate;
    private Date pickingListSalesOrderSearchLastDate;
    
    @Override
    public String execute() {
        try {
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(pickingListSalesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            pickingListSalesOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            pickingListSalesOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
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

    public Date getPickingListSalesOrderSearchFirstDate() {
        return pickingListSalesOrderSearchFirstDate;
    }

    public void setPickingListSalesOrderSearchFirstDate(Date pickingListSalesOrderSearchFirstDate) {
        this.pickingListSalesOrderSearchFirstDate = pickingListSalesOrderSearchFirstDate;
    }

    public Date getPickingListSalesOrderSearchLastDate() {
        return pickingListSalesOrderSearchLastDate;
    }

    public void setPickingListSalesOrderSearchLastDate(Date pickingListSalesOrderSearchLastDate) {
        this.pickingListSalesOrderSearchLastDate = pickingListSalesOrderSearchLastDate;
    }

    
    
}
