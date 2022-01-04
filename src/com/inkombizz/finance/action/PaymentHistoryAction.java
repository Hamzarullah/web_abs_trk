/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.PaymentHistoryBLL;
import com.inkombizz.finance.model.PaymentHistoryTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/payment-history.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class PaymentHistoryAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private PaymentHistoryTemp paymentHistorySearchTemp = new PaymentHistoryTemp();
    private Date paymentHistoryFirstDate;
    private Date paymentHistoryLastDate;
    
    @Override
    public String execute() {
        try {
            PaymentHistoryBLL paymentHistoryBLL = new PaymentHistoryBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(paymentHistoryBLL.MODULECODE_PAYMENT, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            paymentHistoryFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            paymentHistoryLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

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

    public PaymentHistoryTemp getPaymentHistorySearchTemp() {
        return paymentHistorySearchTemp;
    }

    public void setPaymentHistorySearchTemp(PaymentHistoryTemp paymentHistorySearchTemp) {
        this.paymentHistorySearchTemp = paymentHistorySearchTemp;
    }

    public Date getPaymentHistoryFirstDate() {
        return paymentHistoryFirstDate;
    }

    public void setPaymentHistoryFirstDate(Date paymentHistoryFirstDate) {
        this.paymentHistoryFirstDate = paymentHistoryFirstDate;
    }

    public Date getPaymentHistoryLastDate() {
        return paymentHistoryLastDate;
    }

    public void setPaymentHistoryLastDate(Date paymentHistoryLastDate) {
        this.paymentHistoryLastDate = paymentHistoryLastDate;
    }

}
