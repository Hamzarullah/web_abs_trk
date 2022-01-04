/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CashPaymentBLL;
import com.inkombizz.finance.model.CashPayment;
import com.inkombizz.finance.model.CashPaymentTemp;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.CashAccount;
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
    @Result(name="success", location="finance/cash-payment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CashPaymentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CashPayment cashPayment;
    private CashPaymentTemp cashPaymentTemp;
    private Currency currency=null;
    private ChartOfAccount chartOfAccount=null;
    private boolean cashPaymentUpdateMode = false;
    private Date cashPaymentTransactionDateFirstSession;
    private Date cashPaymentTransactionDateLastSession;
    private String cashPaymentCurrencyCodeSession;
    private String cashPaymentDetailCOAPurchaseDownPaymentCode="";
    private String cashPaymentDetailCOAPurchaseDownPaymentName="";
    private Module module=null;
    private Date cashPaymentTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                

            CashPaymentBLL cashPaymentBLL = new CashPaymentBLL(hbmSession);
             UserBLL userBLL = new UserBLL(hbmSession);
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            cashPaymentTransactionDateFirstSession=firstDate;
            cashPaymentTransactionDateLastSession=lastDate;
            cashPaymentCurrencyCodeSession=BaseSession.loadProgramSession().getSetup().getCurrencyCode();
            
//            chartOfAccount = (ChartOfAccount) hbmSession.hSession.get(ChartOfAccount.class,BaseSession.loadProgramSession().getSetup().getCoaPurchaseDownPaymentCode());
//            cashPaymentDetailCOAPurchaseDownPaymentCode=chartOfAccount.getCode();
//            cashPaymentDetailCOAPurchaseDownPaymentName=chartOfAccount.getName();
            
            if(cashPaymentUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(cashPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                cashPayment = (CashPayment) hbmSession.hSession.get(CashPayment.class, cashPayment.getCode());
                cashPaymentTransactionDate=cashPayment.getTransactionDate();
            }
            else {
                
                if (!BaseSession.loadProgramSession().hasAuthority(cashPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                cashPayment = new CashPayment();
                cashPayment.setCode("AUTO");
                 UserTemp userTemp = new UserTemp();
//                userTemp = userBLL.findData(BaseSession.loadProgramSession().getUserCode());
//                    CashAccount cash = new CashAccount();
//                    cash.setCode(userTemp.getDefaultCashAccountCode());
//                    cash.setName(userTemp.getDefaultCashAccountName());
//                    cash.setBkkVoucherNo(userTemp.getDefaultCashAccountBkkVoucherNo());
//                        ChartOfAccount coa = new ChartOfAccount();
//                        coa.setCode(userTemp.getDefaultCashAccountChartOfAccountCode());
//                        coa.setName(userTemp.getDefaultCashAccountChartOfAccountName());
//                    cash.setChartOfAccount(coa);
//                cashPayment.setCashAccount(cash);
//                    Branch branch = new Branch();
//                    branch.setCode(userTemp.getDefaultBranchCode());
//                    branch.setName(userTemp.getDefaultBranchName());
//                cashPayment.setBranch(branch);               
               
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                cashPayment.setBranch(user.getBranch());
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                cashPayment.setCurrency(currency);
                cashPayment.setTransactionDate(new Date());
                cashPaymentTransactionDate=new Date();
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

    public CashPayment getCashPayment() {
        return cashPayment;
    }

    public void setCashPayment(CashPayment cashPayment) {
        this.cashPayment = cashPayment;
    }

    public CashPaymentTemp getCashPaymentTemp() {
        return cashPaymentTemp;
    }

    public void setCashPaymentTemp(CashPaymentTemp cashPaymentTemp) {
        this.cashPaymentTemp = cashPaymentTemp;
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

    public boolean isCashPaymentUpdateMode() {
        return cashPaymentUpdateMode;
    }

    public void setCashPaymentUpdateMode(boolean cashPaymentUpdateMode) {
        this.cashPaymentUpdateMode = cashPaymentUpdateMode;
    }

    public Date getCashPaymentTransactionDateFirstSession() {
        return cashPaymentTransactionDateFirstSession;
    }

    public void setCashPaymentTransactionDateFirstSession(Date cashPaymentTransactionDateFirstSession) {
        this.cashPaymentTransactionDateFirstSession = cashPaymentTransactionDateFirstSession;
    }

    public Date getCashPaymentTransactionDateLastSession() {
        return cashPaymentTransactionDateLastSession;
    }

    public void setCashPaymentTransactionDateLastSession(Date cashPaymentTransactionDateLastSession) {
        this.cashPaymentTransactionDateLastSession = cashPaymentTransactionDateLastSession;
    }

    public String getCashPaymentCurrencyCodeSession() {
        return cashPaymentCurrencyCodeSession;
    }

    public void setCashPaymentCurrencyCodeSession(String cashPaymentCurrencyCodeSession) {
        this.cashPaymentCurrencyCodeSession = cashPaymentCurrencyCodeSession;
    }

    public String getCashPaymentDetailCOAPurchaseDownPaymentCode() {
        return cashPaymentDetailCOAPurchaseDownPaymentCode;
    }

    public void setCashPaymentDetailCOAPurchaseDownPaymentCode(String cashPaymentDetailCOAPurchaseDownPaymentCode) {
        this.cashPaymentDetailCOAPurchaseDownPaymentCode = cashPaymentDetailCOAPurchaseDownPaymentCode;
    }

    public String getCashPaymentDetailCOAPurchaseDownPaymentName() {
        return cashPaymentDetailCOAPurchaseDownPaymentName;
    }

    public void setCashPaymentDetailCOAPurchaseDownPaymentName(String cashPaymentDetailCOAPurchaseDownPaymentName) {
        this.cashPaymentDetailCOAPurchaseDownPaymentName = cashPaymentDetailCOAPurchaseDownPaymentName;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getCashPaymentTransactionDate() {
        return cashPaymentTransactionDate;
    }

    public void setCashPaymentTransactionDate(Date cashPaymentTransactionDate) {
        this.cashPaymentTransactionDate = cashPaymentTransactionDate;
    }

}
