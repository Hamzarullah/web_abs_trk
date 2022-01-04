
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.EmployeeBLL;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.EmployeeBLL;
import com.inkombizz.master.model.Employee;
import com.inkombizz.master.model.EmployeeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result(type = "json")
public class EmployeeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Employee employee;
    private EmployeeTemp employeeTemp;
    private List <EmployeeTemp> listEmployeeTemp;
    private String listEmployeeJnLocationJSON;
    private String listEmployeeJnDivisionJSON;
    private String listEmployeeJnClassJSON;
    private String listEmployeeJnInsuranceJSON;
    
    private String employeeSearchCode = "";
    private String employeeSearchName = "";
    private String employeeSearchActiveStatus="true";
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
    
    @Action("employee-data")
    public String findData() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            ListPaging <EmployeeTemp> listPaging = employeeBLL.findData(employeeSearchCode,employeeSearchName,employeeSearchActiveStatus,paging);
            
            listEmployeeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("employee-get")
    public String findData2() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            this.employeeTemp = employeeBLL.findData(this.employee.getCode(),this.employee.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("employee-get-data")
    public String findData1() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            this.employeeTemp = employeeBLL.findData(this.employee.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("employee-authority")
    public String employeeAuthority(){
        try{
            
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(EmployeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(EmployeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(EmployeeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
   @Action("employee-save")
    public String save() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            
            employee.setInActiveDate(commonFunction.setDateTime(employeeTemp.getInActiveDateTemp()));
            employee.setCreatedDate(commonFunction.setDateTime(employeeTemp.getCreatedDateTemp()));
            if(employeeBLL.isExist(this.employee.getCode())){
                this.errorMessage = "Code "+this.employee.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                employeeBLL.save(this.employee);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.employee.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("employee-update")
    public String update() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            
            employee.setInActiveDate(commonFunction.setDateTime(employeeTemp.getInActiveDateTemp()));
            employee.setCreatedDate(commonFunction.setDateTime(employeeTemp.getCreatedDateTemp()));
            employeeBLL.update(this.employee);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.employee.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("employee-delete")
    public String delete() {
        try {
            EmployeeBLL employeeBLL = new EmployeeBLL(hbmSession);
            
            employeeBLL.delete(this.employee.getCode());
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.employee.getCode();
            
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

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public EmployeeTemp getEmployeeTemp() {
        return employeeTemp;
    }

    public void setEmployeeTemp(EmployeeTemp employeeTemp) {
        this.employeeTemp = employeeTemp;
    }

    public List<EmployeeTemp> getListEmployeeTemp() {
        return listEmployeeTemp;
    }

    public void setListEmployeeTemp(List<EmployeeTemp> listEmployeeTemp) {
        this.listEmployeeTemp = listEmployeeTemp;
    }

    public String getListEmployeeJnLocationJSON() {
        return listEmployeeJnLocationJSON;
    }

    public void setListEmployeeJnLocationJSON(String listEmployeeJnLocationJSON) {
        this.listEmployeeJnLocationJSON = listEmployeeJnLocationJSON;
    }

    public String getListEmployeeJnDivisionJSON() {
        return listEmployeeJnDivisionJSON;
    }

    public void setListEmployeeJnDivisionJSON(String listEmployeeJnDivisionJSON) {
        this.listEmployeeJnDivisionJSON = listEmployeeJnDivisionJSON;
    }

    public String getListEmployeeJnClassJSON() {
        return listEmployeeJnClassJSON;
    }

    public void setListEmployeeJnClassJSON(String listEmployeeJnClassJSON) {
        this.listEmployeeJnClassJSON = listEmployeeJnClassJSON;
    }

    public String getListEmployeeJnInsuranceJSON() {
        return listEmployeeJnInsuranceJSON;
    }

    public void setListEmployeeJnInsuranceJSON(String listEmployeeJnInsuranceJSON) {
        this.listEmployeeJnInsuranceJSON = listEmployeeJnInsuranceJSON;
    }

    public String getEmployeeSearchCode() {
        return employeeSearchCode;
    }

    public void setEmployeeSearchCode(String employeeSearchCode) {
        this.employeeSearchCode = employeeSearchCode;
    }

    public String getEmployeeSearchName() {
        return employeeSearchName;
    }

    public void setEmployeeSearchName(String employeeSearchName) {
        this.employeeSearchName = employeeSearchName;
    }

    public String getEmployeeSearchActiveStatus() {
        return employeeSearchActiveStatus;
    }

    public void setEmployeeSearchActiveStatus(String employeeSearchActiveStatus) {
        this.employeeSearchActiveStatus = employeeSearchActiveStatus;
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
