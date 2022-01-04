
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.master.bll.AssetCategoryBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Results({
    @Result(name="success", location="master/asset-category.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssetCategoryAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(assetCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
}
