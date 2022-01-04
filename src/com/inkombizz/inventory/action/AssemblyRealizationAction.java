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
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="inventory/assembly-realization.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssemblyRealizationAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    Date assemblyRealizationSearchFirstDate;
    Date assemblyRealizationSearchLastDate;
    
    @Override
    public String execute() {
        try {
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(assemblyRealizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            assemblyRealizationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            assemblyRealizationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
           
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Date getAssemblyRealizationSearchFirstDate() {
        return assemblyRealizationSearchFirstDate;
    }

    public void setAssemblyRealizationSearchFirstDate(Date assemblyRealizationSearchFirstDate) {
        this.assemblyRealizationSearchFirstDate = assemblyRealizationSearchFirstDate;
    }

    public Date getAssemblyRealizationSearchLastDate() {
        return assemblyRealizationSearchLastDate;
    }

    public void setAssemblyRealizationSearchLastDate(Date assemblyRealizationSearchLastDate) {
        this.assemblyRealizationSearchLastDate = assemblyRealizationSearchLastDate;
    }
}
