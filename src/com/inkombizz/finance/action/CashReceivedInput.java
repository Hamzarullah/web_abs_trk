
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.inkombizz.finance.bll.CashReceivedBLL;
import com.inkombizz.finance.model.CashReceived;
import com.inkombizz.finance.model.CashReceivedTemp;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;

@Results({
    @Result(name="success", location="finance/cash-received-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CashReceivedInput extends ActionSupport{
    
     
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CashReceived cashReceived;
    private CashReceivedTemp cashReceivedTemp;
    private Currency currency=null;
    private ChartOfAccount chartOfAccount=null;
    private boolean cashReceivedUpdateMode = false;
    private Date cashReceivedTransactionDateFirstSession;
    private Date cashReceivedTransactionDateLastSession;
    private String cashReceivedCurrencyCodeSession="";
    private String cashReceivedDetailCOASalesDownPaymentCode="";
    private String cashReceivedDetailCOASalesDownPaymentName="";
    private Date cashReceivedTransactionDate;
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                

            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            cashReceivedTransactionDateFirstSession = firstDate;
            cashReceivedTransactionDateLastSession = lastDate;
            cashReceivedCurrencyCodeSession = BaseSession.loadProgramSession().getSetup().getCurrencyCode();

            chartOfAccount = (ChartOfAccount) hbmSession.hSession.get(ChartOfAccount.class,BaseSession.loadProgramSession().getSetup().getCoaSalesDepositCode());
            cashReceivedDetailCOASalesDownPaymentCode=chartOfAccount.getCode();
            cashReceivedDetailCOASalesDownPaymentName=chartOfAccount.getName();
            
            if(cashReceivedUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(cashReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                cashReceived = (CashReceived) hbmSession.hSession.get(CashReceived.class, cashReceived.getCode());
                cashReceivedTransactionDate=cashReceived.getTransactionDate();
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(cashReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                //module = (Module) hbmSession.hSession.get(Module.class, cashReceivedBLL.MODULECODE);
                
                cashReceived = new CashReceived();
                cashReceived.setCode("AUTO");
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                cashReceived.setCurrency(currency);
                
                cashReceived.setTransactionDate(new Date());
                cashReceived.setTotalTransactionAmount(new BigDecimal("0.00"));
                cashReceivedTransactionDate=new Date();
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                cashReceived.setBranch(user.getBranch());
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

    public CashReceived getCashReceived() {
        return cashReceived;
    }

    public void setCashReceived(CashReceived cashReceived) {
        this.cashReceived = cashReceived;
    }

    public CashReceivedTemp getCashReceivedTemp() {
        return cashReceivedTemp;
    }

    public void setCashReceivedTemp(CashReceivedTemp cashReceivedTemp) {
        this.cashReceivedTemp = cashReceivedTemp;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public ChartOfAccount getChartOfAccount() {
        return chartOfAccount;
    }

    public void setChartOfAccount(ChartOfAccount chartOfAccount) {
        this.chartOfAccount = chartOfAccount;
    }

    public boolean isCashReceivedUpdateMode() {
        return cashReceivedUpdateMode;
    }

    public void setCashReceivedUpdateMode(boolean cashReceivedUpdateMode) {
        this.cashReceivedUpdateMode = cashReceivedUpdateMode;
    }

    public Date getCashReceivedTransactionDateFirstSession() {
        return cashReceivedTransactionDateFirstSession;
    }

    public void setCashReceivedTransactionDateFirstSession(Date cashReceivedTransactionDateFirstSession) {
        this.cashReceivedTransactionDateFirstSession = cashReceivedTransactionDateFirstSession;
    }

    public Date getCashReceivedTransactionDateLastSession() {
        return cashReceivedTransactionDateLastSession;
    }

    public void setCashReceivedTransactionDateLastSession(Date cashReceivedTransactionDateLastSession) {
        this.cashReceivedTransactionDateLastSession = cashReceivedTransactionDateLastSession;
    }

    public String getCashReceivedCurrencyCodeSession() {
        return cashReceivedCurrencyCodeSession;
    }

    public void setCashReceivedCurrencyCodeSession(String cashReceivedCurrencyCodeSession) {
        this.cashReceivedCurrencyCodeSession = cashReceivedCurrencyCodeSession;
    }

    public String getCashReceivedDetailCOASalesDownPaymentCode() {
        return cashReceivedDetailCOASalesDownPaymentCode;
    }

    public void setCashReceivedDetailCOASalesDownPaymentCode(String cashReceivedDetailCOASalesDownPaymentCode) {
        this.cashReceivedDetailCOASalesDownPaymentCode = cashReceivedDetailCOASalesDownPaymentCode;
    }

    public String getCashReceivedDetailCOASalesDownPaymentName() {
        return cashReceivedDetailCOASalesDownPaymentName;
    }

    public void setCashReceivedDetailCOASalesDownPaymentName(String cashReceivedDetailCOASalesDownPaymentName) {
        this.cashReceivedDetailCOASalesDownPaymentName = cashReceivedDetailCOASalesDownPaymentName;
    }

    public Date getCashReceivedTransactionDate() {
        return cashReceivedTransactionDate;
    }

    public void setCashReceivedTransactionDate(Date cashReceivedTransactionDate) {
        this.cashReceivedTransactionDate = cashReceivedTransactionDate;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }
}
