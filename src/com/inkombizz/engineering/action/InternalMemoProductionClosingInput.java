
package com.inkombizz.engineering.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.bll.InternalMemoProductionBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.engineering.model.InternalMemoProduction;
import com.inkombizz.system.model.Module;

@Results({
    @Result(name="success", location="engineering/internal-memo-production-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoProductionClosingInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private InternalMemoProduction internalMemoProductionClosing =new InternalMemoProduction();
    
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession); 
//            
                if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                internalMemoProductionClosing = (InternalMemoProduction) hbmSession.hSession.get(InternalMemoProduction.class, internalMemoProductionClosing.getCode());
                internalMemoProductionClosing.setTransactionDate(internalMemoProductionClosing.getTransactionDate());
                
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

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public InternalMemoProduction getInternalMemoProductionClosing() {
        return internalMemoProductionClosing;
    }

    public void setInternalMemoProductionClosing(InternalMemoProduction internalMemoProductionClosing) {
        this.internalMemoProductionClosing = internalMemoProductionClosing;
    }


    
}
