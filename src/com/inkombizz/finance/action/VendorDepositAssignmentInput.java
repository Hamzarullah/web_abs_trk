/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorDepositAssignmentBLL;
//import com.inkombizz.finance.model.BankPaymentDeposit;
//import com.inkombizz.finance.model.CashPaymentDeposit;
import com.inkombizz.finance.model.VendorDepositAssignmentTemp;
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
    @Result(name="success", location="finance/vendor-deposit-assignment-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDepositAssignmentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private VendorDepositAssignmentTemp vendorDepositAssignment;
    private String depositNo = "";
    private Date vendorDepositAssignmentFirstDate;
    private Date vendorDepositAssignmentLastDate;
    private String vendorDepositAssignmentTransactionDateDaysName = "";
    private String vendorDepositAssignmentAssignmentDateDaysName = "";
    private String remark = "";
    
    @Override
    public String execute() {
        try {
            VendorDepositAssignmentBLL vendorDepositAssignmentBLL = new VendorDepositAssignmentBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
            this.vendorDepositAssignmentFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());

            this.vendorDepositAssignmentLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 
                    BaseSession.loadProgramSession().getPeriodMonth());
            
            vendorDepositAssignment = vendorDepositAssignmentBLL.get(vendorDepositAssignment.getDepositNo());
            vendorDepositAssignmentTransactionDateDaysName = vendorDepositAssignment.getTransactionDateDaysName();
            vendorDepositAssignmentAssignmentDateDaysName = vendorDepositAssignment.getAssignmentDateDaysName();
           
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

    public VendorDepositAssignmentTemp getVendorDepositAssignment() {
        return vendorDepositAssignment;
    }

    public void setVendorDepositAssignment(VendorDepositAssignmentTemp vendorDepositAssignment) {
        this.vendorDepositAssignment = vendorDepositAssignment;
    }

    public String getDepositNo() {
        return depositNo;
    }

    public void setDepositNo(String depositNo) {
        this.depositNo = depositNo;
    }
 
    public Date getVendorDepositAssignmentFirstDate() {
        return vendorDepositAssignmentFirstDate;
    }

    public void setVendorDepositAssignmentFirstDate(Date vendorDepositAssignmentFirstDate) {
        this.vendorDepositAssignmentFirstDate = vendorDepositAssignmentFirstDate;
    }

    public Date getVendorDepositAssignmentLastDate() {
        return vendorDepositAssignmentLastDate;
    }

    public void setVendorDepositAssignmentLastDate(Date vendorDepositAssignmentLastDate) {
        this.vendorDepositAssignmentLastDate = vendorDepositAssignmentLastDate;
    }

    public String getVendorDepositAssignmentTransactionDateDaysName() {
        return vendorDepositAssignmentTransactionDateDaysName;
    }

    public void setVendorDepositAssignmentTransactionDateDaysName(String vendorDepositAssignmentTransactionDateDaysName) {
        this.vendorDepositAssignmentTransactionDateDaysName = vendorDepositAssignmentTransactionDateDaysName;
    }

    public String getVendorDepositAssignmentAssignmentDateDaysName() {
        return vendorDepositAssignmentAssignmentDateDaysName;
    }

    public void setVendorDepositAssignmentAssignmentDateDaysName(String vendorDepositAssignmentAssignmentDateDaysName) {
        this.vendorDepositAssignmentAssignmentDateDaysName = vendorDepositAssignmentAssignmentDateDaysName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    

}
