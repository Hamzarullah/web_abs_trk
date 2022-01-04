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
import com.inkombizz.finance.model.BankPaymentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/bank-payment.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BankPaymentAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private BankPaymentTemp bankPaymentSearchTemp = new BankPaymentTemp();
    
    @Override
    public String execute() {
        try {
            BankPaymentBLL bankPaymentBLL = new BankPaymentBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(bankPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            bankPaymentSearchTemp.setFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            bankPaymentSearchTemp.setLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));

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

    public BankPaymentTemp getBankPaymentSearchTemp() {
        return bankPaymentSearchTemp;
    }

    public void setBankPaymentSearchTemp(BankPaymentTemp bankPaymentSearchTemp) {
        this.bankPaymentSearchTemp = bankPaymentSearchTemp;
    }
    
}
