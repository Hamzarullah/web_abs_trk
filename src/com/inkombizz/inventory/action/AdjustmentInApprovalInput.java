
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.inventory.bll.AdjustmentInBLL;
import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.master.model.Currency;
import java.math.BigDecimal;
import java.math.BigInteger;


@Results({
    @Result(name="success", location="inventory/adjustment-in-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentInApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentIn adjustmentInApproval;
    private BigDecimal adjustmentInApprovalGrandTotalAmountIDR=new BigDecimal("0.00");
    
    @Override
    public String execute() throws Exception {
          try {  
              
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
            adjustmentInApproval = (AdjustmentIn) hbmSession.hSession.get(AdjustmentIn.class, adjustmentInApproval.getCode());
            Currency currency = (Currency) hbmSession.hSession.get(Currency.class, BaseSession.loadProgramSession().getSetup().getCurrencyCode());
            adjustmentInApproval.setCurrency(currency);
            adjustmentInApproval.setExchangeRate(new BigDecimal("1.00"));
            adjustmentInApprovalGrandTotalAmountIDR=adjustmentInApproval.getGrandTotalAmount().multiply(adjustmentInApproval.getExchangeRate());
            return SUCCESS;
                
        } catch (Exception e) {
            e.printStackTrace();
        }
   
        return SUCCESS;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AdjustmentIn getAdjustmentInApproval() {
        return adjustmentInApproval;
    }

    public void setAdjustmentInApproval(AdjustmentIn adjustmentInApproval) {
        this.adjustmentInApproval = adjustmentInApproval;
    }

    public BigDecimal getAdjustmentInApprovalGrandTotalAmountIDR() {
        return adjustmentInApprovalGrandTotalAmountIDR;
    }

    public void setAdjustmentInApprovalGrandTotalAmountIDR(BigDecimal adjustmentInApprovalGrandTotalAmountIDR) {
        this.adjustmentInApprovalGrandTotalAmountIDR = adjustmentInApprovalGrandTotalAmountIDR;
    }

    
    
}
