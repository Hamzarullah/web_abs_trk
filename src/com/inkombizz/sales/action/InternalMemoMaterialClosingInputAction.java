/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.InternalMemoMaterialBLL;
import com.inkombizz.sales.model.InternalMemoMaterial;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/internal-memo-material-closing-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class InternalMemoMaterialClosingInputAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private InternalMemoMaterial internalMemoMaterialClosing =new InternalMemoMaterial();    
    
    @Override
    public String execute() {
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
                 
            if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }            

            internalMemoMaterialClosing = (InternalMemoMaterial) hbmSession.hSession.get(InternalMemoMaterial.class, internalMemoMaterialClosing.getCode());
                    
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

    public InternalMemoMaterial getInternalMemoMaterialClosing() {
        return internalMemoMaterialClosing;
    }

    public void setInternalMemoMaterialClosing(InternalMemoMaterial internalMemoMaterialClosing) {
        this.internalMemoMaterialClosing = internalMemoMaterialClosing;
    }
    
    
}
