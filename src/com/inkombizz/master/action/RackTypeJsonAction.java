
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

import com.inkombizz.master.bll.RackTypeBLL;
import com.inkombizz.master.model.RackType;
import com.inkombizz.master.model.RackTypeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class RackTypeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private RackType rackType;
    private RackTypeTemp rackTypeTemp;
    private List <RackTypeTemp> listRackTypeTemp;
    private String rackTypeSearchCode = "";
    private String rackTypeSearchName = "";
    private String rackTypeSearchActiveStatus="true";
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
    
    @Action("rackType-data")
    public String findData() {
        try {
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            ListPaging <RackTypeTemp> listPaging = rackTypeBLL.findData(rackTypeSearchCode,rackTypeSearchName,rackTypeSearchActiveStatus,paging);
            
            listRackTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rackType-get-data")
    public String findData1() {
        try {
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            this.rackTypeTemp = rackTypeBLL.findData(this.rackType.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rackType-get")
    public String findData2() {
        try {
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            this.rackTypeTemp = rackTypeBLL.findData(this.rackType.getCode(),this.rackType.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rackType-authority")
    public String rackTypeAuthority(){
        try{
            
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("rackType-save")
    public String save() {
        try {
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            
          rackType.setInActiveDate(commonFunction.setDateTime(rackTypeTemp.getInActiveDateTemp()));
         rackType.setCreatedDate(commonFunction.setDateTime(rackTypeTemp.getCreatedDateTemp()));
            
            if(rackTypeBLL.isExist(this.rackType.getCode())){
                this.errorMessage = "CODE "+this.rackType.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                rackTypeBLL.save(this.rackType);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.rackType.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rackType-update")
    public String update() {
        try {
            RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            rackType.setInActiveDate(commonFunction.setDateTime(rackTypeTemp.getInActiveDateTemp()));
            rackType.setCreatedDate(commonFunction.setDateTime(rackTypeTemp.getCreatedDateTemp()));
            rackTypeBLL.update(this.rackType);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.rackType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rackType-delete")
    public String delete() {
        try {
           RackTypeBLL rackTypeBLL = new RackTypeBLL(hbmSession);
            rackTypeBLL.delete(this.rackType.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.rackType.getCode();
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

    public RackType getRackType() {
        return rackType;
    }

    public void setRackType(RackType rackType) {
        this.rackType = rackType;
    }

    public RackTypeTemp getRackTypeTemp() {
        return rackTypeTemp;
    }

    public void setRackTypeTemp(RackTypeTemp rackTypeTemp) {
        this.rackTypeTemp = rackTypeTemp;
    }

    public List<RackTypeTemp> getListRackTypeTemp() {
        return listRackTypeTemp;
    }

    public void setListRackTypeTemp(List<RackTypeTemp> listRackTypeTemp) {
        this.listRackTypeTemp = listRackTypeTemp;
    }

    public String getRackTypeSearchCode() {
        return rackTypeSearchCode;
    }

    public void setRackTypeSearchCode(String rackTypeSearchCode) {
        this.rackTypeSearchCode = rackTypeSearchCode;
    }

    public String getRackTypeSearchName() {
        return rackTypeSearchName;
    }

    public void setRackTypeSearchName(String rackTypeSearchName) {
        this.rackTypeSearchName = rackTypeSearchName;
    }

    public String getRackTypeSearchActiveStatus() {
        return rackTypeSearchActiveStatus;
    }

    public void setRackTypeSearchActiveStatus(String rackTypeSearchActiveStatus) {
        this.rackTypeSearchActiveStatus = rackTypeSearchActiveStatus;
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
