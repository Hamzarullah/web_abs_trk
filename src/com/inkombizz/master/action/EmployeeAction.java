
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.EmployeeBLL;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="master/employee.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class EmployeeAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Date employeeFirstDate;
    private Date employeeLastDate;
    
    @Override
    public String execute() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(employeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }

              Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
              Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
              
              employeeFirstDate = firstDate;
              employeeLastDate = lastDate;
            
              
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public Date getEmployeeFirstDate() {
        return employeeFirstDate;
    }

    public void setEmployeeFirstDate(Date employeeFirstDate) {
        this.employeeFirstDate = employeeFirstDate;
    }

    public Date getEmployeeLastDate() {
        return employeeLastDate;
    }

    public void setEmployeeLastDate(Date employeeLastDate) {
        this.employeeLastDate = employeeLastDate;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
}
