
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

import com.inkombizz.master.bll.CountryBLL;
import com.inkombizz.master.model.Country;
import com.inkombizz.master.model.CountryTemp;


@Result (type="json")
public class CountryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Country country;
    private CountryTemp countryTemp;
    private List <CountryTemp> listCountryTemp;
    private String countrySearchCode = "";
    private String countrySearchName = "";
    private String countrySearchActiveStatus="true";
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
    
    @Action("country-data")
    public String findData() {
        try {
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            ListPaging <CountryTemp> listPaging = countryBLL.findData(countrySearchCode,countrySearchName,countrySearchActiveStatus,paging);
            
            listCountryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("country-get-data")
    public String findData1() {
        try {
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            this.countryTemp = countryBLL.findData(this.country.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("country-get")
    public String findData2() {
        try {
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            this.countryTemp = countryBLL.findData(this.country.getCode(),this.country.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("country-authority")
    public String countryAuthority(){
        try{
            
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(countryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(countryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(countryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("country-save")
    public String save() {
        try {
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            
            country.setInActiveDate(commonFunction.setDateTime(countryTemp.getInActiveDateTemp()));
            country.setCreatedDate(commonFunction.setDateTime(countryTemp.getCreatedDateTemp()));
            
            if(countryBLL.isExist(this.country.getCode())){
                this.errorMessage = "CODE "+this.country.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                countryBLL.save(this.country);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.country.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("country-update")
    public String update() {
        try {
            CountryBLL countryBLL = new CountryBLL(hbmSession);
            country.setInActiveDate(commonFunction.setDateTime(countryTemp.getInActiveDateTemp()));
            country.setCreatedDate(commonFunction.setDateTime(countryTemp.getCreatedDateTemp()));
            countryBLL.update(this.country);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.country.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("country-delete")
    public String delete() {
        try {
           CountryBLL countryBLL = new CountryBLL(hbmSession);
            countryBLL.delete(this.country.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.country.getCode();
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

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public CountryTemp getCountryTemp() {
        return countryTemp;
    }

    public void setCountryTemp(CountryTemp countryTemp) {
        this.countryTemp = countryTemp;
    }

    public List<CountryTemp> getListCountryTemp() {
        return listCountryTemp;
    }

    public void setListCountryTemp(List<CountryTemp> listCountryTemp) {
        this.listCountryTemp = listCountryTemp;
    }

    public String getCountrySearchCode() {
        return countrySearchCode;
    }

    public void setCountrySearchCode(String countrySearchCode) {
        this.countrySearchCode = countrySearchCode;
    }

    public String getCountrySearchName() {
        return countrySearchName;
    }

    public void setCountrySearchName(String countrySearchName) {
        this.countrySearchName = countrySearchName;
    }

    public String getCountrySearchActiveStatus() {
        return countrySearchActiveStatus;
    }

    public void setCountrySearchActiveStatus(String countrySearchActiveStatus) {
        this.countrySearchActiveStatus = countrySearchActiveStatus;
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
