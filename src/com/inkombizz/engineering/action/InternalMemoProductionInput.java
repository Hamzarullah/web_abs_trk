
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
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;

@Results({
    @Result(name="success", location="engineering/internal-memo-production-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoProductionInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private InternalMemoProduction internalMemoProduction =new InternalMemoProduction();
    private Boolean internalMemoProductionUpdateMode = Boolean.FALSE;
    private Boolean internalMemoProductionCloneMode = Boolean.FALSE;
    private Boolean internalMemoProductionReviseMode = Boolean.FALSE;
    
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            InternalMemoProductionBLL internalMemoProductionBLL = new InternalMemoProductionBLL(hbmSession); 
//            
            if(internalMemoProductionUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                internalMemoProduction = (InternalMemoProduction) hbmSession.hSession.get(InternalMemoProduction.class, internalMemoProduction.getCode());
                internalMemoProduction.setTransactionDate(internalMemoProduction.getTransactionDate());
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(internalMemoProductionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }            
                
//                module = (Module) hbmSession.hSession.get(Module.class, internalMemoBLL.MODULECODE);
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                
                internalMemoProduction = new InternalMemoProduction();
                internalMemoProduction.setCode("AUTO");
                internalMemoProduction.setBranch(user.getBranch()); 
                internalMemoProduction.setTransactionDate(new Date());
                
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

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public InternalMemoProduction getInternalMemoProduction() {
        return internalMemoProduction;
    }

    public void setInternalMemoProduction(InternalMemoProduction internalMemoProduction) {
        this.internalMemoProduction = internalMemoProduction;
    }

    public Boolean getInternalMemoProductionUpdateMode() {
        return internalMemoProductionUpdateMode;
    }

    public void setInternalMemoProductionUpdateMode(Boolean internalMemoProductionUpdateMode) {
        this.internalMemoProductionUpdateMode = internalMemoProductionUpdateMode;
    }

    public Boolean getInternalMemoProductionCloneMode() {
        return internalMemoProductionCloneMode;
    }

    public void setInternalMemoProductionCloneMode(Boolean internalMemoProductionCloneMode) {
        this.internalMemoProductionCloneMode = internalMemoProductionCloneMode;
    }

    public Boolean getInternalMemoProductionReviseMode() {
        return internalMemoProductionReviseMode;
    }

    public void setInternalMemoProductionReviseMode(Boolean internalMemoProductionReviseMode) {
        this.internalMemoProductionReviseMode = internalMemoProductionReviseMode;
    }

    
}
