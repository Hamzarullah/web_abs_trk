
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import static com.opensymphony.xwork2.Action.SUCCESS;

import com.inkombizz.master.bll.BankAccountBLL;
import com.inkombizz.master.model.BankAccount;
import com.inkombizz.master.model.BankAccountTemp;

@Result(type = "json")
public class BankAccountJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BankAccount bankAccount;
    private BankAccountTemp bankAccountTemp;
    private List<BankAccountTemp> listBankAccountTemp;
    private String bankAccountSearchCode="";
    private String bankAccountSearchName="";
    private String bankAccountSearchChartOfAccountCode="";
    private String bankAccountSearchChartOfAccountName="";
    private String bankAccountSearchBbmVoucherNo="";
    private String bankAccountSearchActiveStatus="true";
    private String actionAuthority="";
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    

    @Action("bank-account-data")
    public String findData() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            ListPaging<BankAccountTemp> listPaging = bankAccountBLL.findData(paging,bankAccountSearchCode,bankAccountSearchName,bankAccountSearchChartOfAccountCode,bankAccountSearchChartOfAccountName,bankAccountSearchBbmVoucherNo,bankAccountSearchActiveStatus);

            listBankAccountTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-get-data")
    public String findData1() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            this.bankAccountTemp = bankAccountBLL.findData(this.bankAccount.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-get")
    public String findData2() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            this.bankAccountTemp = bankAccountBLL.findData(this.bankAccount.getCode(),this.bankAccount.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-get2")
    public String findDataGet2() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            this.bankAccountTemp = bankAccountBLL.findData2(this.bankAccount.getCode(),bankAccountSearchActiveStatus);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-authority")
    public String bankAccountAuthority(){
        try{
            
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                
            }
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-save")
    public String save() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            
            if(bankAccountBLL.isExist(this.bankAccount.getCode())){
                this.errorMessage = "CODE "+this.bankAccount.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                bankAccountBLL.save(this.bankAccount);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.bankAccount.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-update")
    public String update() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            bankAccountBLL.update(this.bankAccount);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.bankAccount.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-delete")
    public String delete() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            boolean check=false;// = bankAccountBLL.isExistToDelete(this.bankAccount.getCode());
            if(check == true){
                this.message = "CODE "+this.bankAccount.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                bankAccountBLL.delete(this.bankAccount.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.bankAccount.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("bank-account-get-min")
    public String minData() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            this.bankAccountTemp = bankAccountBLL.min();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-account-get-max")
    public String maxData() {
        try {
            BankAccountBLL bankAccountBLL = new BankAccountBLL(hbmSession);
            this.bankAccountTemp = bankAccountBLL.max();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public BankAccount getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(BankAccount bankAccount) {
        this.bankAccount = bankAccount;
    }

    public BankAccountTemp getBankAccountTemp() {
        return bankAccountTemp;
    }

    public void setBankAccountTemp(BankAccountTemp bankAccountTemp) {
        this.bankAccountTemp = bankAccountTemp;
    }

    public List<BankAccountTemp> getListBankAccountTemp() {
        return listBankAccountTemp;
    }

    public void setListBankAccountTemp(List<BankAccountTemp> listBankAccountTemp) {
        this.listBankAccountTemp = listBankAccountTemp;
    }

    public String getBankAccountSearchCode() {
        return bankAccountSearchCode;
    }

    public void setBankAccountSearchCode(String bankAccountSearchCode) {
        this.bankAccountSearchCode = bankAccountSearchCode;
    }

    public String getBankAccountSearchName() {
        return bankAccountSearchName;
    }

    public void setBankAccountSearchName(String bankAccountSearchName) {
        this.bankAccountSearchName = bankAccountSearchName;
    }

    public String getBankAccountSearchActiveStatus() {
        return bankAccountSearchActiveStatus;
    }

    public void setBankAccountSearchActiveStatus(String bankAccountSearchActiveStatus) {
        this.bankAccountSearchActiveStatus = bankAccountSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
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
    
    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
    Paging paging = new Paging();
    
     
    
    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
    
    public Integer getRows() {
        return paging.getRows();
    }
    public void setRows(Integer rows) {
        paging.setRows(rows);
    }
    
    public Integer getPage() {
        return paging.getPage();
    }
    public void setPage(Integer page) {
        paging.setPage(page);
    }
    
    public Integer getTotal() {
        return paging.getTotal();
    }
    public void setTotal(Integer total) {
        paging.setTotal(total);
    }
    
    public Integer getRecords() {
        return paging.getRecords();
    }
    public void setRecords(Integer records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }
    
    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }
    
    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }
    
    public void setSearchField(String searchField) {
        paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }
    
   // </editor-fold>


    
    
}
