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
    @Result(name="success", location="finance/vendor-deposit-assignment.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDepositAssignmentAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date vendorDepositAssignmentSearchFirstDate;
    private Date vendorDepositAssignmentSearchLastDate;
    
    @Override
    public String execute() {
        try {
            VendorDepositAssignmentBLL vendorDepositAssignmentBLL = new VendorDepositAssignmentBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            vendorDepositAssignmentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            vendorDepositAssignmentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
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

    public Date getVendorDepositAssignmentSearchFirstDate() {
        return vendorDepositAssignmentSearchFirstDate;
    }

    public void setVendorDepositAssignmentSearchFirstDate(Date vendorDepositAssignmentSearchFirstDate) {
        this.vendorDepositAssignmentSearchFirstDate = vendorDepositAssignmentSearchFirstDate;
    }

    public Date getVendorDepositAssignmentSearchLastDate() {
        return vendorDepositAssignmentSearchLastDate;
    }

    public void setVendorDepositAssignmentSearchLastDate(Date vendorDepositAssignmentSearchLastDate) {
        this.vendorDepositAssignmentSearchLastDate = vendorDepositAssignmentSearchLastDate;
    }

}