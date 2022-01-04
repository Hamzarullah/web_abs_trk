
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import java.util.Date;

import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.inventory.bll.AdjustmentInBLL;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Results({
    @Result(name="success", location="inventory/adjustment-in-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentInInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentIn adjustmentIn=new AdjustmentIn();
    private boolean adjustmentInUpdateMode = false;
    private Date adjustmentInTransactionDate;
    private Module module=null;
    private Currency currency=null;
    
    @Override
    public String execute(){
  
        try {                
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession); 
                                
            if(adjustmentInUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                adjustmentIn = (AdjustmentIn) hbmSession.hSession.get(AdjustmentIn.class, adjustmentIn.getCode());
                adjustmentInTransactionDate=adjustmentIn.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                 
                adjustmentIn = new AdjustmentIn();
                adjustmentIn.setCode("AUTO");
                adjustmentIn.setTransactionDate(new Date());
                adjustmentInTransactionDate=new Date();
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                adjustmentIn.setBranch(user.getBranch());
            
            }
            
            
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

    public AdjustmentIn getAdjustmentIn() {
        return adjustmentIn;
    }

    public void setAdjustmentIn(AdjustmentIn adjustmentIn) {
        this.adjustmentIn = adjustmentIn;
    }

    public boolean isAdjustmentInUpdateMode() {
        return adjustmentInUpdateMode;
    }

    public void setAdjustmentInUpdateMode(boolean adjustmentInUpdateMode) {
        this.adjustmentInUpdateMode = adjustmentInUpdateMode;
    }

    public Date getAdjustmentInTransactionDate() {
        return adjustmentInTransactionDate;
    }

    public void setAdjustmentInTransactionDate(Date adjustmentInTransactionDate) {
        this.adjustmentInTransactionDate = adjustmentInTransactionDate;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    
}
