
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

import com.inkombizz.master.bll.CurrencyBLL;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.CurrencyTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class CurrencyJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Currency currency;
    private CurrencyTemp currencyTemp;
    private List <CurrencyTemp> listCurrencyTemp;
    private String currencySearchCode = "";
    private String currencySearchName = "";
    private String currencySearchActiveStatus="true";
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
    
    @Action("currency-data")
    public String findData() {
        try {
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            ListPaging <CurrencyTemp> listPaging = currencyBLL.findData(currencySearchCode,currencySearchName,currencySearchActiveStatus,paging);
            
            listCurrencyTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("currency-get-data")
    public String findData1() {
        try {
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            this.currencyTemp = currencyBLL.findData(this.currency.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("currency-get")
    public String findData2() {
        try {
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            this.currencyTemp = currencyBLL.findData(this.currency.getCode(),this.currency.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("currency-authority")
    public String currencyAuthority(){
        try{
            
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(currencyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(currencyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(currencyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("currency-save")
    public String save() {
        try {
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            
    //        currency.setInActiveDate(commonFunction.setDateTime(currencyTemp.getInActiveDateTemp()));
       //     currency.setCreatedDate(commonFunction.setDateTime(currencyTemp.getCreatedDateTemp()));
            
            if(currencyBLL.isExist(this.currency.getCode())){
                this.errorMessage = "CODE "+this.currency.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                currencyBLL.save(this.currency);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.currency.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("currency-update")
    public String update() {
        try {
            CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
//            currency.setInActiveDate(commonFunction.setDateTime(currencyTemp.getInActiveDateTemp()));
       //     currency.setCreatedDate(commonFunction.setDateTime(currencyTemp.getCreatedDateTemp()));
            currencyBLL.update(this.currency);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.currency.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("currency-delete")
    public String delete() {
        try {
           CurrencyBLL currencyBLL = new CurrencyBLL(hbmSession);
            currencyBLL.delete(this.currency.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.currency.getCode();
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

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public CurrencyTemp getCurrencyTemp() {
        return currencyTemp;
    }

    public void setCurrencyTemp(CurrencyTemp currencyTemp) {
        this.currencyTemp = currencyTemp;
    }

    public List<CurrencyTemp> getListCurrencyTemp() {
        return listCurrencyTemp;
    }

    public void setListCurrencyTemp(List<CurrencyTemp> listCurrencyTemp) {
        this.listCurrencyTemp = listCurrencyTemp;
    }

    public String getCurrencySearchCode() {
        return currencySearchCode;
    }

    public void setCurrencySearchCode(String currencySearchCode) {
        this.currencySearchCode = currencySearchCode;
    }

    public String getCurrencySearchName() {
        return currencySearchName;
    }

    public void setCurrencySearchName(String currencySearchName) {
        this.currencySearchName = currencySearchName;
    }

    public String getCurrencySearchActiveStatus() {
        return currencySearchActiveStatus;
    }

    public void setCurrencySearchActiveStatus(String currencySearchActiveStatus) {
        this.currencySearchActiveStatus = currencySearchActiveStatus;
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
