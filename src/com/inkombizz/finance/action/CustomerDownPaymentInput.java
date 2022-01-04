/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.inkombizz.utils.DateUtils;

//import com.inkombizz.master.model.Company;
import com.inkombizz.finance.bll.CustomerDownPaymentBLL;
import com.inkombizz.finance.model.CustomerDownPayment;
//import com.inkombizz.master.model.Company;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import java.util.Date;


@Results({
    @Result(name="success", location="finance/customer-down-payment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDownPaymentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private CustomerDownPayment customerDownPayment;
    private boolean customerDownPaymentUpdateMode = Boolean.FALSE;
    private Date customerDownPaymentTransactionDateFirstSession;
    private Date customerDownPaymentTransactionDateLastSession;
    private Currency currency=null;
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            customerDownPaymentTransactionDateFirstSession = firstDate;
            customerDownPaymentTransactionDateLastSession = lastDate;
            
            if(customerDownPaymentUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(customerDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                customerDownPayment = (CustomerDownPayment) hbmSession.hSession.get(CustomerDownPayment.class, customerDownPayment.getCode());
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(customerDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, customerDownPaymentBLL.MODULECODE);
                
                customerDownPayment = new CustomerDownPayment();
                           
                customerDownPayment.setCode("AUTO");
                customerDownPayment.setTransactionDate(new Date());
                
  //              Company company=new Company();
        //        company.setCode(module.getCompany().getCode());
        //        company.setName(module.getCompany().getName());
   //             customerDownPayment.setCompany(company);
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                customerDownPayment.setCurrency(currency);
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                customerDownPayment.setBranch(user.getBranch());
                                
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

    public CustomerDownPayment getCustomerDownPayment() {
        return customerDownPayment;
    }

    public void setCustomerDownPayment(CustomerDownPayment customerDownPayment) {
        this.customerDownPayment = customerDownPayment;
    }

    public boolean isCustomerDownPaymentUpdateMode() {
        return customerDownPaymentUpdateMode;
    }

    public void setCustomerDownPaymentUpdateMode(boolean customerDownPaymentUpdateMode) {
        this.customerDownPaymentUpdateMode = customerDownPaymentUpdateMode;
    }

    public Date getCustomerDownPaymentTransactionDateFirstSession() {
        return customerDownPaymentTransactionDateFirstSession;
    }

    public void setCustomerDownPaymentTransactionDateFirstSession(Date customerDownPaymentTransactionDateFirstSession) {
        this.customerDownPaymentTransactionDateFirstSession = customerDownPaymentTransactionDateFirstSession;
    }

    public Date getCustomerDownPaymentTransactionDateLastSession() {
        return customerDownPaymentTransactionDateLastSession;
    }

    public void setCustomerDownPaymentTransactionDateLastSession(Date customerDownPaymentTransactionDateLastSession) {
        this.customerDownPaymentTransactionDateLastSession = customerDownPaymentTransactionDateLastSession;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    
}
