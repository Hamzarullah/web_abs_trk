
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.DivisionBLL;
import com.inkombizz.master.model.Division;
import com.inkombizz.master.model.DivisionTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type = "json")
public class DivisionJsonAction extends ActionSupport {
    
    protected HBMSession hbmSession = new HBMSession();
    
    private static final long serialVersionUID = 1L;
    
    private Division division;
    private Division searchDivision;
    private List<Division> listDivision;
     private List <DivisionTemp> listDivisionTemp;
    private String divisionSearchCode = "";
    private String divisionSearchName = "";
    private String divisionSearchCodeConcat = "";
    private String divisionSearchActiveStatus = "Active";
    private String actionAuthority="";
    private DivisionTemp divisionTemp;

    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("division-search-data")
    public String findData() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            ListPaging<DivisionTemp> listPaging = divisionBLL.findSearchData(paging,divisionSearchCode,divisionSearchName,divisionSearchActiveStatus);
            
            listDivisionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("division-search-data-with-user-auth")
    public String findDataAuthUser() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            ListPaging<DivisionTemp> listPaging = divisionBLL.findSearchDataWithUserAuth(paging,divisionSearchCode,divisionSearchName,divisionSearchActiveStatus);
            
            listDivisionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("division-search")
    public String search() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            
            if(searchDivision == null)
            {
                searchDivision = new Division();
                
                searchDivision.setCode("");
                searchDivision.setName("");
            }
            
            ListPaging <Division> listPaging = divisionBLL.search(paging, searchDivision.getCode(), searchDivision.getName(), EnumTriState.Enum_TriState.YES);
            
            listDivision = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("division-data")
    public String populateData() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            ListPaging<Division> listPaging = divisionBLL.get(paging);
            listDivision = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("division-get-data")
    public String findData1() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            this.divisionTemp = divisionBLL.findData(this.division.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("division-get")
    public String findData2() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            this.divisionTemp = divisionBLL.findData(this.division.getCode(),this.division.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("division-get-with-user-auth")
    public String findData2UserAuth() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            this.divisionTemp = divisionBLL.findDataWithUserAuth(this.division.getCode(),this.division.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("division-save")
    public String save() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }              
            
            if(division.isActiveStatus() == false){
                division.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                division.setInActiveDate(new Date());
            }
            divisionBLL.save(this.division);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.division.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("division-update")
    public String update() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }            
            
             if(division.isActiveStatus() == false){
                division.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                division.setInActiveDate(new Date());
            }
            
            divisionBLL.update(this.division);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.division.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("division-delete")
    public String delete() {
        try {
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            divisionBLL.delete(this.division.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.division.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("division-authority")
    public String divisionAuthority(){
        try{
            
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(divisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(divisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(divisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("division-search-data-with-array")
    public String polulateSearchDataWithArray(){
        try{
            
            DivisionBLL divisionBLL = new DivisionBLL(hbmSession);
            ListPaging<DivisionTemp> listPaging = divisionBLL.polulateSearchDataWithArray(divisionSearchCode, divisionSearchName, divisionSearchCodeConcat, paging); 
            
            listDivisionTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Division getDivision() {
        return division;
    }

    public void setDivision(Division division) {
        this.division = division;
    }

    public Division getSearchDivision() {
        return searchDivision;
    }

    public void setSearchDivision(Division searchDivision) {
        this.searchDivision = searchDivision;
    }

    public List<Division> getListDivision() {
        return listDivision;
    }

    public void setListDivision(List<Division> listDivision) {
        this.listDivision = listDivision;
    }

    public List<DivisionTemp> getListDivisionTemp() {
        return listDivisionTemp;
    }

    public void setListDivisionTemp(List<DivisionTemp> listDivisionTemp) {
        this.listDivisionTemp = listDivisionTemp;
    }

    public String getDivisionSearchCode() {
        return divisionSearchCode;
    }

    public void setDivisionSearchCode(String divisionSearchCode) {
        this.divisionSearchCode = divisionSearchCode;
    }

    public String getDivisionSearchName() {
        return divisionSearchName;
    }

    public void setDivisionSearchName(String divisionSearchName) {
        this.divisionSearchName = divisionSearchName;
    }

    public String getDivisionSearchCodeConcat() {
        return divisionSearchCodeConcat;
    }

    public void setDivisionSearchCodeConcat(String divisionSearchCodeConcat) {
        this.divisionSearchCodeConcat = divisionSearchCodeConcat;
    }

    public String getDivisionSearchActiveStatus() {
        return divisionSearchActiveStatus;
    }

    public void setDivisionSearchActiveStatus(String divisionSearchActiveStatus) {
        this.divisionSearchActiveStatus = divisionSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public DivisionTemp getDivisionTemp() {
        return divisionTemp;
    }

    public void setDivisionTemp(DivisionTemp divisionTemp) {
        this.divisionTemp = divisionTemp;
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