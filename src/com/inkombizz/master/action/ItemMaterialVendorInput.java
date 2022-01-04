
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.master.bll.ItemMaterialBLL;
import com.inkombizz.master.model.ItemMaterial;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Results({
     @Result(name="success", location="master/item-material-vendor-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemMaterialVendorInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ItemMaterial itemMaterialVendor =new ItemMaterial();
    @Override
    public String execute() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
             itemMaterialVendor = (ItemMaterial) hbmSession.hSession.get(ItemMaterial.class, itemMaterialVendor.getCode());
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

    public ItemMaterial getItemMaterialVendor() {
        return itemMaterialVendor;
    }

    public void setItemMaterialVendor(ItemMaterial itemMaterialVendor) {
        this.itemMaterialVendor = itemMaterialVendor;
    }


    
}


