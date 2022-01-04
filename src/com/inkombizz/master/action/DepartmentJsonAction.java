/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.DepartmentBLL;
import com.inkombizz.master.model.Department;
import com.inkombizz.master.model.DepartmentTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author Rayis
 */
@Result(type = "json")
public class DepartmentJsonAction extends ActionSupport {
    
    protected HBMSession hbmSession = new HBMSession();
    
    private static final long serialVersionUID = 1L;
    
    private Department department;
    private Department searchDepartment;
    private List<Department> listDepartment;
     private List <DepartmentTemp> listDepartmentTemp;
    private String departmentSearchCode = "";
    private String departmentSearchName = "";
    private String departmentSearchCodeConcat = "";
    private String departmentSearchActiveStatus = "Active";
    private String actionAuthority="";
    private DepartmentTemp departmentTemp;

    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("department-search-data")
    public String findData() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            ListPaging<DepartmentTemp> listPaging = departmentBLL.findSearchData(paging,departmentSearchCode,departmentSearchName,departmentSearchActiveStatus);
            
            listDepartmentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("department-search")
    public String search() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            
            if(searchDepartment == null)
            {
                searchDepartment = new Department();
                
                searchDepartment.setCode("");
                searchDepartment.setName("");
            }
            
            ListPaging <Department> listPaging = departmentBLL.search(paging, searchDepartment.getCode(), searchDepartment.getName(), EnumTriState.Enum_TriState.YES);
            
            listDepartment = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("department-data")
    public String populateData() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            ListPaging<Department> listPaging = departmentBLL.get(paging);
            listDepartment = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("department-get-data")
    public String findData1() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            this.departmentTemp = departmentBLL.findData(this.department.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("department-get")
    public String findData2() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            this.departmentTemp = departmentBLL.findData(this.department.getCode(),this.department.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("department-save")
    public String save() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DepartmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }              
            
            if(department.isActiveStatus() == false){
                department.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                department.setInActiveDate(new Date());
            }
            departmentBLL.save(this.department);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.department.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("department-update")
    public String update() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DepartmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }            
            
             if(department.isActiveStatus() == false){
                department.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                department.setInActiveDate(new Date());
            }
            
            departmentBLL.update(this.department);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.department.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("department-delete")
    public String delete() {
        try {
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DepartmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            departmentBLL.delete(this.department.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.department.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("department-authority")
    public String departmentAuthority(){
        try{
            
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(departmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(departmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(departmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("department-search-data-with-array")
    public String polulateSearchDataWithArray(){
        try{
            
            DepartmentBLL departmentBLL = new DepartmentBLL(hbmSession);
            ListPaging<DepartmentTemp> listPaging = departmentBLL.polulateSearchDataWithArray(departmentSearchCode, departmentSearchName, departmentSearchCodeConcat, paging); 
            
            listDepartmentTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
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
    
    public Department getDepartment() {
        return department;
    }
    public void setDepartment(Department department) {
        this.department = department;
    }
	
    public List<Department> getListDepartment() {
        return listDepartment;
    }
    public void setListDepartment(List<Department> listDepartment) {
        this.listDepartment = listDepartment;
    }

    public Department getSearchDepartment() {
        return searchDepartment;
    }
    public void setSearchDepartment(Department searchDepartment) {
        this.searchDepartment = searchDepartment;
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

    public List<DepartmentTemp> getListDepartmentTemp() {
        return listDepartmentTemp;
    }

    public void setListDepartmentTemp(List<DepartmentTemp> listDepartmentTemp) {
        this.listDepartmentTemp = listDepartmentTemp;
    }

    public String getDepartmentSearchCode() {
        return departmentSearchCode;
    }

    public void setDepartmentSearchCode(String departmentSearchCode) {
        this.departmentSearchCode = departmentSearchCode;
    }

    public String getDepartmentSearchName() {
        return departmentSearchName;
    }

    public void setDepartmentSearchName(String departmentSearchName) {
        this.departmentSearchName = departmentSearchName;
    }

    public String getDepartmentSearchActiveStatus() {
        return departmentSearchActiveStatus;
    }

    public void setDepartmentSearchActiveStatus(String departmentSearchActiveStatus) {
        this.departmentSearchActiveStatus = departmentSearchActiveStatus;
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

    public DepartmentTemp getDepartmentTemp() {
        return departmentTemp;
    }

    public void setDepartmentTemp(DepartmentTemp departmentTemp) {
        this.departmentTemp = departmentTemp;
    }

    public String getDepartmentSearchCodeConcat() {
        return departmentSearchCodeConcat;
    }

    public void setDepartmentSearchCodeConcat(String departmentSearchCodeConcat) {
        this.departmentSearchCodeConcat = departmentSearchCodeConcat;
    }
    
}