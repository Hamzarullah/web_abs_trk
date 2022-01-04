
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.CashReceivedBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/cash-received.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CashReceivedAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date cashReceivedSearchFirstDate;
    private Date cashReceivedSearchLastDate;
    private BigDecimal cashReceivedSearchFirstTotalAmount=new BigDecimal("0");
    private BigDecimal cashReceivedSearchLastTotalAmount=new BigDecimal("1000000000");
    
    @Override
    public String execute() {
        try {
            CashReceivedBLL cashReceivedBLL = new CashReceivedBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(cashReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            cashReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            cashReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            cashReceivedSearchFirstTotalAmount=new BigDecimal("0");
            cashReceivedSearchLastTotalAmount=new BigDecimal("1000000000");
            
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

    public Date getCashReceivedSearchFirstDate() {
        return cashReceivedSearchFirstDate;
    }

    public void setCashReceivedSearchFirstDate(Date cashReceivedSearchFirstDate) {
        this.cashReceivedSearchFirstDate = cashReceivedSearchFirstDate;
    }

    public Date getCashReceivedSearchLastDate() {
        return cashReceivedSearchLastDate;
    }

    public void setCashReceivedSearchLastDate(Date cashReceivedSearchLastDate) {
        this.cashReceivedSearchLastDate = cashReceivedSearchLastDate;
    }

    public BigDecimal getCashReceivedSearchFirstTotalAmount() {
        return cashReceivedSearchFirstTotalAmount;
    }

    public void setCashReceivedSearchFirstTotalAmount(BigDecimal cashReceivedSearchFirstTotalAmount) {
        this.cashReceivedSearchFirstTotalAmount = cashReceivedSearchFirstTotalAmount;
    }

    public BigDecimal getCashReceivedSearchLastTotalAmount() {
        return cashReceivedSearchLastTotalAmount;
    }

    public void setCashReceivedSearchLastTotalAmount(BigDecimal cashReceivedSearchLastTotalAmount) {
        this.cashReceivedSearchLastTotalAmount = cashReceivedSearchLastTotalAmount;
    }

    
}
