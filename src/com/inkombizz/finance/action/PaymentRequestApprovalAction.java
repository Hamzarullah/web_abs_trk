
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.finance.bll.PaymentRequestBLL;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.math.BigDecimal;
import java.util.Date;
 
@Results({
    @Result(name="success", location="finance/payment-request-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PaymentRequestApprovalAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    Date paymentRequestApprovalSearchFirstDate;
    Date paymentRequestApprovalSearchLastDate;
    private BigDecimal paymentRequestApprovalSearchFirstTotalAmount=new BigDecimal("0");
    private BigDecimal paymentRequestApprovalSearchLastTotalAmount=new BigDecimal("1000000000");
    @Override
    public String execute() {
        try {
         
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE_PAYMENT_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }            
            
            paymentRequestApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            paymentRequestApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            paymentRequestApprovalSearchFirstTotalAmount=new BigDecimal("0");
            paymentRequestApprovalSearchLastTotalAmount=new BigDecimal("1000000000");
            
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Date getPaymentRequestApprovalSearchFirstDate() {
        return paymentRequestApprovalSearchFirstDate;
    }

    public void setPaymentRequestApprovalSearchFirstDate(Date paymentRequestApprovalSearchFirstDate) {
        this.paymentRequestApprovalSearchFirstDate = paymentRequestApprovalSearchFirstDate;
    }

    public Date getPaymentRequestApprovalSearchLastDate() {
        return paymentRequestApprovalSearchLastDate;
    }

    public void setPaymentRequestApprovalSearchLastDate(Date paymentRequestApprovalSearchLastDate) {
        this.paymentRequestApprovalSearchLastDate = paymentRequestApprovalSearchLastDate;
    }

    public BigDecimal getPaymentRequestApprovalSearchFirstTotalAmount() {
        return paymentRequestApprovalSearchFirstTotalAmount;
    }

    public void setPaymentRequestApprovalSearchFirstTotalAmount(BigDecimal paymentRequestApprovalSearchFirstTotalAmount) {
        this.paymentRequestApprovalSearchFirstTotalAmount = paymentRequestApprovalSearchFirstTotalAmount;
    }

    public BigDecimal getPaymentRequestApprovalSearchLastTotalAmount() {
        return paymentRequestApprovalSearchLastTotalAmount;
    }

    public void setPaymentRequestApprovalSearchLastTotalAmount(BigDecimal paymentRequestApprovalSearchLastTotalAmount) {
        this.paymentRequestApprovalSearchLastTotalAmount = paymentRequestApprovalSearchLastTotalAmount;
    }

    
}
