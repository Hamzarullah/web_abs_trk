
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroPaymentBLL;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.master.bll.CurrencyBLL;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/giro-payment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroPaymentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroPayment giroPayment;
    private boolean giroPaymentUpdateMode = false;
    private Date giroPaymentTransactionDateFirstSession;
    private Date giroPaymentTransactionDateLastSession;
    private Currency currency=null;
    private Module module=null;    
    private Date giroPaymentTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            GiroPaymentBLL giroPaymentBLL = new GiroPaymentBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            giroPaymentTransactionDateFirstSession=firstDate;
            giroPaymentTransactionDateLastSession=lastDate;
            
            if(giroPaymentUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                giroPayment = (GiroPayment) hbmSession.hSession.get(GiroPayment.class, giroPayment.getCode());
                giroPaymentTransactionDate=giroPayment.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(giroPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, giroPaymentBLL.MODULECODE);
                
                giroPayment = new GiroPayment();
                giroPayment.setCode("AUTO");
                giroPayment.setGiroStatus("Pending");
//                Branch branch=new Branch();
//                branch.setCode(module.getBranch().getCode());
//                branch.setName(module.getBranch().getName());
//                giroPayment.setBranch(branch);
                               
                giroPayment.setTransactionDate(new Date());
                giroPayment.setDueDate(new Date());
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                giroPayment.setCurrency(currency);
                giroPayment.setAmount(new BigDecimal("0.00"));
                giroPaymentTransactionDate=new Date();
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                giroPayment.setBranch(user.getBranch());
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

    public GiroPayment getGiroPayment() {
        return giroPayment;
    }

    public void setGiroPayment(GiroPayment giroPayment) {
        this.giroPayment = giroPayment;
    }

    public boolean isGiroPaymentUpdateMode() {
        return giroPaymentUpdateMode;
    }

    public void setGiroPaymentUpdateMode(boolean giroPaymentUpdateMode) {
        this.giroPaymentUpdateMode = giroPaymentUpdateMode;
    }

    public Date getGiroPaymentTransactionDateFirstSession() {
        return giroPaymentTransactionDateFirstSession;
    }

    public void setGiroPaymentTransactionDateFirstSession(Date giroPaymentTransactionDateFirstSession) {
        this.giroPaymentTransactionDateFirstSession = giroPaymentTransactionDateFirstSession;
    }

    public Date getGiroPaymentTransactionDateLastSession() {
        return giroPaymentTransactionDateLastSession;
    }

    public void setGiroPaymentTransactionDateLastSession(Date giroPaymentTransactionDateLastSession) {
        this.giroPaymentTransactionDateLastSession = giroPaymentTransactionDateLastSession;
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

    public Date getGiroPaymentTransactionDate() {
        return giroPaymentTransactionDate;
    }

    public void setGiroPaymentTransactionDate(Date giroPaymentTransactionDate) {
        this.giroPaymentTransactionDate = giroPaymentTransactionDate;
    }

    
       
}
