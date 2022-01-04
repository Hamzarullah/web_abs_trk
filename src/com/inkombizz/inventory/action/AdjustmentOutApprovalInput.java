
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentOutBLL;
import com.inkombizz.inventory.model.AdjustmentOut;
import com.inkombizz.master.model.Currency;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="inventory/adjustment-out-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class AdjustmentOutApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentOut adjustmentOutApproval;
        
    @Override
    public String execute() throws Exception {
          try {  
              
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentOutBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
            adjustmentOutApproval = (AdjustmentOut) hbmSession.hSession.get(AdjustmentOut.class, adjustmentOutApproval.getCode());
            Currency currency = (Currency) hbmSession.hSession.get(Currency.class, BaseSession.loadProgramSession().getSetup().getCurrencyCode());
            adjustmentOutApproval.setCurrency(currency);
            adjustmentOutApproval.setExchangeRate(new BigDecimal("1.00"));
                    
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

    public AdjustmentOut getAdjustmentOutApproval() {
        return adjustmentOutApproval;
    }

    public void setAdjustmentOutApproval(AdjustmentOut adjustmentOutApproval) {
        this.adjustmentOutApproval = adjustmentOutApproval;
    }

    
}

