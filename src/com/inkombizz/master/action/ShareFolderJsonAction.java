
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

import com.inkombizz.master.bll.ShareFolderBLL;
import com.inkombizz.master.model.ShareFolder;
import com.inkombizz.master.model.ShareFolderTemp;


@Result (type="json")
public class ShareFolderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ShareFolder shareFolder;
    private ShareFolderTemp shareFolderTemp;
    private List <ShareFolderTemp> listShareFolderTemp;
    private String shareFolderSearchCode = "";
    private String shareFolderSearchName = "";
    private String shareFolderSearchActiveStatus="true";
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
    
    @Action("share-folder-data")
    public String findData() {
        try {
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            ListPaging <ShareFolderTemp> listPaging = shareFolderBLL.findData(shareFolderSearchCode,shareFolderSearchName,shareFolderSearchActiveStatus,paging);
            
            listShareFolderTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("share-folder-get-data")
    public String findData1() {
        try {
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            this.shareFolderTemp = shareFolderBLL.findData(this.shareFolder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("share-folder-get")
    public String findData2() {
        try {
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            this.shareFolderTemp = shareFolderBLL.findData(this.shareFolder.getCode(),this.shareFolder.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("share-folder-authority")
    public String shareFolderAuthority(){
        try{
            
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(shareFolderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(shareFolderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(shareFolderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("share-folder-save")
    public String save() {
        try {
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            
            shareFolder.setInActiveDate(commonFunction.setDateTime(shareFolderTemp.getInActiveDateTemp()));
            shareFolder.setCreatedDate(commonFunction.setDateTime(shareFolderTemp.getCreatedDateTemp()));
            
            if(shareFolderBLL.isExist(this.shareFolder.getCode())){
                this.errorMessage = "CODE "+this.shareFolder.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                shareFolderBLL.save(this.shareFolder);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.shareFolder.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("share-folder-update")
    public String update() {
        try {
            ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            shareFolder.setInActiveDate(commonFunction.setDateTime(shareFolderTemp.getInActiveDateTemp()));
            shareFolder.setCreatedDate(commonFunction.setDateTime(shareFolderTemp.getCreatedDateTemp()));
            shareFolderBLL.update(this.shareFolder);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.shareFolder.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("share-folder-delete")
    public String delete() {
        try {
           ShareFolderBLL shareFolderBLL = new ShareFolderBLL(hbmSession);
            shareFolderBLL.delete(this.shareFolder.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.shareFolder.getCode();
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

    public ShareFolder getShareFolder() {
        return shareFolder;
    }

    public void setShareFolder(ShareFolder shareFolder) {
        this.shareFolder = shareFolder;
    }

    public ShareFolderTemp getShareFolderTemp() {
        return shareFolderTemp;
    }

    public void setShareFolderTemp(ShareFolderTemp shareFolderTemp) {
        this.shareFolderTemp = shareFolderTemp;
    }

    public List<ShareFolderTemp> getListShareFolderTemp() {
        return listShareFolderTemp;
    }

    public void setListShareFolderTemp(List<ShareFolderTemp> listShareFolderTemp) {
        this.listShareFolderTemp = listShareFolderTemp;
    }

    public String getShareFolderSearchCode() {
        return shareFolderSearchCode;
    }

    public void setShareFolderSearchCode(String shareFolderSearchCode) {
        this.shareFolderSearchCode = shareFolderSearchCode;
    }

    public String getShareFolderSearchName() {
        return shareFolderSearchName;
    }

    public void setShareFolderSearchName(String shareFolderSearchName) {
        this.shareFolderSearchName = shareFolderSearchName;
    }

    public String getShareFolderSearchActiveStatus() {
        return shareFolderSearchActiveStatus;
    }

    public void setShareFolderSearchActiveStatus(String shareFolderSearchActiveStatus) {
        this.shareFolderSearchActiveStatus = shareFolderSearchActiveStatus;
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
