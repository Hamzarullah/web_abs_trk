
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.bll.BankReceivedBLL;
import com.inkombizz.finance.model.BankReceived;
import com.inkombizz.finance.model.BankReceivedTemp;
import com.inkombizz.master.model.BankAccount;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;


@Results({
    @Result(name="success", location="finance/bank-received-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BankReceivedInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BankReceived bankReceived;
    private BankReceivedTemp bankReceivedTemp;
    private Currency currency=null;
    private boolean bankReceivedUpdateMode = false;
    private Date bankReceivedTransactionDateFirstSession;
    private Date bankReceivedTransactionDateLastSession;
    private String bankReceivedCurrencyCodeSession;
    private String bankReceivedDetailCOASalesDownPaymentCode="";
    private String bankReceivedDetailCOASalesDownPaymentName="";
    private Module module=null;
    private Date bankReceivedTransactionDate;
    private ChartOfAccount chartOfAccount=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            UserBLL userBLL = new UserBLL(hbmSession);
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            bankReceivedTransactionDateFirstSession=firstDate;
            bankReceivedTransactionDateLastSession=lastDate;
            bankReceivedCurrencyCodeSession=BaseSession.loadProgramSession().getSetup().getCurrencyCode();
            
            chartOfAccount = (ChartOfAccount) hbmSession.hSession.get(ChartOfAccount.class,BaseSession.loadProgramSession().getSetup().getCoaSalesDepositCode());
            bankReceivedDetailCOASalesDownPaymentCode=chartOfAccount.getCode();
            bankReceivedDetailCOASalesDownPaymentName=chartOfAccount.getName();
                      
            
            if(bankReceivedUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(bankReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                bankReceived = (BankReceived) hbmSession.hSession.get(BankReceived.class, bankReceived.getCode());
                bankReceivedTransactionDate=bankReceived.getTransactionDate();
            }
            else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(bankReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, bankReceivedBLL.MODULECODE);
                
                bankReceived = new BankReceived();
                bankReceived.setCode("AUTO");
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                bankReceived.setCurrency(currency);
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                bankReceived.setBranch(user.getBranch());
                bankReceived.setTransactionDate(new Date());
                bankReceived.setTransferReceivedDate(new Date());
                bankReceivedTransactionDate=new Date();
                bankReceived.setCreatedDate(new Date());

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

    public BankReceived getBankReceived() {
        return bankReceived;
    }

    public void setBankReceived(BankReceived bankReceived) {
        this.bankReceived = bankReceived;
    }

    public BankReceivedTemp getBankReceivedTemp() {
        return bankReceivedTemp;
    }

    public void setBankReceivedTemp(BankReceivedTemp bankReceivedTemp) {
        this.bankReceivedTemp = bankReceivedTemp;
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

    public boolean isBankReceivedUpdateMode() {
        return bankReceivedUpdateMode;
    }

    public void setBankReceivedUpdateMode(boolean bankReceivedUpdateMode) {
        this.bankReceivedUpdateMode = bankReceivedUpdateMode;
    }

    public Date getBankReceivedTransactionDateFirstSession() {
        return bankReceivedTransactionDateFirstSession;
    }

    public void setBankReceivedTransactionDateFirstSession(Date bankReceivedTransactionDateFirstSession) {
        this.bankReceivedTransactionDateFirstSession = bankReceivedTransactionDateFirstSession;
    }

    public Date getBankReceivedTransactionDateLastSession() {
        return bankReceivedTransactionDateLastSession;
    }

    public void setBankReceivedTransactionDateLastSession(Date bankReceivedTransactionDateLastSession) {
        this.bankReceivedTransactionDateLastSession = bankReceivedTransactionDateLastSession;
    }

    public String getBankReceivedCurrencyCodeSession() {
        return bankReceivedCurrencyCodeSession;
    }

    public void setBankReceivedCurrencyCodeSession(String bankReceivedCurrencyCodeSession) {
        this.bankReceivedCurrencyCodeSession = bankReceivedCurrencyCodeSession;
    }

    public String getBankReceivedDetailCOASalesDownPaymentCode() {
        return bankReceivedDetailCOASalesDownPaymentCode;
    }

    public void setBankReceivedDetailCOASalesDownPaymentCode(String bankReceivedDetailCOASalesDownPaymentCode) {
        this.bankReceivedDetailCOASalesDownPaymentCode = bankReceivedDetailCOASalesDownPaymentCode;
    }

    public String getBankReceivedDetailCOASalesDownPaymentName() {
        return bankReceivedDetailCOASalesDownPaymentName;
    }

    public void setBankReceivedDetailCOASalesDownPaymentName(String bankReceivedDetailCOASalesDownPaymentName) {
        this.bankReceivedDetailCOASalesDownPaymentName = bankReceivedDetailCOASalesDownPaymentName;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getBankReceivedTransactionDate() {
        return bankReceivedTransactionDate;
    }

    public void setBankReceivedTransactionDate(Date bankReceivedTransactionDate) {
        this.bankReceivedTransactionDate = bankReceivedTransactionDate;
    }

    
}
