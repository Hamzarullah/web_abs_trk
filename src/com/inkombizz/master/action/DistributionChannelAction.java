/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.DistributionChannelBLL;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author thomz
// */
@Results({
    @Result(name="success", location="master/distribution-channel.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class DistributionChannelAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DistributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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
