
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.master.bll.ItemSeatBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Results({
     @Result(name="success", location="master/item-seat.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemSeatAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            ItemSeatBLL ItemSeatBLL = new ItemSeatBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemSeatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
}


