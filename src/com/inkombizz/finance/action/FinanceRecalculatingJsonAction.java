/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Rayis
 */
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.FinanceRecalculatingBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", type = "json"),
    @Result(name="pageHTML", location="finance/finance-recalculating.jsp")
})
public class FinanceRecalculatingJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override 
    public String execute(){
        try{
            return  financeRecalculatingProses();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    @Action("finance-recalculating-process")
    public String financeRecalculatingProses(){
        try{
            FinanceRecalculatingBLL financeRecalculatingBLL = new FinanceRecalculatingBLL(hbmSession);
                
            financeRecalculatingBLL.financeRecalculatingProses();
            this.message ="FINANCE RECALCULATING SUCCCESS!";
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "PROCESS FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>
}
