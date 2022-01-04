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
import com.inkombizz.inventory.model.WarehouseTransferOut;
import com.inkombizz.master.model.Rack;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
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
    @Result(name="success", location="inventory/warehouse-transfer-out-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class WarehouseTransferOutInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private WarehouseTransferOut warehouseTransferOut;
    private Rack rack;
    private boolean warehouseTransferOutUpdateMode = false;
    private Date warehouseTransferOutTransactionDateFirstSession;
    private Date warehouseTransferOutTransactionDateLastSession;
    
    private Date warehouseTransferOutTransactionDate;
    private String defaultRackCode = "";
    private String defaultRackName = "";
    
     private Module module=null;
    
    @Override
    public String execute(){
  
        try {                
            WarehouseTransferOutBLL warehouseTransferOutBLL = new WarehouseTransferOutBLL(hbmSession);  
                        
            warehouseTransferOutTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            warehouseTransferOutTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                                   
            if(warehouseTransferOutUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                warehouseTransferOut = (WarehouseTransferOut) hbmSession.hSession.get(WarehouseTransferOut.class, warehouseTransferOut.getCode());
                warehouseTransferOutTransactionDate = warehouseTransferOut.getTransactionDate();
                //rack = (Rack)hbmSession.hSession.get(Rack.class,warehouseTransferOut.getDestinationWarehouse().getDefaultRackCode());
                
                if(rack!=null){
                    this.defaultRackCode = rack.getCode();
                    this.defaultRackName = rack.getName();
                }
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(warehouseTransferOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                module = (Module) hbmSession.hSession.get(Module.class, warehouseTransferOutBLL.MODULECODE);
                
             
                warehouseTransferOut = new WarehouseTransferOut();
                warehouseTransferOut.setCode("AUTO");
                warehouseTransferOut.setTransactionDate(new Date());
                warehouseTransferOutTransactionDate=new Date();
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                warehouseTransferOut.setBranch(user.getBranch());
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

    public WarehouseTransferOut getWarehouseTransferOut() {
        return warehouseTransferOut;
    }

    public void setWarehouseTransferOut(WarehouseTransferOut warehouseTransferOut) {
        this.warehouseTransferOut = warehouseTransferOut;
    }

    public boolean isWarehouseTransferOutUpdateMode() {
        return warehouseTransferOutUpdateMode;
    }

    public void setWarehouseTransferOutUpdateMode(boolean warehouseTransferOutUpdateMode) {
        this.warehouseTransferOutUpdateMode = warehouseTransferOutUpdateMode;
    }

    public Date getWarehouseTransferOutTransactionDateFirstSession() {
        return warehouseTransferOutTransactionDateFirstSession;
    }

    public void setWarehouseTransferOutTransactionDateFirstSession(Date warehouseTransferOutTransactionDateFirstSession) {
        this.warehouseTransferOutTransactionDateFirstSession = warehouseTransferOutTransactionDateFirstSession;
    }

    public Date getWarehouseTransferOutTransactionDateLastSession() {
        return warehouseTransferOutTransactionDateLastSession;
    }

    public void setWarehouseTransferOutTransactionDateLastSession(Date warehouseTransferOutTransactionDateLastSession) {
        this.warehouseTransferOutTransactionDateLastSession = warehouseTransferOutTransactionDateLastSession;
    }

    public Date getWarehouseTransferOutTransactionDate() {
        return warehouseTransferOutTransactionDate;
    }

    public void setWarehouseTransferOutTransactionDate(Date warehouseTransferOutTransactionDate) {
        this.warehouseTransferOutTransactionDate = warehouseTransferOutTransactionDate;
    }

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public String getDefaultRackCode() {
        return defaultRackCode;
    }

    public void setDefaultRackCode(String defaultRackCode) {
        this.defaultRackCode = defaultRackCode;
    }

    public String getDefaultRackName() {
        return defaultRackName;
    }

    public void setDefaultRackName(String defaultRackName) {
        this.defaultRackName = defaultRackName;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }
    
}
