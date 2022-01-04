
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ContractReviewBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/contract-review.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ContractReviewAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Date contractReviewSearchFirstDate;
    private Date contractReviewSearchLastDate;
    
    @Override
    public String execute() {
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(contractReviewBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            contractReviewSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            contractReviewSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
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

    public Date getContractReviewSearchFirstDate() {
        return contractReviewSearchFirstDate;
    }

    public void setContractReviewSearchFirstDate(Date contractReviewSearchFirstDate) {
        this.contractReviewSearchFirstDate = contractReviewSearchFirstDate;
    }

    public Date getContractReviewSearchLastDate() {
        return contractReviewSearchLastDate;
    }

    public void setContractReviewSearchLastDate(Date contractReviewSearchLastDate) {
        this.contractReviewSearchLastDate = contractReviewSearchLastDate;
    }


    
}
