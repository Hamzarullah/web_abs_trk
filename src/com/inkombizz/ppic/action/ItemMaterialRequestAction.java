
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ItemMaterialRequestBLL;
import com.inkombizz.ppic.model.ItemMaterialRequest;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="ppic/item-material-request.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemMaterialRequestAction extends ActionSupport{
     private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ItemMaterialRequest itemMaterialRequest=new ItemMaterialRequest();
    
    @Override
    public String execute() {
        try {
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }      
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

    public ItemMaterialRequest getItemMaterialRequest() {
        return itemMaterialRequest;
    }

    public void setItemMaterialRequest(ItemMaterialRequest itemMaterialRequest) {
        this.itemMaterialRequest = itemMaterialRequest;
    }
    
}