package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.bll.PriceTypeBLL;
import com.inkombizz.master.model.PriceType;
import com.inkombizz.master.model.PriceTypeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;

@Result(type = "json")
public class PriceTypeJsonAction extends ActionSupport {
    
    protected HBMSession hbmSession = new HBMSession();
    
    private static final long serialVersionUID = 1L;
    
    private PriceType priceType;
    private PriceType searchPriceType;
    private List<PriceType> listPriceType;
     private List <PriceTypeTemp> listPriceTypeTemp;
    private String priceTypeSearchCode = "";
    private String priceTypeSearchName = "";
    private String priceTypeSearchActiveStatus = "Active";
    private String actionAuthority="";

    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("price-type-search-data")
    public String findData() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            ListPaging<PriceTypeTemp> listPaging = priceTypeBLL.findSearchData(paging,priceTypeSearchCode,priceTypeSearchName,priceTypeSearchActiveStatus);
            
            listPriceTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("price-type-search")
    public String search() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            
            if(searchPriceType == null)
            {
                searchPriceType = new PriceType();
                
                searchPriceType.setCode("");
                searchPriceType.setName("");
            }
            
            ListPaging <PriceType> listPaging = priceTypeBLL.search(paging, searchPriceType.getCode(), searchPriceType.getName(), Enum_TriState.YES);
            
            listPriceType = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("price-type-data")
    public String populateData() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            ListPaging<PriceType> listPaging = priceTypeBLL.get(paging);
            listPriceType = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("price-type-get")
    public String populateDataForUpdate() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            this.priceType = priceTypeBLL.get(this.priceType.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("price-type-save")
    public String save() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(PriceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }              
            
            if(priceType.isActiveStatus() == false){
                priceType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                priceType.setInActiveDate(new Date());
            }
            priceTypeBLL.save(this.priceType);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.priceType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("price-type-update")
    public String update() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(PriceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }            
            
             if(priceType.isActiveStatus() == false){
                priceType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                priceType.setInActiveDate(new Date());
            }
            
            priceTypeBLL.update(this.priceType);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.priceType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("price-type-delete")
    public String delete() {
        try {
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(PriceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            priceTypeBLL.delete(this.priceType.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.priceType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("price-type-authority")
    public String priceTypeAuthority(){
        try{
            
            PriceTypeBLL priceTypeBLL = new PriceTypeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(priceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(priceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(priceTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    public PriceType getPriceType() {
        return priceType;
    }
    public void setPriceType(PriceType priceType) {
        this.priceType = priceType;
    }
	
    public List<PriceType> getListPriceType() {
        return listPriceType;
    }
    public void setListPriceType(List<PriceType> listPriceType) {
        this.listPriceType = listPriceType;
    }

    public PriceType getSearchPriceType() {
        return searchPriceType;
    }
    public void setSearchPriceType(PriceType searchPriceType) {
        this.searchPriceType = searchPriceType;
    }   
	
    Paging paging = new Paging();

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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public List<PriceTypeTemp> getListPriceTypeTemp() {
        return listPriceTypeTemp;
    }

    public void setListPriceTypeTemp(List<PriceTypeTemp> listPriceTypeTemp) {
        this.listPriceTypeTemp = listPriceTypeTemp;
    }

    public String getPriceTypeSearchCode() {
        return priceTypeSearchCode;
    }

    public void setPriceTypeSearchCode(String priceTypeSearchCode) {
        this.priceTypeSearchCode = priceTypeSearchCode;
    }

    public String getPriceTypeSearchName() {
        return priceTypeSearchName;
    }

    public void setPriceTypeSearchName(String priceTypeSearchName) {
        this.priceTypeSearchName = priceTypeSearchName;
    }

    public String getPriceTypeSearchActiveStatus() {
        return priceTypeSearchActiveStatus;
    }

    public void setPriceTypeSearchActiveStatus(String priceTypeSearchActiveStatus) {
        this.priceTypeSearchActiveStatus = priceTypeSearchActiveStatus;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }
    
}