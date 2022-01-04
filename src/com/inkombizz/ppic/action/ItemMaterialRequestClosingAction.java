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
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Sukha
 */

@Results({
    @Result(name="success", location="ppic/item-material-request-closing.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemMaterialRequestClosingAction extends ActionSupport {
    
    public static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ItemMaterialRequest itemMaterialRequestClosing = new ItemMaterialRequest();
    
    @Override
    public String execute(){
        try{
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);
            if(!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE_CLOSING, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)){
                return "redirect";
            }
            itemMaterialRequestClosing.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            itemMaterialRequestClosing.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            
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

    public ItemMaterialRequest getItemMaterialRequestClosing() {
        return itemMaterialRequestClosing;
    }

    public void setItemMaterialRequestClosing(ItemMaterialRequest itemMaterialRequestClosing) {
        this.itemMaterialRequestClosing = itemMaterialRequestClosing;
    }

    
    
    
}
