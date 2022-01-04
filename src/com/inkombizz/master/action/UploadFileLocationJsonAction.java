
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

import com.inkombizz.master.bll.UploadFileLocationBLL;
import com.inkombizz.master.model.UploadFileLocation;
import com.inkombizz.master.model.UploadFileLocationTemp;


@Result (type="json")
public class UploadFileLocationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private UploadFileLocation uploadFileLocation;
    private UploadFileLocationTemp uploadFileLocationTemp;
    private List <UploadFileLocationTemp> listUploadFileLocationTemp;
    private String uploadFileLocationSearchCode = "";
    private String uploadFileLocationSearchName = "";
    private String uploadFileLocationSearchActiveStatus="true";
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
    
    @Action("upload-file-location-data")
    public String findData() {
        try {
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            ListPaging <UploadFileLocationTemp> listPaging = uploadFileLocationBLL.findData(uploadFileLocationSearchCode,uploadFileLocationSearchName,uploadFileLocationSearchActiveStatus,paging);
            
            listUploadFileLocationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("upload-file-location-get-data")
    public String findData1() {
        try {
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            this.uploadFileLocationTemp = uploadFileLocationBLL.findData(this.uploadFileLocation.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("upload-file-location-get")
    public String findData2() {
        try {
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            this.uploadFileLocationTemp = uploadFileLocationBLL.findData(this.uploadFileLocation.getCode(),this.uploadFileLocation.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("upload-file-location-authority")
    public String uploadFileLocationAuthority(){
        try{
            
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(uploadFileLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(uploadFileLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(uploadFileLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("upload-file-location-save")
    public String save() {
        try {
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            
            uploadFileLocation.setInActiveDate(commonFunction.setDateTime(uploadFileLocationTemp.getInActiveDateTemp()));
            uploadFileLocation.setCreatedDate(commonFunction.setDateTime(uploadFileLocationTemp.getCreatedDateTemp()));
            
            if(uploadFileLocationBLL.isExist(this.uploadFileLocation.getCode())){
                this.errorMessage = "CODE "+this.uploadFileLocation.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                uploadFileLocationBLL.save(this.uploadFileLocation);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.uploadFileLocation.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("upload-file-location-update")
    public String update() {
        try {
            UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            uploadFileLocation.setInActiveDate(commonFunction.setDateTime(uploadFileLocationTemp.getInActiveDateTemp()));
            uploadFileLocation.setCreatedDate(commonFunction.setDateTime(uploadFileLocationTemp.getCreatedDateTemp()));
            uploadFileLocationBLL.update(this.uploadFileLocation);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.uploadFileLocation.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("upload-file-location-delete")
    public String delete() {
        try {
           UploadFileLocationBLL uploadFileLocationBLL = new UploadFileLocationBLL(hbmSession);
            uploadFileLocationBLL.delete(this.uploadFileLocation.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.uploadFileLocation.getCode();
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

    public UploadFileLocation getUploadFileLocation() {
        return uploadFileLocation;
    }

    public void setUploadFileLocation(UploadFileLocation uploadFileLocation) {
        this.uploadFileLocation = uploadFileLocation;
    }

    public UploadFileLocationTemp getUploadFileLocationTemp() {
        return uploadFileLocationTemp;
    }

    public void setUploadFileLocationTemp(UploadFileLocationTemp uploadFileLocationTemp) {
        this.uploadFileLocationTemp = uploadFileLocationTemp;
    }

    public List<UploadFileLocationTemp> getListUploadFileLocationTemp() {
        return listUploadFileLocationTemp;
    }

    public void setListUploadFileLocationTemp(List<UploadFileLocationTemp> listUploadFileLocationTemp) {
        this.listUploadFileLocationTemp = listUploadFileLocationTemp;
    }

    public String getUploadFileLocationSearchCode() {
        return uploadFileLocationSearchCode;
    }

    public void setUploadFileLocationSearchCode(String uploadFileLocationSearchCode) {
        this.uploadFileLocationSearchCode = uploadFileLocationSearchCode;
    }

    public String getUploadFileLocationSearchName() {
        return uploadFileLocationSearchName;
    }

    public void setUploadFileLocationSearchName(String uploadFileLocationSearchName) {
        this.uploadFileLocationSearchName = uploadFileLocationSearchName;
    }

    public String getUploadFileLocationSearchActiveStatus() {
        return uploadFileLocationSearchActiveStatus;
    }

    public void setUploadFileLocationSearchActiveStatus(String uploadFileLocationSearchActiveStatus) {
        this.uploadFileLocationSearchActiveStatus = uploadFileLocationSearchActiveStatus;
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
