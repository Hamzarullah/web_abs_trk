
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.master.bll.DcasLegalRequirementsBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Results({
     @Result(name="success", location="master/dcas-legal-requirements.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class DcasLegalRequirementsAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(dcasLegalRequirementsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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


