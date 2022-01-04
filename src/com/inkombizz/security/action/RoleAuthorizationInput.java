/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.RoleAuthorizationBLL;
import com.inkombizz.security.bll.RoleBLL;
import com.inkombizz.security.model.Role;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author niko
 */

@Results({
    @Result(name="success", location="security/role-authorization-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
    //@Result(name="redirectInput", location="security/role-authorization.jsp")
})
public class RoleAuthorizationInput extends ActionSupport {

    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private Role roleAutorization;
    private Role role;
    private boolean roleAuthorizationUpdateMode = false;

    @Override
    public String execute() throws Exception {
        RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession);  

        if (roleAuthorizationUpdateMode) {
            
            if (!BaseSession.loadProgramSession().hasAuthority(roleAuthorizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                //this.message = "YOU DONT HAVE AUTHORITY"; 
                return "redirect";
            }

            populateRole();
        }
        else{

//            if (!BaseSession.loadProgramSession().hasAuthority(RoleAuthorizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.VIEW));
//            }

        }
        
        return SUCCESS;
    }

    public String populateRole() {
        try {
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            roleAutorization = roleBLL.getHeader(role.getCode());

            return SUCCESS;
        } catch (Exception ex) {
            return SUCCESS;
        }
    }

    private String message = "";
    
    public Role getRole() {
        return role;
    }
    public void setRole(Role role) {
        this.role = role;
    }       

    public Role getRoleAutorization() {
        return roleAutorization;
    }

    public void setRoleAutorization(Role roleAutorization) {
        this.roleAutorization = roleAutorization;
    }
    
    
    public boolean isRoleAuthorizationUpdateMode() {
        return roleAuthorizationUpdateMode;
    }
    
    public void setRoleAuthorizationUpdateMode(boolean roleAuthorizationUpdateMode) {
        this.roleAuthorizationUpdateMode = roleAuthorizationUpdateMode;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
}
