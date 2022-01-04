/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.BankPaymentBLL;
import com.inkombizz.finance.model.BankPayment;
import com.inkombizz.finance.model.BankPaymentTemp;
import com.inkombizz.master.model.BankAccount;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/bank-payment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BankPaymentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BankPayment bankPayment;
    private BankPaymentTemp bankPaymentTemp;
    private Currency currency=null;
    private BankAccount bankAccount=null;
    private ChartOfAccount chartOfAccount=null;
    private boolean bankPaymentUpdateMode = false;
    private Date bankPaymentTransactionDateFirstSession;
    private Date bankPaymentTransactionDateLastSession;
    private String bankPaymentCurrencyCodeSession;
    private String bankPaymentDetailCOAPurchaseDownPaymentCode="";
    private String bankPaymentDetailCOAPurchaseDownPaymentName="";
    private Module module=null;
    private Date bankPaymentTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            UserBLL userBLL = new UserBLL(hbmSession);
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            bankPaymentTransactionDateFirstSession=firstDate;
            bankPaymentTransactionDateLastSession=lastDate;
            bankPaymentCurrencyCodeSession=BaseSession.loadProgramSession().getSetup().getCurrencyCode();
            
//            chartOfAccount = (ChartOfAccount) hbmSession.hSession.get(ChartOfAccount.class,BaseSession.loadProgramSession().getSetup().getCoaPurchaseDownPaymentCode());
//            bankPaymentDetailCOAPurchaseDownPaymentCode=chartOfAccount.getCode();
//            bankPaymentDetailCOAPurchaseDownPaymentName=chartOfAccount.getName();
            
            if(bankPaymentUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(bankPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                bankPayment = (BankPayment) hbmSession.hSession.get(BankPayment.class, bankPayment.getCode());
                bankPaymentTransactionDate=bankPayment.getTransactionDate();
            }
            else {
                
                if (!BaseSession.loadProgramSession().hasAuthority(bankPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, bankPaymentBLL.MODULECODE);
                
                bankPayment = new BankPayment();
                bankPayment.setCode("AUTO");

                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                bankPayment.setCurrency(currency);
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                bankPayment.setBranch(user.getBranch());
                
//                UserTemp userTemp = new UserTemp();
//                userTemp = userBLL.findData(BaseSession.loadProgramSession().getUserCode());
//                    BankAccount bank = new BankAccount();
//                    bank.setCode(userTemp.getDefaultBankAccountCode());
//                    bank.setName(userTemp.getDefaultBankAccountName());
//                    bank.setBbkVoucherNo(userTemp.getDefaultBankAccountBbkVoucherNo());
//                        ChartOfAccount coa = new ChartOfAccount();
//                        coa.setCode(userTemp.getDefaultBankAccountChartOfAccountCode());
//                        coa.setName(userTemp.getDefaultBankAccountChartOfAccountName());
//                    bank.setChartOfAccount(coa);
//                bankPayment.setBankAccount(bank);
//                Branch branch = new Branch();
//                branch.setCode(userTemp.getBranchCode());
//                branch.setName(userTemp.getBranchName());
//                bankPayment.setBranch(branch);
                bankPayment.setTransactionDate(new Date());
                bankPayment.setTransferPaymentDate(new Date());
                bankPaymentTransactionDate=new Date();
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

    public BankPayment getBankPayment() {
        return bankPayment;
    }

    public void setBankPayment(BankPayment bankPayment) {
        this.bankPayment = bankPayment;
    }

    public BankPaymentTemp getBankPaymentTemp() {
        return bankPaymentTemp;
    }

    public void setBankPaymentTemp(BankPaymentTemp bankPaymentTemp) {
        this.bankPaymentTemp = bankPaymentTemp;
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

    public boolean isBankPaymentUpdateMode() {
        return bankPaymentUpdateMode;
    }

    public void setBankPaymentUpdateMode(boolean bankPaymentUpdateMode) {
        this.bankPaymentUpdateMode = bankPaymentUpdateMode;
    }

    public Date getBankPaymentTransactionDateFirstSession() {
        return bankPaymentTransactionDateFirstSession;
    }

    public void setBankPaymentTransactionDateFirstSession(Date bankPaymentTransactionDateFirstSession) {
        this.bankPaymentTransactionDateFirstSession = bankPaymentTransactionDateFirstSession;
    }

    public Date getBankPaymentTransactionDateLastSession() {
        return bankPaymentTransactionDateLastSession;
    }

    public void setBankPaymentTransactionDateLastSession(Date bankPaymentTransactionDateLastSession) {
        this.bankPaymentTransactionDateLastSession = bankPaymentTransactionDateLastSession;
    }

    public String getBankPaymentCurrencyCodeSession() {
        return bankPaymentCurrencyCodeSession;
    }

    public void setBankPaymentCurrencyCodeSession(String bankPaymentCurrencyCodeSession) {
        this.bankPaymentCurrencyCodeSession = bankPaymentCurrencyCodeSession;
    }

    public String getBankPaymentDetailCOAPurchaseDownPaymentCode() {
        return bankPaymentDetailCOAPurchaseDownPaymentCode;
    }

    public void setBankPaymentDetailCOAPurchaseDownPaymentCode(String bankPaymentDetailCOAPurchaseDownPaymentCode) {
        this.bankPaymentDetailCOAPurchaseDownPaymentCode = bankPaymentDetailCOAPurchaseDownPaymentCode;
    }

    public String getBankPaymentDetailCOAPurchaseDownPaymentName() {
        return bankPaymentDetailCOAPurchaseDownPaymentName;
    }

    public void setBankPaymentDetailCOAPurchaseDownPaymentName(String bankPaymentDetailCOAPurchaseDownPaymentName) {
        this.bankPaymentDetailCOAPurchaseDownPaymentName = bankPaymentDetailCOAPurchaseDownPaymentName;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getBankPaymentTransactionDate() {
        return bankPaymentTransactionDate;
    }

    public void setBankPaymentTransactionDate(Date bankPaymentTransactionDate) {
        this.bankPaymentTransactionDate = bankPaymentTransactionDate;
    }

    public BankAccount getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(BankAccount bankAccount) {
        this.bankAccount = bankAccount;
    }

}
