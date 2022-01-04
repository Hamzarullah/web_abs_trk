/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.bll.CustomerDownPaymentBLL;
import com.inkombizz.utils.DateUtils;
import java.util.Date;

@Results({
    @Result(name="success", location="finance/customer-down-payment.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDownPaymentAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date customerDownPaymentSearchFirstDate;
    private Date customerDownPaymentSearchLastDate;
    
    @Override
    public String execute() {
        try {
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(customerDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }            
            customerDownPaymentSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            customerDownPaymentSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
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

    public Date getCustomerDownPaymentSearchFirstDate() {
        return customerDownPaymentSearchFirstDate;
    }

    public void setCustomerDownPaymentSearchFirstDate(Date customerDownPaymentSearchFirstDate) {
        this.customerDownPaymentSearchFirstDate = customerDownPaymentSearchFirstDate;
    }

    public Date getCustomerDownPaymentSearchLastDate() {
        return customerDownPaymentSearchLastDate;
    }

    public void setCustomerDownPaymentSearchLastDate(Date customerDownPaymentSearchLastDate) {
        this.customerDownPaymentSearchLastDate = customerDownPaymentSearchLastDate;
    }
    
    
}
