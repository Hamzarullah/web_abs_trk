
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

import com.inkombizz.master.bll.ValveTypeBLL;
import com.inkombizz.master.model.ValveType;
import com.inkombizz.master.model.ValveTypeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ValveTypeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ValveType valveType;
    private ValveTypeTemp valveTypeTemp;
    private List<ValveTypeTemp> listValveTypeTemp;
    private String valveTypeSearchCode = "";
    private String valveTypeSearchName = "";
    private String valveTypeSearchActiveStatus="true";
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
    
    @Action("valve-type-data")
    public String findData() {
        try {
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            ListPaging <ValveTypeTemp> listPaging = valveTypeBLL.findData(valveTypeSearchCode,valveTypeSearchName,valveTypeSearchActiveStatus,paging);
            
            listValveTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-get-data")
    public String findData1() {
        try {
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            this.valveTypeTemp = valveTypeBLL.findData(this.valveType.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-get")
    public String findData2() {
        try {
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            this.valveTypeTemp = valveTypeBLL.findData(this.valveType.getCode(),this.valveType.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-authority")
    public String valveTypeAuthority(){
        try{
            
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("valve-type-save")
    public String save() {
        try {
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            
          valveType.setInActiveDate(commonFunction.setDateTime(valveTypeTemp.getInActiveDateTemp()));
         valveType.setCreatedDate(commonFunction.setDateTime(valveTypeTemp.getCreatedDateTemp()));
            
            if(valveTypeBLL.isExist(this.valveType.getCode())){
                this.errorMessage = "CODE "+this.valveType.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                valveTypeBLL.save(this.valveType);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.valveType.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-update")
    public String update() {
        try {
            ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            valveType.setInActiveDate(commonFunction.setDateTime(valveTypeTemp.getInActiveDateTemp()));
            valveType.setCreatedDate(commonFunction.setDateTime(valveTypeTemp.getCreatedDateTemp()));
            valveTypeBLL.update(this.valveType);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.valveType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-delete")
    public String delete() {
        try {
           ValveTypeBLL valveTypeBLL = new ValveTypeBLL(hbmSession);
            valveTypeBLL.delete(this.valveType.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.valveType.getCode();
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

    public ValveType getValveType() {
        return valveType;
    }

    public void setValveType(ValveType valveType) {
        this.valveType = valveType;
    }

    public ValveTypeTemp getValveTypeTemp() {
        return valveTypeTemp;
    }

    public void setValveTypeTemp(ValveTypeTemp valveTypeTemp) {
        this.valveTypeTemp = valveTypeTemp;
    }

    public List<ValveTypeTemp> getListValveTypeTemp() {
        return listValveTypeTemp;
    }

    public void setListValveTypeTemp(List<ValveTypeTemp> listValveTypeTemp) {
        this.listValveTypeTemp = listValveTypeTemp;
    }

    public String getValveTypeSearchCode() {
        return valveTypeSearchCode;
    }

    public void setValveTypeSearchCode(String valveTypeSearchCode) {
        this.valveTypeSearchCode = valveTypeSearchCode;
    }

    public String getValveTypeSearchName() {
        return valveTypeSearchName;
    }

    public void setValveTypeSearchName(String valveTypeSearchName) {
        this.valveTypeSearchName = valveTypeSearchName;
    }

    public String getValveTypeSearchActiveStatus() {
        return valveTypeSearchActiveStatus;
    }

    public void setValveTypeSearchActiveStatus(String valveTypeSearchActiveStatus) {
        this.valveTypeSearchActiveStatus = valveTypeSearchActiveStatus;
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
