/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.action;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author niko
 */
@Result(name="success", type="redirect", location="login")
public class SignoutAction extends ActionSupport {
    
    @Override
    public String execute() {
        try {            
            BaseSession.clearSession();
            return SUCCESS;
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
}
