/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.WarehouseTransferOutBLL;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author egie
 */
@Results({
    @Result(name="success", location="inventory/warehouse-transfer-out.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class WarehouseTransferOutAction extends ActionSupport{
  
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date warehouseTransferOutSearchFirstDate;
    private Date warehouseTransferOutSearchLastDate;
    
    @Override
    public String execute() {
        try {
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            warehouseTransferOutSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            warehouseTransferOutSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getWarehouseTransferOutSearchFirstDate() {
        return warehouseTransferOutSearchFirstDate;
    }

    public void setWarehouseTransferOutSearchFirstDate(Date warehouseTransferOutSearchFirstDate) {
        this.warehouseTransferOutSearchFirstDate = warehouseTransferOutSearchFirstDate;
    }

    public Date getWarehouseTransferOutSearchLastDate() {
        return warehouseTransferOutSearchLastDate;
    }

    public void setWarehouseTransferOutSearchLastDate(Date warehouseTransferOutSearchLastDate) {
        this.warehouseTransferOutSearchLastDate = warehouseTransferOutSearchLastDate;
    }
}
