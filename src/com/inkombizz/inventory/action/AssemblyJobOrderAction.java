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
import com.inkombizz.inventory.bll.AssemblyJobOrderBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="inventory/assembly-job-order.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssemblyJobOrderAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    Date assemblyJobOrderSearchFirstDate;
    Date assemblyJobOrderSearchLastDate;
    
    @Override
    public String execute() {
        try {
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(assemblyJobOrderBLL.MODULECODE_JOB_ORDER, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            assemblyJobOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            assemblyJobOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
           
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

    public Date getAssemblyJobOrderSearchFirstDate() {
        return assemblyJobOrderSearchFirstDate;
    }

    public void setAssemblyJobOrderSearchFirstDate(Date assemblyJobOrderSearchFirstDate) {
        this.assemblyJobOrderSearchFirstDate = assemblyJobOrderSearchFirstDate;
    }

    public Date getAssemblyJobOrderSearchLastDate() {
        return assemblyJobOrderSearchLastDate;
    }

    public void setAssemblyJobOrderSearchLastDate(Date assemblyJobOrderSearchLastDate) {
        this.assemblyJobOrderSearchLastDate = assemblyJobOrderSearchLastDate;
    }
}
