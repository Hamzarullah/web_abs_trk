
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.BankReceivedBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/bank-received.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BankReceivedAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date bankReceivedSearchFirstDate;
    private Date bankReceivedSearchLastDate;
    private BigDecimal bankReceivedSearchFirstTotalAmount=new BigDecimal("0");
    private BigDecimal bankReceivedSearchLastTotalAmount=new BigDecimal("10000000000");
    
    @Override
    public String execute() {
        try {
            BankReceivedBLL bankReceivedBLL = new BankReceivedBLL(hbmSession);   
            if (!BaseSession.loadProgramSession().hasAuthority(bankReceivedBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            bankReceivedSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            bankReceivedSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            bankReceivedSearchFirstTotalAmount=new BigDecimal("0");
            bankReceivedSearchLastTotalAmount=new BigDecimal("10000000000");
            
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

    public Date getBankReceivedSearchFirstDate() {
        return bankReceivedSearchFirstDate;
    }

    public void setBankReceivedSearchFirstDate(Date bankReceivedSearchFirstDate) {
        this.bankReceivedSearchFirstDate = bankReceivedSearchFirstDate;
    }

    public Date getBankReceivedSearchLastDate() {
        return bankReceivedSearchLastDate;
    }

    public void setBankReceivedSearchLastDate(Date bankReceivedSearchLastDate) {
        this.bankReceivedSearchLastDate = bankReceivedSearchLastDate;
    }

    public BigDecimal getBankReceivedSearchFirstTotalAmount() {
        return bankReceivedSearchFirstTotalAmount;
    }

    public void setBankReceivedSearchFirstTotalAmount(BigDecimal bankReceivedSearchFirstTotalAmount) {
        this.bankReceivedSearchFirstTotalAmount = bankReceivedSearchFirstTotalAmount;
    }

    public BigDecimal getBankReceivedSearchLastTotalAmount() {
        return bankReceivedSearchLastTotalAmount;
    }

    public void setBankReceivedSearchLastTotalAmount(BigDecimal bankReceivedSearchLastTotalAmount) {
        this.bankReceivedSearchLastTotalAmount = bankReceivedSearchLastTotalAmount;
    }

    
}
