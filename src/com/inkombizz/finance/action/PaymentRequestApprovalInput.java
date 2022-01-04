
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.PaymentRequestBLL;
import com.inkombizz.finance.model.PaymentRequest;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
 
@Results({
    @Result(name="success", location="finance/payment-request-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PaymentRequestApprovalInput extends ActionSupport{
        
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private BigDecimal paymentRequestApprovalTotalDebitForeign;
    private BigDecimal paymentRequestApprovalTotalCreditForeign;
    private BigDecimal paymentRequestApprovalTotalBalanceForeign;
    private PaymentRequest paymentRequestApproval;

    @Override
    public String execute() throws Exception {
          try {  
              
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE_PAYMENT_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }  
            
            paymentRequestApproval = (PaymentRequest) hbmSession.hSession.get(PaymentRequest.class, paymentRequestApproval.getCode());
            paymentRequestApprovalTotalDebitForeign=paymentRequestApproval.getTotalTransactionAmount();
            paymentRequestApprovalTotalCreditForeign=paymentRequestApproval.getTotalTransactionAmount();
            paymentRequestApprovalTotalBalanceForeign = new BigDecimal("0.0000");
            
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

    public PaymentRequest getPaymentRequestApproval() {
        return paymentRequestApproval;
    }

    public void setPaymentRequestApproval(PaymentRequest paymentRequestApproval) {
        this.paymentRequestApproval = paymentRequestApproval;
    }

    public BigDecimal getPaymentRequestApprovalTotalDebitForeign() {
        return paymentRequestApprovalTotalDebitForeign;
    }

    public void setPaymentRequestApprovalTotalDebitForeign(BigDecimal paymentRequestApprovalTotalDebitForeign) {
        this.paymentRequestApprovalTotalDebitForeign = paymentRequestApprovalTotalDebitForeign;
    }

    public BigDecimal getPaymentRequestApprovalTotalCreditForeign() {
        return paymentRequestApprovalTotalCreditForeign;
    }

    public void setPaymentRequestApprovalTotalCreditForeign(BigDecimal paymentRequestApprovalTotalCreditForeign) {
        this.paymentRequestApprovalTotalCreditForeign = paymentRequestApprovalTotalCreditForeign;
    }

    public BigDecimal getPaymentRequestApprovalTotalBalanceForeign() {
        return paymentRequestApprovalTotalBalanceForeign;
    }

    public void setPaymentRequestApprovalTotalBalanceForeign(BigDecimal paymentRequestApprovalTotalBalanceForeign) {
        this.paymentRequestApprovalTotalBalanceForeign = paymentRequestApprovalTotalBalanceForeign;
    }
       
}
    