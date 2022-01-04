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
import com.inkombizz.inventory.model.WarehouseTransferIn;
//import com.inkombizz.inventory.model.WarehouseMutationReceiving;
import com.inkombizz.master.model.Rack;
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
    @Result(name="success", location="inventory/warehouse-transfer-in-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class WarehouseTransferInInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private WarehouseTransferIn warehouseTransferIn;
    
//    private Rack rack;
    private boolean warehouseTransferInUpdateMode = false;
    private Date warehouseTransferInTransactionDateFirstSession;
    private Date warehouseTransferInTransactionDateLastSession;
    
    private Date warehouseTransferInTransactionDate;
//    private String defaultRackCode = "";
//    private String defaultRackName = "";
    
    @Override
    public String execute(){
  
        try {                
            WarehouseTransferInBLL warehouseTransferInBLL = new WarehouseTransferInBLL(hbmSession);  
                        
            warehouseTransferInTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            warehouseTransferInTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                                   
            if(warehouseTransferInUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
//                warehouseTransferIn = (WarehouseMutationReceiving) hbmSession.hSession.get(WarehouseMutationReceiving.class, warehouseTransferIn.getCode());
//                warehouseTransferInTransactionDate = warehouseTransferIn.getTransactionDate();
//                rack = (Rack)hbmSession.hSession.get(Rack.class,warehouseTransferIn.getDestinationWarehouse().getDefaultRackCode());
                
//                if(rack!=null){
//                    this.defaultRackCode = rack.getCode();
//                    this.defaultRackName = rack.getName();
//                }
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                warehouseTransferIn = new WarehouseTransferIn();
                warehouseTransferIn.setCode("AUTO");
                warehouseTransferIn.setTransactionDate(new Date());
                warehouseTransferInTransactionDate=new Date();
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

    public WarehouseTransferIn getWarehouseTransferIn() {
        return warehouseTransferIn;
    }

    public void setWarehouseTransferIn(WarehouseTransferIn warehouseTransferIn) {
        this.warehouseTransferIn = warehouseTransferIn;
    }

    public boolean isWarehouseTransferInUpdateMode() {
        return warehouseTransferInUpdateMode;
    }

    public void setWarehouseTransferInUpdateMode(boolean warehouseTransferInUpdateMode) {
        this.warehouseTransferInUpdateMode = warehouseTransferInUpdateMode;
    }

    public Date getWarehouseTransferInTransactionDateFirstSession() {
        return warehouseTransferInTransactionDateFirstSession;
    }

    public void setWarehouseTransferInTransactionDateFirstSession(Date warehouseTransferInTransactionDateFirstSession) {
        this.warehouseTransferInTransactionDateFirstSession = warehouseTransferInTransactionDateFirstSession;
    }

    public Date getWarehouseTransferInTransactionDateLastSession() {
        return warehouseTransferInTransactionDateLastSession;
    }

    public void setWarehouseTransferInTransactionDateLastSession(Date warehouseTransferInTransactionDateLastSession) {
        this.warehouseTransferInTransactionDateLastSession = warehouseTransferInTransactionDateLastSession;
    }

    public Date getWarehouseTransferInTransactionDate() {
        return warehouseTransferInTransactionDate;
    }

    public void setWarehouseTransferInTransactionDate(Date warehouseTransferInTransactionDate) {
        this.warehouseTransferInTransactionDate = warehouseTransferInTransactionDate;
    }

    
}
