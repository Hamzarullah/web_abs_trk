
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

import com.inkombizz.master.bll.CashAccountBLL;
import com.inkombizz.master.model.CashAccount;
import com.inkombizz.master.model.CashAccountTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class CashAccountJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private CashAccount cashAccount;
    private CashAccountTemp cashAccountTemp;
    private List <CashAccountTemp> listCashAccountTemp;
    private String cashAccountSearchCode = "";
    private String cashAccountSearchName = "";
    private String cashAccountSearchActiveStatus="true";
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
    
    @Action("cash-account-data")
    public String findData() {
        try {
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            ListPaging <CashAccountTemp> listPaging = cashAccountBLL.findData(cashAccountSearchCode,cashAccountSearchName,cashAccountSearchActiveStatus,paging);
            
            listCashAccountTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-account-get-data")
    public String findData1() {
        try {
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            this.cashAccountTemp = cashAccountBLL.findData(this.cashAccount.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-account-get")
    public String findData2() {
        try {
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            this.cashAccountTemp = cashAccountBLL.findData(this.cashAccount.getCode(),this.cashAccount.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-account-authority")
    public String cashAccountAuthority(){
        try{
            
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(cashAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cashAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cashAccountBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("cash-account-save")
    public String save() {
        try {
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            
            cashAccount.setInActiveDate(commonFunction.setDateTime(cashAccountTemp.getInActiveDateTemp()));
            cashAccount.setCreatedDate(commonFunction.setDateTime(cashAccountTemp.getCreatedDateTemp()));
            
            if(cashAccountBLL.isExist(this.cashAccount.getCode())){
                this.errorMessage = "CODE "+this.cashAccount.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                cashAccountBLL.save(this.cashAccount);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.cashAccount.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-account-update")
    public String update() {
        try {
            CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            cashAccount.setInActiveDate(commonFunction.setDateTime(cashAccountTemp.getInActiveDateTemp()));
            cashAccount.setCreatedDate(commonFunction.setDateTime(cashAccountTemp.getCreatedDateTemp()));
            cashAccountBLL.update(this.cashAccount);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.cashAccount.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cash-account-delete")
    public String delete() {
        try {
           CashAccountBLL cashAccountBLL = new CashAccountBLL(hbmSession);
            cashAccountBLL.delete(this.cashAccount.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.cashAccount.getCode();
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

    public CashAccount getCashAccount() {
        return cashAccount;
    }

    public void setCashAccount(CashAccount cashAccount) {
        this.cashAccount = cashAccount;
    }

    public CashAccountTemp getCashAccountTemp() {
        return cashAccountTemp;
    }

    public void setCashAccountTemp(CashAccountTemp cashAccountTemp) {
        this.cashAccountTemp = cashAccountTemp;
    }

    public List<CashAccountTemp> getListCashAccountTemp() {
        return listCashAccountTemp;
    }

    public void setListCashAccountTemp(List<CashAccountTemp> listCashAccountTemp) {
        this.listCashAccountTemp = listCashAccountTemp;
    }

    public String getCashAccountSearchCode() {
        return cashAccountSearchCode;
    }

    public void setCashAccountSearchCode(String cashAccountSearchCode) {
        this.cashAccountSearchCode = cashAccountSearchCode;
    }

    public String getCashAccountSearchName() {
        return cashAccountSearchName;
    }

    public void setCashAccountSearchName(String cashAccountSearchName) {
        this.cashAccountSearchName = cashAccountSearchName;
    }

    public String getCashAccountSearchActiveStatus() {
        return cashAccountSearchActiveStatus;
    }

    public void setCashAccountSearchActiveStatus(String cashAccountSearchActiveStatus) {
        this.cashAccountSearchActiveStatus = cashAccountSearchActiveStatus;
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
