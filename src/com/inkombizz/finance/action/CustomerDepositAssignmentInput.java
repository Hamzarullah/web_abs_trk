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
//import com.inkombizz.finance.model.BankReceivedDeposit;
//import com.inkombizz.finance.model.CashReceivedDeposit;
import com.inkombizz.finance.model.CustomerDepositAssignmentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author egie
 */
@Results({
    @Result(name="success", location="finance/customer-deposit-assignment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDepositAssignmentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerDepositAssignmentTemp customerDepositAssignment;
    private String depositNo = "";
    private Date customerDepositAssignmentFirstDate;
    private Date customerDepositAssignmentLastDate;
    private String customerDepositAssignmentTransactionDateDaysName = "";
    private String customerDepositAssignmentAssignmentDateDaysName = "";
    private String remark = "";
    
    @Override
    public String execute() {
        try {
            CustomerDepositAssignmentBLL customerDepositAssignmentBLL = new CustomerDepositAssignmentBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(customerDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
            this.customerDepositAssignmentFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());

            this.customerDepositAssignmentLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
            customerDepositAssignment = customerDepositAssignmentBLL.get(customerDepositAssignment.getDepositNo());
            customerDepositAssignmentTransactionDateDaysName = customerDepositAssignment.getTransactionDateDaysName();
            customerDepositAssignmentAssignmentDateDaysName = customerDepositAssignment.getAssignmentDateDaysName();
           
            return SUCCESS;
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerDepositAssignmentTemp getCustomerDepositAssignment() {
        return customerDepositAssignment;
    }

    public void setCustomerDepositAssignment(CustomerDepositAssignmentTemp customerDepositAssignment) {
        this.customerDepositAssignment = customerDepositAssignment;
    }

    public String getDepositNo() {
        return depositNo;
    }

    public void setDepositNo(String depositNo) {
        this.depositNo = depositNo;
    }
 
    public Date getCustomerDepositAssignmentFirstDate() {
        return customerDepositAssignmentFirstDate;
    }

    public void setCustomerDepositAssignmentFirstDate(Date customerDepositAssignmentFirstDate) {
        this.customerDepositAssignmentFirstDate = customerDepositAssignmentFirstDate;
    }

    public Date getCustomerDepositAssignmentLastDate() {
        return customerDepositAssignmentLastDate;
    }

    public void setCustomerDepositAssignmentLastDate(Date customerDepositAssignmentLastDate) {
        this.customerDepositAssignmentLastDate = customerDepositAssignmentLastDate;
    }

    public String getCustomerDepositAssignmentTransactionDateDaysName() {
        return customerDepositAssignmentTransactionDateDaysName;
    }

    public void setCustomerDepositAssignmentTransactionDateDaysName(String customerDepositAssignmentTransactionDateDaysName) {
        this.customerDepositAssignmentTransactionDateDaysName = customerDepositAssignmentTransactionDateDaysName;
    }

    public String getCustomerDepositAssignmentAssignmentDateDaysName() {
        return customerDepositAssignmentAssignmentDateDaysName;
    }

    public void setCustomerDepositAssignmentAssignmentDateDaysName(String customerDepositAssignmentAssignmentDateDaysName) {
        this.customerDepositAssignmentAssignmentDateDaysName = customerDepositAssignmentAssignmentDateDaysName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    

}
