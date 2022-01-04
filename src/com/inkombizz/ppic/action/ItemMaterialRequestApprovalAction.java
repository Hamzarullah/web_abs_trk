/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ItemMaterialRequestBLL;
import com.inkombizz.ppic.model.ItemMaterialRequest;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Sukha
 */

@Results({
    @Result(name="success", location="ppic/item-material-request-approval.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemMaterialRequestApprovalAction extends ActionSupport {
    
    public static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ItemMaterialRequest itemMaterialRequestApproval = new ItemMaterialRequest();
    
    @Override
    public String execute(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            if(!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)){
                return "redirect";
            }
            itemMaterialRequestApproval.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            itemMaterialRequestApproval.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            
            return SUCCESS;
            
        }catch(Exception ex){
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ItemMaterialRequest getItemMaterialRequestApproval() {
        return itemMaterialRequestApproval;
    }

    public void setItemMaterialRequestApproval(ItemMaterialRequest itemMaterialRequestApproval) {
        this.itemMaterialRequestApproval = itemMaterialRequestApproval;
    }
    
    
}
