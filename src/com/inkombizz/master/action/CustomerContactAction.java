/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.CustomerBLL;
import com.inkombizz.master.bll.CustomerContactBLL;
import com.inkombizz.master.model.CustomerContact;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="master/customer-contact.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerContactAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CustomerContact customerContact = new CustomerContact();
    
    
    @Override
    public String execute() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(customerContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
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

    public CustomerContact getCustomerContact() {
        return customerContact;
    }

    public void setCustomerContact(CustomerContact customerContact) {
        this.customerContact = customerContact;
    }
    
}
