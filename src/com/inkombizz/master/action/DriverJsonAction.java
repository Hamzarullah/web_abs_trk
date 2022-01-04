package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.DriverBLL;
import com.inkombizz.master.model.Driver;
import com.inkombizz.master.model.DriverTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;

@Result(type = "json")
public class DriverJsonAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private String driverCode = "";
    private Driver driver;
    private Driver searchDriver;
    private List<Driver> listDriver;
    private DriverTemp driverTemp;
    private List <DriverTemp> listDriverTemp;
    private String driverSearchCode = "";
    private String driverSearchName = "";
    private String driverSearchActiveStatus="true";
    private Enum_TriState searchDriverStatus = Enum_TriState.YES;
    private String actionAuthority="";
    

    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    private String checkDriver(DriverBLL driverBLL, Driver driver) throws Exception {
        try{
            List<Driver> listDuplicateDriver = driverBLL.getDuplicateEntry(driver.getCode(), driver.getName());
            hbmSession.hSession.flush();
            hbmSession.hSession.clear();

            String _messg="";

            for(Driver duplicateDriver: listDuplicateDriver){
                String _err = "";
                if(driver.getName().equals(duplicateDriver.getName()))
                    _err += "     " + "Driver Name : " + driver.getName() + " \n";
                
                if(!"".equals(_err)){
                    _messg +="Driver Code : " + duplicateDriver.getCode() + " \n" + _err +
                             "-------------------------------------------------- \n";
                }
            }
            
            return _messg;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    @Action("driver-search")
    public String search() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            
            if(searchDriver == null)
            {
                searchDriver = new Driver();
                
                searchDriver.setCode("");
                searchDriver.setName("");
                searchDriver.setActiveStatus(true);
            }
            
            ListPaging <Driver> listPaging = driverBLL.search(paging, searchDriver.getCode(),
                                                        searchDriver.getName(),
                                                        searchDriverStatus);
            
            listDriver = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("driver-data")
    public String populateData() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            ListPaging<Driver> listPaging = driverBLL.get(paging);

            listDriver = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("codriver-data")
    public String findData() {
        try {
            DriverBLL codriverBLL = new DriverBLL(hbmSession);
            ListPaging <DriverTemp> listPaging = codriverBLL.findData(driverSearchCode,driverSearchName,driverSearchActiveStatus,paging);
            
            listDriverTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("driver-get")
    public String populateDataForUpdate() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            this.driver = driverBLL.get(this.driver.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("driver-save")
    public String save() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            
//            if (!BaseSession.loadProgramSession().hasAuthority(DriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
//            }  
            
            String _messg=checkDriver(driverBLL, this.driver);
            
            if(!"".equals(_messg))
                throw new Exception("Duplicate Entry. Please Check Driver Name \n" + _messg);
            if(driver.isActiveStatus() == false){
                driver.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                driver.setInActiveDate(new Date());
            }
            
//            if(driver.getInternalExternalStatus().equals("INTERNAL")){
//                driver.setAddress(driver.getEmployee().getAddress());
//                driver.setCity(driver.getEmployee().getCity());
//                driver.setPhone1(driver.getEmployee().getMobileNo1());
//                driver.setPhone2(driver.getEmployee().getMobileNo2());
//                driver.setEmail(driver.getEmployee().getEmail());
//            }else{
//                driver.setEmployee(null);
//            }
            if (this.driver.getEmployee().getCode().equals("")){this.driver.setEmployee(null);}
            this.driver.setActiveStatus(true);
            driverBLL.save(this.driver);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.driver.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("driver-update")
    public String update() {
        try {
            DriverBLL driverBLL = new DriverBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(DriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }             
            
            String _messg=checkDriver(driverBLL, this.driver);

            if(!"".equals(_messg))
            throw new Exception("Duplicate Entry. Please Check Driver Name \n" + _messg);

            if(driver.isActiveStatus() == false){
                driver.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                driver.setInActiveDate(new Date());
            }
            
//            if(driver.getInternalExternalStatus().equals("INTERNAL")){
//                driver.setAddress(driver.getEmployee().getAddress());
//                driver.setCity(driver.getEmployee().getCity());
//                driver.setPhone1(driver.getEmployee().getMobileNo1());
//                driver.setPhone2(driver.getEmployee().getMobileNo2());
//                driver.setEmail(driver.getEmployee().getEmail());
//            }else{
//                driver.setEmployee(null);
//            }
            if (this.driver.getEmployee().getCode().equals("")){this.driver.setEmployee(null);}
            driverBLL.update(this.driver);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.driver.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("driver-delete")
    public String delete() {
        try {
                DriverBLL driverBLL = new DriverBLL(hbmSession);
                
                if (!BaseSession.loadProgramSession().hasAuthority(DriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                    throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
                }                 
                
                driverBLL.delete(this.driver.getCode());
            
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.driver.getCode();
                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("driver-authority")
    public String driverAuthority(){
        try{
            
            DriverBLL driverBLL = new DriverBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(driverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(driverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(driverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    public Driver getDriver() {
        return driver;
    }
    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    public String getDriverCode() {
        return driverCode;
    }
    public void setDriverCode(String driverCode) {
        this.driverCode = driverCode;
    }
    
    public List<Driver> getListDriver() {
        return listDriver;
    }
    public void setListDriver(List<Driver> listDriver) {
        this.listDriver = listDriver;
    }

    public Driver getSearchDriver() {
        return searchDriver;
    }
    public void setSearchDriver(Driver searchDriver) {
        this.searchDriver = searchDriver;
    }
    
    Paging paging = new Paging();

    public int getRows() {
        return paging.getRows();
    }
    public void setRows(int rows) {
        paging.setRows(rows);
    }

    public int getPage() {
        return paging.getPage();
    }
    public void setPage(int page) {
        paging.setPage(page);
    }

    public int getTotal() {
        return paging.getTotal();
    }
    public void setTotal(int total) {
        paging.setTotal(total);
    }

    public int getRecords() {
        return paging.getRecords();
    }
    public void setRecords(int records) {
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

    public Enum_TriState getSearchDriverStatus() {
        return searchDriverStatus;
    }

    public void setSearchDriverStatus(Enum_TriState searchDriverStatus) {
        this.searchDriverStatus = searchDriverStatus;
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

    public DriverTemp getDriverTemp() {
        return driverTemp;
    }

    public void setDriverTemp(DriverTemp driverTemp) {
        this.driverTemp = driverTemp;
    }

    public List<DriverTemp> getListDriverTemp() {
        return listDriverTemp;
    }

    public void setListDriverTemp(List<DriverTemp> listDriverTemp) {
        this.listDriverTemp = listDriverTemp;
    }

    public String getDriverSearchCode() {
        return driverSearchCode;
    }

    public void setDriverSearchCode(String driverSearchCode) {
        this.driverSearchCode = driverSearchCode;
    }

    public String getDriverSearchName() {
        return driverSearchName;
    }

    public void setDriverSearchName(String driverSearchName) {
        this.driverSearchName = driverSearchName;
    }

    public String getDriverSearchActiveStatus() {
        return driverSearchActiveStatus;
    }

    public void setDriverSearchActiveStatus(String driverSearchActiveStatus) {
        this.driverSearchActiveStatus = driverSearchActiveStatus;
    }
    
    
}