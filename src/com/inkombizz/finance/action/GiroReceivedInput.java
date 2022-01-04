
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.GiroReceivedBLL;
import com.inkombizz.finance.model.GiroReceived;
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
    @Result(name="success", location="finance/giro-received-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GiroReceivedInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GiroReceived giroReceived;
    private boolean giroReceivedUpdateMode = false;
    private Date giroReceivedTransactionDateFirstSession;
    private Date giroReceivedTransactionDateLastSession;
    private Currency currency=null;
    private Module module=null;    
    private Date giroReceivedTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            GiroReceivedBLL giroReceivedBLL = new GiroReceivedBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            giroReceivedTransactionDateFirstSession=firstDate;
            giroReceivedTransactionDateLastSession=lastDate;
            
            if(giroReceivedUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                giroReceived = (GiroReceived) hbmSession.hSession.get(GiroReceived.class, giroReceived.getCode());
                giroReceivedTransactionDate=giroReceived.getTransactionDate();
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(giroReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, giroReceivedBLL.MODULECODE);
                
                giroReceived = new GiroReceived();
                giroReceived.setCode("AUTO");
                giroReceived.setGiroStatus("Pending");
                
                giroReceived.setTransactionDate(new Date());
                giroReceived.setDueDate(new Date());
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                giroReceived.setCurrency(currency);
                giroReceived.setAmount(new BigDecimal("0.00"));
                giroReceivedTransactionDate=new Date();
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                giroReceived.setBranch(user.getBranch());
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

    public GiroReceived getGiroReceived() {
        return giroReceived;
    }

    public void setGiroReceived(GiroReceived giroReceived) {
        this.giroReceived = giroReceived;
    }

    public boolean isGiroReceivedUpdateMode() {
        return giroReceivedUpdateMode;
    }

    public void setGiroReceivedUpdateMode(boolean giroReceivedUpdateMode) {
        this.giroReceivedUpdateMode = giroReceivedUpdateMode;
    }

    public Date getGiroReceivedTransactionDateFirstSession() {
        return giroReceivedTransactionDateFirstSession;
    }

    public void setGiroReceivedTransactionDateFirstSession(Date giroReceivedTransactionDateFirstSession) {
        this.giroReceivedTransactionDateFirstSession = giroReceivedTransactionDateFirstSession;
    }

    public Date getGiroReceivedTransactionDateLastSession() {
        return giroReceivedTransactionDateLastSession;
    }

    public void setGiroReceivedTransactionDateLastSession(Date giroReceivedTransactionDateLastSession) {
        this.giroReceivedTransactionDateLastSession = giroReceivedTransactionDateLastSession;
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

    public Date getGiroReceivedTransactionDate() {
        return giroReceivedTransactionDate;
    }

    public void setGiroReceivedTransactionDate(Date giroReceivedTransactionDate) {
        this.giroReceivedTransactionDate = giroReceivedTransactionDate;
    }

    
}
