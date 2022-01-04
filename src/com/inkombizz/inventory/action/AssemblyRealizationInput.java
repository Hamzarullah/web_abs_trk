/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AssemblyRealizationBLL;
import com.inkombizz.inventory.model.AssemblyRealization;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="inventory/assembly-realization-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssemblyRealizationInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AssemblyRealization assemblyRealization;
    private boolean assemblyRealizationUpdateMode = false;
    
    private Date assemblyRealizationTransactionDateFirstSession;
    private Date assemblyRealizationTransactionDateLastSession;
    private Date assemblyRealizationTransactionDate;
    
    @Override
    public String execute(){
        try {                
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);  
                        
            assemblyRealizationTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            assemblyRealizationTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
   
                                
            if(assemblyRealizationUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(assemblyRealizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                assemblyRealization = (AssemblyRealization) hbmSession.hSession.get(AssemblyRealization.class, assemblyRealization.getCode());
                assemblyRealizationTransactionDate=assemblyRealization.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(assemblyRealizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                assemblyRealization = new AssemblyRealization();
                assemblyRealization.setCode("AUTO");

                assemblyRealization.setTransactionDate(new Date());
                assemblyRealizationTransactionDate=new Date();
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

    public AssemblyRealization getAssemblyRealization() {
        return assemblyRealization;
    }

    public void setAssemblyRealization(AssemblyRealization assemblyRealization) {
        this.assemblyRealization = assemblyRealization;
    }

    public boolean isAssemblyRealizationUpdateMode() {
        return assemblyRealizationUpdateMode;
    }

    public void setAssemblyRealizationUpdateMode(boolean assemblyRealizationUpdateMode) {
        this.assemblyRealizationUpdateMode = assemblyRealizationUpdateMode;
    }

    public Date getAssemblyRealizationTransactionDateFirstSession() {
        return assemblyRealizationTransactionDateFirstSession;
    }

    public void setAssemblyRealizationTransactionDateFirstSession(Date assemblyRealizationTransactionDateFirstSession) {
        this.assemblyRealizationTransactionDateFirstSession = assemblyRealizationTransactionDateFirstSession;
    }

    public Date getAssemblyRealizationTransactionDateLastSession() {
        return assemblyRealizationTransactionDateLastSession;
    }

    public void setAssemblyRealizationTransactionDateLastSession(Date assemblyRealizationTransactionDateLastSession) {
        this.assemblyRealizationTransactionDateLastSession = assemblyRealizationTransactionDateLastSession;
    }

    public Date getAssemblyRealizationTransactionDate() {
        return assemblyRealizationTransactionDate;
    }

    public void setAssemblyRealizationTransactionDate(Date assemblyRealizationTransactionDate) {
        this.assemblyRealizationTransactionDate = assemblyRealizationTransactionDate;
    }
}
