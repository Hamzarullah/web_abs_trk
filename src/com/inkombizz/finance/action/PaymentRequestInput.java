
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.bll.PaymentRequestBLL;
import com.inkombizz.finance.model.PaymentRequest;
import com.inkombizz.finance.model.PaymentRequestTemp;
//import com.inkombizz.master.model.BudgetType;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Results({
    @Result(name="success", location="finance/payment-request-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PaymentRequestInput extends ActionSupport{
        
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private PaymentRequest paymentRequest;
    private PaymentRequestTemp paymentRequestTemp;
    private Currency currency=null;
//    private BudgetType budgetType=null;
    private boolean paymentRequestUpdateMode = false;
    private Date paymentRequestTransactionDateFirstSession;
    private Date paymentRequestTransactionDateLastSession;
    private String paymentRequestDetailBudgetTypePurchaseDownPaymentCode="";
    private String paymentRequestDetailBudgetTypePurchaseDownPaymentName="";
    private Date paymentRequestTransactionDate;
    private Date paymentRequestScheduleDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                

            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            paymentRequestTransactionDateFirstSession=firstDate;
            paymentRequestTransactionDateLastSession=lastDate;
            
//            budgetType = (BudgetType) hbmSession.hSession.get(BudgetType.class,BaseSession.loadProgramSession().getSetup().getBudgetTypePurchaseDownPaymentCode());
//            paymentRequestDetailBudgetTypePurchaseDownPaymentCode=budgetType.getCode();
//            paymentRequestDetailBudgetTypePurchaseDownPaymentName=budgetType.getName();
            
            if(paymentRequestUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                paymentRequest = (PaymentRequest) hbmSession.hSession.get(PaymentRequest.class, paymentRequest.getCode());
                paymentRequestTransactionDate=paymentRequest.getTransactionDate();
                paymentRequestScheduleDate=paymentRequest.getScheduleDate();
                
            }
            else {
                
                if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                paymentRequest = new PaymentRequest();
                paymentRequest.setCode("AUTO");                
//                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
//                paymentRequest.setCurrency(currency);
                paymentRequest.setTransactionDate(new Date());
                paymentRequest.setTransactionType("REGULAR");
                paymentRequestTransactionDate=new Date();
                
                paymentRequest.setScheduleDate(new Date());
                paymentRequestScheduleDate=new Date();
                 User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                paymentRequest.setBranch(user.getBranch());
                
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

    public PaymentRequest getPaymentRequest() {
        return paymentRequest;
    }

    public void setPaymentRequest(PaymentRequest paymentRequest) {
        this.paymentRequest = paymentRequest;
    }

    public PaymentRequestTemp getPaymentRequestTemp() {
        return paymentRequestTemp;
    }

    public void setPaymentRequestTemp(PaymentRequestTemp paymentRequestTemp) {
        this.paymentRequestTemp = paymentRequestTemp;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

//    public BudgetType getBudgetType() {
//        return budgetType;
//    }
//
//    public void setBudgetType(BudgetType budgetType) {
//        this.budgetType = budgetType;
//    }

    public boolean isPaymentRequestUpdateMode() {
        return paymentRequestUpdateMode;
    }

    public void setPaymentRequestUpdateMode(boolean paymentRequestUpdateMode) {
        this.paymentRequestUpdateMode = paymentRequestUpdateMode;
    }

    public Date getPaymentRequestTransactionDateFirstSession() {
        return paymentRequestTransactionDateFirstSession;
    }

    public void setPaymentRequestTransactionDateFirstSession(Date paymentRequestTransactionDateFirstSession) {
        this.paymentRequestTransactionDateFirstSession = paymentRequestTransactionDateFirstSession;
    }

    public Date getPaymentRequestTransactionDateLastSession() {
        return paymentRequestTransactionDateLastSession;
    }

    public void setPaymentRequestTransactionDateLastSession(Date paymentRequestTransactionDateLastSession) {
        this.paymentRequestTransactionDateLastSession = paymentRequestTransactionDateLastSession;
    }

    public String getPaymentRequestDetailBudgetTypePurchaseDownPaymentCode() {
        return paymentRequestDetailBudgetTypePurchaseDownPaymentCode;
    }

    public void setPaymentRequestDetailBudgetTypePurchaseDownPaymentCode(String paymentRequestDetailBudgetTypePurchaseDownPaymentCode) {
        this.paymentRequestDetailBudgetTypePurchaseDownPaymentCode = paymentRequestDetailBudgetTypePurchaseDownPaymentCode;
    }

    public String getPaymentRequestDetailBudgetTypePurchaseDownPaymentName() {
        return paymentRequestDetailBudgetTypePurchaseDownPaymentName;
    }

    public void setPaymentRequestDetailBudgetTypePurchaseDownPaymentName(String paymentRequestDetailBudgetTypePurchaseDownPaymentName) {
        this.paymentRequestDetailBudgetTypePurchaseDownPaymentName = paymentRequestDetailBudgetTypePurchaseDownPaymentName;
    }

    public Date getPaymentRequestTransactionDate() {
        return paymentRequestTransactionDate;
    }

    public void setPaymentRequestTransactionDate(Date paymentRequestTransactionDate) {
        this.paymentRequestTransactionDate = paymentRequestTransactionDate;
    }

    public Date getPaymentRequestScheduleDate() {
        return paymentRequestScheduleDate;
    }

    public void setPaymentRequestScheduleDate(Date paymentRequestScheduleDate) {
        this.paymentRequestScheduleDate = paymentRequestScheduleDate;
    }
    
    
}
