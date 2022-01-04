/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.BillOfMaterialTemplate;
import com.inkombizz.master.bll.BillOfMaterialTemplateBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="master/bill-of-material-template-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BillOfMaterialTemplateInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private BillOfMaterialTemplate billOfMaterialTemplate=new BillOfMaterialTemplate();
    private boolean billOfMaterialTemplateUpdateMode = false;
    
    @Override
    public String execute(){
  
        try {                
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);  
                                
            if(billOfMaterialTemplateUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                billOfMaterialTemplate = (BillOfMaterialTemplate) hbmSession.hSession.get(BillOfMaterialTemplate.class, billOfMaterialTemplate.getCode());
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                billOfMaterialTemplate = new BillOfMaterialTemplate();
                billOfMaterialTemplate.setCode("AUTO");

                billOfMaterialTemplate.setTransactionDate(new Date());
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

    public BillOfMaterialTemplate getBillOfMaterialTemplate() {
        return billOfMaterialTemplate;
    }

    public void setBillOfMaterialTemplate(BillOfMaterialTemplate billOfMaterialTemplate) {
        this.billOfMaterialTemplate = billOfMaterialTemplate;
    }

    public boolean isBillOfMaterialTemplateUpdateMode() {
        return billOfMaterialTemplateUpdateMode;
    }

    public void setBillOfMaterialTemplateUpdateMode(boolean billOfMaterialTemplateUpdateMode) {
        this.billOfMaterialTemplateUpdateMode = billOfMaterialTemplateUpdateMode;
    }
    
    
}
