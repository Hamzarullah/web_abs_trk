
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

import com.inkombizz.master.bll.DcasLegalRequirementsBLL;
import com.inkombizz.master.model.DcasLegalRequirements;
import com.inkombizz.master.model.DcasLegalRequirementsTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class DcasLegalRequirementsJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private DcasLegalRequirements dcasLegalRequirements;
    private DcasLegalRequirementsTemp dcasLegalRequirementsTemp;
    private List<DcasLegalRequirementsTemp> listDcasLegalRequirementsTemp;
    private String dcasLegalRequirementsSearchCode = "";
    private String dcasLegalRequirementsSearchName = "";
    private String dcasLegalRequirementsSearchActiveStatus="true";
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
    
    @Action("dcas-legal-requirements-data")
    public String findData() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            ListPaging <DcasLegalRequirementsTemp> listPaging = dcasLegalRequirementsBLL.findData(dcasLegalRequirementsSearchCode,dcasLegalRequirementsSearchName,dcasLegalRequirementsSearchActiveStatus,paging);
            
            listDcasLegalRequirementsTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-legal-requirements-get-data")
    public String findData1() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            this.dcasLegalRequirementsTemp = dcasLegalRequirementsBLL.findData(this.dcasLegalRequirements.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-legal-requirements-get")
    public String findData2() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            this.dcasLegalRequirementsTemp = dcasLegalRequirementsBLL.findData(this.dcasLegalRequirements.getCode(),this.dcasLegalRequirements.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-legal-requirements-authority")
    public String dcasLegalRequirementsAuthority(){
        try{
            
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasLegalRequirementsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasLegalRequirementsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(dcasLegalRequirementsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("dcas-legal-requirements-save")
    public String save() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            
          dcasLegalRequirements.setInActiveDate(commonFunction.setDateTime(dcasLegalRequirementsTemp.getInActiveDateTemp()));
         dcasLegalRequirements.setCreatedDate(commonFunction.setDateTime(dcasLegalRequirementsTemp.getCreatedDateTemp()));
            
            if(dcasLegalRequirementsBLL.isExist(this.dcasLegalRequirements.getCode())){
                this.errorMessage = "CODE "+this.dcasLegalRequirements.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                dcasLegalRequirementsBLL.save(this.dcasLegalRequirements);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.dcasLegalRequirements.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-legal-requirements-update")
    public String update() {
        try {
            DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            dcasLegalRequirements.setInActiveDate(commonFunction.setDateTime(dcasLegalRequirementsTemp.getInActiveDateTemp()));
            dcasLegalRequirements.setCreatedDate(commonFunction.setDateTime(dcasLegalRequirementsTemp.getCreatedDateTemp()));
            dcasLegalRequirementsBLL.update(this.dcasLegalRequirements);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.dcasLegalRequirements.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("dcas-legal-requirements-delete")
    public String delete() {
        try {
           DcasLegalRequirementsBLL dcasLegalRequirementsBLL = new DcasLegalRequirementsBLL(hbmSession);
            dcasLegalRequirementsBLL.delete(this.dcasLegalRequirements.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.dcasLegalRequirements.getCode();
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

    public DcasLegalRequirements getDcasLegalRequirements() {
        return dcasLegalRequirements;
    }

    public void setDcasLegalRequirements(DcasLegalRequirements dcasLegalRequirements) {
        this.dcasLegalRequirements = dcasLegalRequirements;
    }

    public DcasLegalRequirementsTemp getDcasLegalRequirementsTemp() {
        return dcasLegalRequirementsTemp;
    }

    public void setDcasLegalRequirementsTemp(DcasLegalRequirementsTemp dcasLegalRequirementsTemp) {
        this.dcasLegalRequirementsTemp = dcasLegalRequirementsTemp;
    }

    public List<DcasLegalRequirementsTemp> getListDcasLegalRequirementsTemp() {
        return listDcasLegalRequirementsTemp;
    }

    public void setListDcasLegalRequirementsTemp(List<DcasLegalRequirementsTemp> listDcasLegalRequirementsTemp) {
        this.listDcasLegalRequirementsTemp = listDcasLegalRequirementsTemp;
    }

    public String getDcasLegalRequirementsSearchCode() {
        return dcasLegalRequirementsSearchCode;
    }

    public void setDcasLegalRequirementsSearchCode(String dcasLegalRequirementsSearchCode) {
        this.dcasLegalRequirementsSearchCode = dcasLegalRequirementsSearchCode;
    }

    public String getDcasLegalRequirementsSearchName() {
        return dcasLegalRequirementsSearchName;
    }

    public void setDcasLegalRequirementsSearchName(String dcasLegalRequirementsSearchName) {
        this.dcasLegalRequirementsSearchName = dcasLegalRequirementsSearchName;
    }

    public String getDcasLegalRequirementsSearchActiveStatus() {
        return dcasLegalRequirementsSearchActiveStatus;
    }

    public void setDcasLegalRequirementsSearchActiveStatus(String dcasLegalRequirementsSearchActiveStatus) {
        this.dcasLegalRequirementsSearchActiveStatus = dcasLegalRequirementsSearchActiveStatus;
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
