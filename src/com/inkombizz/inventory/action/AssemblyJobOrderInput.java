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
import com.inkombizz.inventory.model.AssemblyJobOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="inventory/assembly-job-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssemblyJobOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private AssemblyJobOrder assemblyJobOrder;
    private boolean assemblyJobOrderUpdateMode = false;
    
    private Date assemblyJobOrderTransactionDateFirstSession;
    private Date assemblyJobOrderTransactionDateLastSession;
    private Date assemblyJobOrderTransactionDate;
    
    @Override
    public String execute(){
        try {                
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);  
                        
            assemblyJobOrderTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            assemblyJobOrderTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
   
                                
            if(assemblyJobOrderUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(assemblyJobOrderBLL.MODULECODE_JOB_ORDER, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                assemblyJobOrder = (AssemblyJobOrder) hbmSession.hSession.get(AssemblyJobOrder.class, assemblyJobOrder.getCode());
                assemblyJobOrderTransactionDate=assemblyJobOrder.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(assemblyJobOrderBLL.MODULECODE_JOB_ORDER, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                assemblyJobOrder = new AssemblyJobOrder();
                assemblyJobOrder.setCode("AUTO");
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                assemblyJobOrder.setBranch(user.getBranch());
                assemblyJobOrder.setTransactionDate(new Date());
                assemblyJobOrderTransactionDate=new Date();
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

    public AssemblyJobOrder getAssemblyJobOrder() {
        return assemblyJobOrder;
    }

    public void setAssemblyJobOrder(AssemblyJobOrder assemblyJobOrder) {
        this.assemblyJobOrder = assemblyJobOrder;
    }

    public boolean isAssemblyJobOrderUpdateMode() {
        return assemblyJobOrderUpdateMode;
    }

    public void setAssemblyJobOrderUpdateMode(boolean assemblyJobOrderUpdateMode) {
        this.assemblyJobOrderUpdateMode = assemblyJobOrderUpdateMode;
    }

    public Date getAssemblyJobOrderTransactionDateFirstSession() {
        return assemblyJobOrderTransactionDateFirstSession;
    }

    public void setAssemblyJobOrderTransactionDateFirstSession(Date assemblyJobOrderTransactionDateFirstSession) {
        this.assemblyJobOrderTransactionDateFirstSession = assemblyJobOrderTransactionDateFirstSession;
    }

    public Date getAssemblyJobOrderTransactionDateLastSession() {
        return assemblyJobOrderTransactionDateLastSession;
    }

    public void setAssemblyJobOrderTransactionDateLastSession(Date assemblyJobOrderTransactionDateLastSession) {
        this.assemblyJobOrderTransactionDateLastSession = assemblyJobOrderTransactionDateLastSession;
    }

    public Date getAssemblyJobOrderTransactionDate() {
        return assemblyJobOrderTransactionDate;
    }

    public void setAssemblyJobOrderTransactionDate(Date assemblyJobOrderTransactionDate) {
        this.assemblyJobOrderTransactionDate = assemblyJobOrderTransactionDate;
    }
}
