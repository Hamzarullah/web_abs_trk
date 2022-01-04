
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.BankBLL;
import com.inkombizz.master.model.Bank;
import com.inkombizz.master.model.BankTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class BankJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Bank bank;
    private BankTemp bankTemp;
    private List <BankTemp> listBankTemp;
    private String bankSearchCode = "";
    private String bankSearchName = "";
    private String bankSearchActiveStatus="true";
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
    
    @Action("bank-data")
    public String findData() {
        try {
            BankBLL bankBLL = new BankBLL(hbmSession);
            ListPaging <BankTemp> listPaging = bankBLL.findData(bankSearchCode,bankSearchName,bankSearchActiveStatus,paging);
            
            listBankTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-get-data")
    public String findData1() {
        try {
            BankBLL bankBLL = new BankBLL(hbmSession);
            this.bankTemp = bankBLL.findData(this.bank.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-get")
    public String findData2() {
        try {
            BankBLL bankBLL = new BankBLL(hbmSession);
            this.bankTemp = bankBLL.findData(this.bank.getCode(),this.bank.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-authority")
    public String bankAuthority(){
        try{
            
            BankBLL bankBLL = new BankBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(bankBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("bank-save")
    public String save() {
        try {
            BankBLL bankBLL = new BankBLL(hbmSession);
            
          bank.setInActiveDate(commonFunction.setDateTime(bankTemp.getInActiveDateTemp()));
         bank.setCreatedDate(commonFunction.setDateTime(bankTemp.getCreatedDateTemp()));
            
            if(bankBLL.isExist(this.bank.getCode())){
                this.errorMessage = "CODE "+this.bank.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                bankBLL.save(this.bank);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.bank.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-update")
    public String update() {
        try {
            BankBLL bankBLL = new BankBLL(hbmSession);
            bank.setInActiveDate(commonFunction.setDateTime(bankTemp.getInActiveDateTemp()));
            bank.setCreatedDate(commonFunction.setDateTime(bankTemp.getCreatedDateTemp()));
            bankBLL.update(this.bank);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.bank.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bank-delete")
    public String delete() {
        try {
           BankBLL bankBLL = new BankBLL(hbmSession);
            bankBLL.delete(this.bank.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.bank.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Bank getBank() {
        return bank;
    }

    public void setBank(Bank bank) {
        this.bank = bank;
    }

    public BankTemp getBankTemp() {
        return bankTemp;
    }

    public void setBankTemp(BankTemp bankTemp) {
        this.bankTemp = bankTemp;
    }

    public List<BankTemp> getListBankTemp() {
        return listBankTemp;
    }

    public void setListBankTemp(List<BankTemp> listBankTemp) {
        this.listBankTemp = listBankTemp;
    }

    public String getBankSearchCode() {
        return bankSearchCode;
    }

    public void setBankSearchCode(String bankSearchCode) {
        this.bankSearchCode = bankSearchCode;
    }

    public String getBankSearchName() {
        return bankSearchName;
    }

    public void setBankSearchName(String bankSearchName) {
        this.bankSearchName = bankSearchName;
    }

    public String getBankSearchActiveStatus() {
        return bankSearchActiveStatus;
    }

    public void setBankSearchActiveStatus(String bankSearchActiveStatus) {
        this.bankSearchActiveStatus = bankSearchActiveStatus;
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
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging=new Paging();
    
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
