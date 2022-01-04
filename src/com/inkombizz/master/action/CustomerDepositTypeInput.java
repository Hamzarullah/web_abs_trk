/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.CustomerDepositTypeBLL;
import com.inkombizz.master.model.CustomerDepositType;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author CHRIST
 */
@Results({
    @Result(name="success", location="master/customer-deposit-type-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDepositTypeInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerDepositType customerDepositType;
    private String code="";
    private int customerDepositTypeCreateStatus;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(customerDepositTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                return "redirect";
            }
            
            customerDepositType = customerDepositTypeBLL.get(code);
            customerDepositTypeCreateStatus = customerDepositTypeBLL.getDetailStatus(code);
            
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

    public CustomerDepositType getCustomerDepositType() {
        return customerDepositType;
    }

    public void setCustomerDepositType(CustomerDepositType customerDepositType) {
        this.customerDepositType = customerDepositType;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getCustomerDepositTypeCreateStatus() {
        return customerDepositTypeCreateStatus;
    }

    public void setCustomerDepositTypeCreateStatus(int customerDepositTypeCreateStatus) {
        this.customerDepositTypeCreateStatus = customerDepositTypeCreateStatus;
    }
    
    
    
}
