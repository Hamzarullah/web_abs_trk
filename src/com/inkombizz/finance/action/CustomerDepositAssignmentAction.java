/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CustomerDepositAssignmentBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author egie
 */
@Results({
    @Result(name="success", location="finance/customer-deposit-assignment.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDepositAssignmentAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date customerDepositAssignmentSearchFirstDate;
    private Date customerDepositAssignmentSearchLastDate;
    
    @Override
    public String execute() {
        try {
            CustomerDepositAssignmentBLL customerDepositAssignmentBLL = new CustomerDepositAssignmentBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(customerDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            customerDepositAssignmentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            customerDepositAssignmentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getCustomerDepositAssignmentSearchFirstDate() {
        return customerDepositAssignmentSearchFirstDate;
    }

    public void setCustomerDepositAssignmentSearchFirstDate(Date customerDepositAssignmentSearchFirstDate) {
        this.customerDepositAssignmentSearchFirstDate = customerDepositAssignmentSearchFirstDate;
    }

    public Date getCustomerDepositAssignmentSearchLastDate() {
        return customerDepositAssignmentSearchLastDate;
    }

    public void setCustomerDepositAssignmentSearchLastDate(Date customerDepositAssignmentSearchLastDate) {
        this.customerDepositAssignmentSearchLastDate = customerDepositAssignmentSearchLastDate;
    }

}

