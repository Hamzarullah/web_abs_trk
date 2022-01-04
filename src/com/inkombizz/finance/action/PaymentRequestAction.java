
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.PaymentRequestBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/payment-request.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PaymentRequestAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date paymentRequestSearchFirstDate;
    private Date paymentRequestSearchLastDate;
    private BigDecimal paymentRequestSearchFirstTotalAmount=new BigDecimal("0");
    private BigDecimal paymentRequestSearchLastTotalAmount=new BigDecimal("1000000000000");
    
    @Override
    public String execute() {
        try {
            PaymentRequestBLL paymentRequestBLL = new PaymentRequestBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(paymentRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            paymentRequestSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            paymentRequestSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            paymentRequestSearchFirstTotalAmount=new BigDecimal("0");
            paymentRequestSearchLastTotalAmount=new BigDecimal("1000000000000");
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

    public Date getPaymentRequestSearchFirstDate() {
        return paymentRequestSearchFirstDate;
    }

    public void setPaymentRequestSearchFirstDate(Date paymentRequestSearchFirstDate) {
        this.paymentRequestSearchFirstDate = paymentRequestSearchFirstDate;
    }

    public Date getPaymentRequestSearchLastDate() {
        return paymentRequestSearchLastDate;
    }

    public void setPaymentRequestSearchLastDate(Date paymentRequestSearchLastDate) {
        this.paymentRequestSearchLastDate = paymentRequestSearchLastDate;
    }

    public BigDecimal getPaymentRequestSearchLastTotalAmount() {
        return paymentRequestSearchLastTotalAmount;
    }

    public void setPaymentRequestSearchLastTotalAmount(BigDecimal paymentRequestSearchLastTotalAmount) {
        this.paymentRequestSearchLastTotalAmount = paymentRequestSearchLastTotalAmount;
    }

    public BigDecimal getPaymentRequestSearchFirstTotalAmount() {
        return paymentRequestSearchFirstTotalAmount;
    }

    public void setPaymentRequestSearchFirstTotalAmount(BigDecimal paymentRequestSearchFirstTotalAmount) {
        this.paymentRequestSearchFirstTotalAmount = paymentRequestSearchFirstTotalAmount;
    }

    
    
}
