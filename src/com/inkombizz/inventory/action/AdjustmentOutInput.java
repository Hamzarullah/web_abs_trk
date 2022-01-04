
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentOutBLL;
import com.inkombizz.inventory.model.AdjustmentOut;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="inventory/adjustment-out-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AdjustmentOutInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AdjustmentOut adjustmentOut=new AdjustmentOut();
    private boolean adjustmentOutUpdateMode = false;
    private Date adjustmentOutTransactionDate;
    private Module module=null;
    private Currency currency=null;
    
    @Override
    public String execute(){
  
        try {                
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession); 
                
                                
            if(adjustmentOutUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(adjustmentOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                adjustmentOut = (AdjustmentOut) hbmSession.hSession.get(AdjustmentOut.class, adjustmentOut.getCode());
                adjustmentOutTransactionDate=adjustmentOut.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(adjustmentOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                 
                 
                adjustmentOut = new AdjustmentOut();
                adjustmentOut.setCode("AUTO");
                adjustmentOut.setTransactionDate(new Date());
                adjustmentOutTransactionDate=new Date();
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                adjustmentOut.setBranch(user.getBranch());
                
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

    public AdjustmentOut getAdjustmentOut() {
        return adjustmentOut;
    }

    public void setAdjustmentOut(AdjustmentOut adjustmentOut) {
        this.adjustmentOut = adjustmentOut;
    }

    public boolean isAdjustmentOutUpdateMode() {
        return adjustmentOutUpdateMode;
    }

    public void setAdjustmentOutUpdateMode(boolean adjustmentOutUpdateMode) {
        this.adjustmentOutUpdateMode = adjustmentOutUpdateMode;
    }

    public Date getAdjustmentOutTransactionDate() {
        return adjustmentOutTransactionDate;
    }

    public void setAdjustmentOutTransactionDate(Date adjustmentOutTransactionDate) {
        this.adjustmentOutTransactionDate = adjustmentOutTransactionDate;
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
