
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

import com.inkombizz.master.bll.CadDocumentForApprovalBLL;
import com.inkombizz.master.model.CadDocumentForApproval;
import com.inkombizz.master.model.CadDocumentForApprovalTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class CadDocumentForApprovalJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private CadDocumentForApproval cadDocumentForApproval;
    private CadDocumentForApprovalTemp cadDocumentForApprovalTemp;
    private List <CadDocumentForApprovalTemp> listCadDocumentForApprovalTemp;
    private String cadDocumentForApprovalSearchCode = "";
    private String cadDocumentForApprovalSearchName = "";
    private String cadDocumentForApprovalSearchActiveStatus="true";
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
    
    @Action("cad-document-for-approval-data")
    public String findData() {
        try {
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            ListPaging <CadDocumentForApprovalTemp> listPaging = cadDocumentForApprovalBLL.findData(cadDocumentForApprovalSearchCode,cadDocumentForApprovalSearchName,cadDocumentForApprovalSearchActiveStatus,paging);
            
            listCadDocumentForApprovalTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cad-document-for-approval-get-data")
    public String findData1() {
        try {
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            this.cadDocumentForApprovalTemp = cadDocumentForApprovalBLL.findData(this.cadDocumentForApproval.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cad-document-for-approval-get")
    public String findData2() {
        try {
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            this.cadDocumentForApprovalTemp = cadDocumentForApprovalBLL.findData(this.cadDocumentForApproval.getCode(),this.cadDocumentForApproval.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cad-document-for-approval-authority")
    public String cadDocumentForApprovalAuthority(){
        try{
            
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(cadDocumentForApprovalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cadDocumentForApprovalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cadDocumentForApprovalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("cad-document-for-approval-save")
    public String save() {
        try {
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            
          cadDocumentForApproval.setInActiveDate(commonFunction.setDateTime(cadDocumentForApprovalTemp.getInActiveDateTemp()));
         cadDocumentForApproval.setCreatedDate(commonFunction.setDateTime(cadDocumentForApprovalTemp.getCreatedDateTemp()));
            
            if(cadDocumentForApprovalBLL.isExist(this.cadDocumentForApproval.getCode())){
                this.errorMessage = "CODE "+this.cadDocumentForApproval.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                cadDocumentForApprovalBLL.save(this.cadDocumentForApproval);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.cadDocumentForApproval.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cad-document-for-approval-update")
    public String update() {
        try {
            CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            cadDocumentForApproval.setInActiveDate(commonFunction.setDateTime(cadDocumentForApprovalTemp.getInActiveDateTemp()));
            cadDocumentForApproval.setCreatedDate(commonFunction.setDateTime(cadDocumentForApprovalTemp.getCreatedDateTemp()));
            cadDocumentForApprovalBLL.update(this.cadDocumentForApproval);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.cadDocumentForApproval.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("cad-document-for-approval-delete")
    public String delete() {
        try {
           CadDocumentForApprovalBLL cadDocumentForApprovalBLL = new CadDocumentForApprovalBLL(hbmSession);
            cadDocumentForApprovalBLL.delete(this.cadDocumentForApproval.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.cadDocumentForApproval.getCode();
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

    public CadDocumentForApproval getCadDocumentForApproval() {
        return cadDocumentForApproval;
    }

    public void setCadDocumentForApproval(CadDocumentForApproval cadDocumentForApproval) {
        this.cadDocumentForApproval = cadDocumentForApproval;
    }

    public CadDocumentForApprovalTemp getCadDocumentForApprovalTemp() {
        return cadDocumentForApprovalTemp;
    }

    public void setCadDocumentForApprovalTemp(CadDocumentForApprovalTemp cadDocumentForApprovalTemp) {
        this.cadDocumentForApprovalTemp = cadDocumentForApprovalTemp;
    }

    public List<CadDocumentForApprovalTemp> getListCadDocumentForApprovalTemp() {
        return listCadDocumentForApprovalTemp;
    }

    public void setListCadDocumentForApprovalTemp(List<CadDocumentForApprovalTemp> listCadDocumentForApprovalTemp) {
        this.listCadDocumentForApprovalTemp = listCadDocumentForApprovalTemp;
    }

    public String getCadDocumentForApprovalSearchCode() {
        return cadDocumentForApprovalSearchCode;
    }

    public void setCadDocumentForApprovalSearchCode(String cadDocumentForApprovalSearchCode) {
        this.cadDocumentForApprovalSearchCode = cadDocumentForApprovalSearchCode;
    }

    public String getCadDocumentForApprovalSearchName() {
        return cadDocumentForApprovalSearchName;
    }

    public void setCadDocumentForApprovalSearchName(String cadDocumentForApprovalSearchName) {
        this.cadDocumentForApprovalSearchName = cadDocumentForApprovalSearchName;
    }

    public String getCadDocumentForApprovalSearchActiveStatus() {
        return cadDocumentForApprovalSearchActiveStatus;
    }

    public void setCadDocumentForApprovalSearchActiveStatus(String cadDocumentForApprovalSearchActiveStatus) {
        this.cadDocumentForApprovalSearchActiveStatus = cadDocumentForApprovalSearchActiveStatus;
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
