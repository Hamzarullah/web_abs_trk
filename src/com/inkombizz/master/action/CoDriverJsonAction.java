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
import com.inkombizz.master.bll.CoDriverBLL;
import com.inkombizz.master.model.CoDriver;
import com.inkombizz.master.model.CoDriverTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;

@Result(type = "json")
public class CoDriverJsonAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private String coDriverCode = "";
    private CoDriver coDriver;
    private CoDriver searchCoDriver;
    private List<CoDriver> listCoDriver;
    private CoDriverTemp coDriverTemp;
    private List <CoDriverTemp> listCoDriverTemp;
    private String coDriverSearchCode = "";
    private String coDriverSearchName = "";
    private String coDriverSearchActiveStatus="true";
    private Enum_TriState searchCoDriverStatus = Enum_TriState.YES;
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
    
    private String checkCoDriver(CoDriverBLL coDriverBLL, CoDriver coDriver) throws Exception {
        try{
            List<CoDriver> listDuplicateCoDriver = coDriverBLL.getDuplicateEntry(coDriver.getCode(), coDriver.getName());
            hbmSession.hSession.flush();
            hbmSession.hSession.clear();

            String _messg="";

            for(CoDriver duplicateCoDriver: listDuplicateCoDriver){
                String _err = "";
                if(coDriver.getName().equals(duplicateCoDriver.getName()))
                    _err += "     " + "CoDriver Name : " + coDriver.getName() + " \n";
                
                if(!"".equals(_err)){
                    _messg +="CoDriver Code : " + duplicateCoDriver.getCode() + " \n" + _err +
                             "-------------------------------------------------- \n";
                }
            }
            
            return _messg;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    @Action("co-driver-search")
    public String search() {
        try {
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
            
            if(searchCoDriver == null)
            {
                searchCoDriver = new CoDriver();
                
                searchCoDriver.setCode("");
                searchCoDriver.setName("");
                searchCoDriver.setActiveStatus(true);
            }
            
            ListPaging <CoDriver> listPaging = coDriverBLL.search(paging, searchCoDriver.getCode(),
                                                        searchCoDriver.getName(),
                                                        searchCoDriverStatus);
            
            listCoDriver = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("co-driver-data")
    public String populateData() {
        try {
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
            ListPaging<CoDriver> listPaging = coDriverBLL.get(paging);

            listCoDriver = listPaging.getList();

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
            CoDriverBLL codriverBLL = new CoDriverBLL(hbmSession);
            ListPaging <CoDriverTemp> listPaging = codriverBLL.findData(coDriverSearchCode,coDriverSearchName,coDriverSearchActiveStatus,paging);
            
            listCoDriverTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("co-driver-get")
    public String populateDataForUpdate() {
        try {
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
            this.coDriver = coDriverBLL.get(this.coDriver.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("co-driver-save")
    public String save() {
        try {
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
            
//            if (!BaseSession.loadProgramSession().hasAuthority(CoDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
//            }  
            
            String _messg=checkCoDriver(coDriverBLL, this.coDriver);
            
            if(!"".equals(_messg))
                throw new Exception("Duplicate Entry. Please Check CoDriver Name \n" + _messg);
            if(coDriver.isActiveStatus() == false){
                coDriver.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                coDriver.setInActiveDate(new Date());
            }
            
//            if(coDriver.getInternalExternalStatus().equals("INTERNAL")){
//                coDriver.setAddress(coDriver.getEmployee().getAddress());
//                coDriver.setCity(coDriver.getEmployee().getCity());
//                coDriver.setPhone1(coDriver.getEmployee().getMobileNo1());
//                coDriver.setPhone2(coDriver.getEmployee().getMobileNo2());
//                coDriver.setEmail(coDriver.getEmployee().getEmail());
//            }else{
//                coDriver.setEmployee(null);
//            }
            if (this.coDriver.getEmployee().getCode().equals("")){this.coDriver.setEmployee(null);}
            this.coDriver.setActiveStatus(true);
            coDriverBLL.save(this.coDriver);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.coDriver.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("co-driver-update")
    public String update() {
        try {
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);

            if (!BaseSession.loadProgramSession().hasAuthority(CoDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }             
            
            String _messg=checkCoDriver(coDriverBLL, this.coDriver);

            if(!"".equals(_messg))
            throw new Exception("Duplicate Entry. Please Check CoDriver Name \n" + _messg);

            if(coDriver.isActiveStatus() == false){
                coDriver.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                coDriver.setInActiveDate(new Date());
            }
            
//            if(coDriver.getInternalExternalStatus().equals("INTERNAL")){
//                coDriver.setAddress(coDriver.getEmployee().getAddress());
//                coDriver.setCity(coDriver.getEmployee().getCity());
//                coDriver.setPhone1(coDriver.getEmployee().getMobileNo1());
//                coDriver.setPhone2(coDriver.getEmployee().getMobileNo2());
//                coDriver.setEmail(coDriver.getEmployee().getEmail());
//            }else{
//                coDriver.setEmployee(null);
//            }
            if (this.coDriver.getEmployee().getCode().equals("")){this.coDriver.setEmployee(null);}
            coDriverBLL.update(this.coDriver);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.coDriver.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("co-driver-delete")
    public String delete() {
        try {
                CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
                
                if (!BaseSession.loadProgramSession().hasAuthority(CoDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                    throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
                }                 
                
                coDriverBLL.delete(this.coDriver.getCode());
            
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.coDriver.getCode();
                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("co-driver-authority")
    public String coDriverAuthority(){
        try{
            
            CoDriverBLL coDriverBLL = new CoDriverBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(coDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(coDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(coDriverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    public CoDriver getCoDriver() {
        return coDriver;
    }
    public void setCoDriver(CoDriver coDriver) {
        this.coDriver = coDriver;
    }

    public String getCoDriverCode() {
        return coDriverCode;
    }
    public void setCoDriverCode(String coDriverCode) {
        this.coDriverCode = coDriverCode;
    }
    
    public List<CoDriver> getListCoDriver() {
        return listCoDriver;
    }
    public void setListCoDriver(List<CoDriver> listCoDriver) {
        this.listCoDriver = listCoDriver;
    }

    public CoDriver getSearchCoDriver() {
        return searchCoDriver;
    }
    public void setSearchCoDriver(CoDriver searchCoDriver) {
        this.searchCoDriver = searchCoDriver;
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

    public Enum_TriState getSearchCoDriverStatus() {
        return searchCoDriverStatus;
    }

    public void setSearchCoDriverStatus(Enum_TriState searchCoDriverStatus) {
        this.searchCoDriverStatus = searchCoDriverStatus;
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

    public CoDriverTemp getCoDriverTemp() {
        return coDriverTemp;
    }

    public void setCoDriverTemp(CoDriverTemp coDriverTemp) {
        this.coDriverTemp = coDriverTemp;
    }

    public List<CoDriverTemp> getListCoDriverTemp() {
        return listCoDriverTemp;
    }

    public void setListCoDriverTemp(List<CoDriverTemp> listCoDriverTemp) {
        this.listCoDriverTemp = listCoDriverTemp;
    }

    public String getCoDriverSearchCode() {
        return coDriverSearchCode;
    }

    public void setCoDriverSearchCode(String coDriverSearchCode) {
        this.coDriverSearchCode = coDriverSearchCode;
    }

    public String getCoDriverSearchName() {
        return coDriverSearchName;
    }

    public void setCoDriverSearchName(String coDriverSearchName) {
        this.coDriverSearchName = coDriverSearchName;
    }

    public String getCoDriverSearchActiveStatus() {
        return coDriverSearchActiveStatus;
    }

    public void setCoDriverSearchActiveStatus(String coDriverSearchActiveStatus) {
        this.coDriverSearchActiveStatus = coDriverSearchActiveStatus;
    }
    
    
}