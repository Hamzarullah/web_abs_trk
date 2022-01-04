/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.inkombizz.utils.DateUtils;

//import com.inkombizz.master.model.Company;
import com.inkombizz.finance.bll.VendorDownPaymentBLL;
import com.inkombizz.finance.model.VendorDownPayment;
//import com.inkombizz.master.model.Company;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import java.util.Date;


@Results({
    @Result(name="success", location="finance/vendor-down-payment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDownPaymentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private VendorDownPayment vendorDownPayment;
    private boolean vendorDownPaymentUpdateMode = Boolean.FALSE;
    private Date vendorDownPaymentTransactionDateFirstSession;
    private Date vendorDownPaymentTransactionDateLastSession;
    private Currency currency=null;
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            VendorDownPaymentBLL vendorDownPaymentBLL = new VendorDownPaymentBLL(hbmSession);
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            vendorDownPaymentTransactionDateFirstSession = firstDate;
            vendorDownPaymentTransactionDateLastSession = lastDate;
            
            if(vendorDownPaymentUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(vendorDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                vendorDownPayment = (VendorDownPayment) hbmSession.hSession.get(VendorDownPayment.class, vendorDownPayment.getCode());
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(vendorDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, vendorDownPaymentBLL.MODULECODE);
                
                vendorDownPayment = new VendorDownPayment();
                           
                vendorDownPayment.setCode("AUTO");
                vendorDownPayment.setTransactionDate(new Date());
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                vendorDownPayment.setBranch(user.getBranch());
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                vendorDownPayment.setCurrency(currency);
                                
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

    public VendorDownPayment getVendorDownPayment() {
        return vendorDownPayment;
    }

    public void setVendorDownPayment(VendorDownPayment vendorDownPayment) {
        this.vendorDownPayment = vendorDownPayment;
    }

    public boolean isVendorDownPaymentUpdateMode() {
        return vendorDownPaymentUpdateMode;
    }

    public void setVendorDownPaymentUpdateMode(boolean vendorDownPaymentUpdateMode) {
        this.vendorDownPaymentUpdateMode = vendorDownPaymentUpdateMode;
    }

    public Date getVendorDownPaymentTransactionDateFirstSession() {
        return vendorDownPaymentTransactionDateFirstSession;
    }

    public void setVendorDownPaymentTransactionDateFirstSession(Date vendorDownPaymentTransactionDateFirstSession) {
        this.vendorDownPaymentTransactionDateFirstSession = vendorDownPaymentTransactionDateFirstSession;
    }

    public Date getVendorDownPaymentTransactionDateLastSession() {
        return vendorDownPaymentTransactionDateLastSession;
    }

    public void setVendorDownPaymentTransactionDateLastSession(Date vendorDownPaymentTransactionDateLastSession) {
        this.vendorDownPaymentTransactionDateLastSession = vendorDownPaymentTransactionDateLastSession;
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
