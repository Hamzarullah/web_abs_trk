/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.VendorDepositTypeBLL;
import com.inkombizz.master.model.VendorDepositType;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author CHRIST
 */
@Results({
    @Result(name="success", location="master/vendor-deposit-type-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDepositTypeInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorDepositType vendorDepositType;
    private String code="";
    private int vendorDepositTypeCreateStatus;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            VendorDepositTypeBLL vendorDepositTypeBLL = new VendorDepositTypeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                return "redirect";
            }
            
            vendorDepositType = vendorDepositTypeBLL.get(code);
            vendorDepositTypeCreateStatus = vendorDepositTypeBLL.getDetailStatus(code);
            
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

    public VendorDepositType getVendorDepositType() {
        return vendorDepositType;
    }

    public void setVendorDepositType(VendorDepositType vendorDepositType) {
        this.vendorDepositType = vendorDepositType;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getVendorDepositTypeCreateStatus() {
        return vendorDepositTypeCreateStatus;
    }

    public void setVendorDepositTypeCreateStatus(int vendorDepositTypeCreateStatus) {
        this.vendorDepositTypeCreateStatus = vendorDepositTypeCreateStatus;
    }
    
    
    
}
