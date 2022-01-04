
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.AssetCategoryBLL;
import com.inkombizz.master.model.AssetCategory;
import com.inkombizz.master.model.AssetCategoryTemp;


@Result (type = "json")
public class AssetCategoryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private AssetCategory assetCategory;
    private AssetCategoryTemp assetCategoryTemp;
    private List <AssetCategoryTemp> listAssetCategoryTemp;
    private String assetCategorySearchCode = "";
    private String assetCategorySearchName = "";
    private String assetCategorySearchActiveStatus="true";
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
    
    @Action("asset-category-data")
    public String findData() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            ListPaging <AssetCategoryTemp> listPaging = assetCategoryBLL.findData(assetCategorySearchCode,assetCategorySearchName,assetCategorySearchActiveStatus,paging);
            
            listAssetCategoryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-category-get-data")
    public String findData1() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            this.assetCategoryTemp = assetCategoryBLL.findData(this.assetCategory.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-category-get")
    public String findData2() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            this.assetCategoryTemp = assetCategoryBLL.findData(this.assetCategory.getCode(),this.assetCategory.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-category-authority")
    public String assetCategoryAuthority(){
        try{
            
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("asset-category-save")
    public String save() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
           
            if(assetCategoryBLL.isExist(this.assetCategory.getCode())){
                this.errorMessage = "CODE "+this.assetCategory.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                assetCategoryBLL.save(this.assetCategory);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.assetCategory.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-category-update")
    public String update() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            
            assetCategoryBLL.update(this.assetCategory);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.assetCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-category-delete")
    public String delete() {
        try {
            AssetCategoryBLL assetCategoryBLL = new AssetCategoryBLL(hbmSession);
            boolean check=false;// = assetCategoryBLL.isExistToDelete(this.assetCategory.getCode());
            if(check == true){
                this.message = "CODE "+this.assetCategory.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                assetCategoryBLL.delete(this.assetCategory.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.assetCategory.getCode();
            }
            
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

    public AssetCategory getAssetCategory() {
        return assetCategory;
    }

    public void setAssetCategory(AssetCategory assetCategory) {
        this.assetCategory = assetCategory;
    }

    public AssetCategoryTemp getAssetCategoryTemp() {
        return assetCategoryTemp;
    }

    public void setAssetCategoryTemp(AssetCategoryTemp assetCategoryTemp) {
        this.assetCategoryTemp = assetCategoryTemp;
    }

    public List<AssetCategoryTemp> getListAssetCategoryTemp() {
        return listAssetCategoryTemp;
    }

    public void setListAssetCategoryTemp(List<AssetCategoryTemp> listAssetCategoryTemp) {
        this.listAssetCategoryTemp = listAssetCategoryTemp;
    }

    public String getAssetCategorySearchCode() {
        return assetCategorySearchCode;
    }

    public void setAssetCategorySearchCode(String assetCategorySearchCode) {
        this.assetCategorySearchCode = assetCategorySearchCode;
    }

    public String getAssetCategorySearchName() {
        return assetCategorySearchName;
    }

    public void setAssetCategorySearchName(String assetCategorySearchName) {
        this.assetCategorySearchName = assetCategorySearchName;
    }

    public String getAssetCategorySearchActiveStatus() {
        return assetCategorySearchActiveStatus;
    }

    public void setAssetCategorySearchActiveStatus(String assetCategorySearchActiveStatus) {
        this.assetCategorySearchActiveStatus = assetCategorySearchActiveStatus;
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
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
