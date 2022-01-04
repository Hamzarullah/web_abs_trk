
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Division;
import com.inkombizz.sales.bll.InternalMemoMaterialBLL;
import com.inkombizz.sales.model.InternalMemoMaterial;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="sales/internal-memo-material-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoMaterialInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private EnumActivity.ENUM_Activity enumInternalMemoMaterialActivity;
    private InternalMemoMaterial internalMemoMaterial =new InternalMemoMaterial();
    
    @Override
    public String execute() {
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
                        
            switch(enumInternalMemoMaterialActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    } 
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                    
                    internalMemoMaterial.setTransactionDate(new Date());
                    internalMemoMaterial.setCode("AUTO");
                    internalMemoMaterial.setBranch(user.getBranch());
                    internalMemoMaterial.setDivision(user.getDivision());
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    
                    internalMemoMaterial = (InternalMemoMaterial) hbmSession.hSession.get(InternalMemoMaterial.class, internalMemoMaterial.getCode());
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public EnumActivity.ENUM_Activity getEnumInternalMemoMaterialActivity() {
        return enumInternalMemoMaterialActivity;
    }

    public void setEnumInternalMemoMaterialActivity(EnumActivity.ENUM_Activity enumInternalMemoMaterialActivity) {
        this.enumInternalMemoMaterialActivity = enumInternalMemoMaterialActivity;
    }

    public InternalMemoMaterial getInternalMemoMaterial() {
        return internalMemoMaterial;
    }

    public void setInternalMemoMaterial(InternalMemoMaterial internalMemoMaterial) {
        this.internalMemoMaterial = internalMemoMaterial;
    }
    

}
