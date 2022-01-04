/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.WarehouseTransferInBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author egie
 */
@Results({
    @Result(name="success", location="inventory/warehouse-transfer-in.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class WarehouseTransferInAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date warehouseTransferInSearchFirstDate;
    private Date warehouseTransferInSearchLastDate;
    
    @Override
    public String execute() {
        try {
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            warehouseTransferInSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            warehouseTransferInSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getWarehouseTransferInSearchFirstDate() {
        return warehouseTransferInSearchFirstDate;
    }

    public void setWarehouseTransferInSearchFirstDate(Date warehouseTransferInSearchFirstDate) {
        this.warehouseTransferInSearchFirstDate = warehouseTransferInSearchFirstDate;
    }

    public Date getWarehouseTransferInSearchLastDate() {
        return warehouseTransferInSearchLastDate;
    }

    public void setWarehouseTransferInSearchLastDate(Date warehouseTransferInSearchLastDate) {
        this.warehouseTransferInSearchLastDate = warehouseTransferInSearchLastDate;
    }
    
}
