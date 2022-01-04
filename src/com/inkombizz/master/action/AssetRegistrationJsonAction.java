
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
import static com.opensymphony.xwork2.Action.SUCCESS;

import com.inkombizz.master.bll.AssetRegistrationBLL;
import com.inkombizz.master.model.AssetRegistration;
import com.inkombizz.master.model.AssetRegistrationTemp;

@Result(type = "json")
public class AssetRegistrationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private AssetRegistration assetRegistration;
    private AssetRegistrationTemp assetRegistrationTemp;
    private List<AssetRegistrationTemp> listAssetRegistrationTemp;
    private String assetRegistrationSearchCode="";
    private String assetRegistrationSearchName="";
    private String assetRegistrationSearchChartOfAccountCode="";
    private String assetRegistrationSearchChartOfAccountName="";
    private String assetRegistrationSearchBbmVoucherNo="";
    private String assetRegistrationSearchActiveStatus="true";
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
    
    @Action("asset-registration-data")
    public String findData() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            ListPaging<AssetRegistrationTemp> listPaging = assetRegistrationBLL.findData(paging,assetRegistrationSearchCode,assetRegistrationSearchName,assetRegistrationSearchChartOfAccountCode,assetRegistrationSearchChartOfAccountName,assetRegistrationSearchBbmVoucherNo,assetRegistrationSearchActiveStatus);

            listAssetRegistrationTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-get-data")
    public String findData1() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            this.assetRegistrationTemp = assetRegistrationBLL.findData(this.assetRegistration.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-get")
    public String findData2() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            this.assetRegistrationTemp = assetRegistrationBLL.findData(this.assetRegistration.getCode(),this.assetRegistration.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-get2")
    public String findDataGet2() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            this.assetRegistrationTemp = assetRegistrationBLL.findData2(this.assetRegistration.getCode(),assetRegistrationSearchActiveStatus);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-authority")
    public String assetRegistrationAuthority(){
        try{
            
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetRegistrationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetRegistrationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(assetRegistrationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("asset-registration-save")
    public String save() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            
//            assetRegistration.setCreatedDate(commonFunction.setDateTime(assetRegistrationTemp.getCreatedDateTemp()));
            
            if(assetRegistrationBLL.isExist(this.assetRegistration.getCode())){
                this.errorMessage = "CODE "+this.assetRegistration.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                assetRegistrationBLL.save(this.assetRegistration);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.assetRegistration.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-update")
    public String update() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            assetRegistrationBLL.update(this.assetRegistration);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.assetRegistration.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-delete")
    public String delete() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            boolean check=false;// = assetRegistrationBLL.isExistToDelete(this.assetRegistration.getCode());
            if(check == true){
                this.message = "CODE "+this.assetRegistration.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                assetRegistrationBLL.delete(this.assetRegistration.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.assetRegistration.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("asset-registration-get-min")
    public String minData() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            this.assetRegistrationTemp = assetRegistrationBLL.min();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("asset-registration-get-max")
    public String maxData() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            this.assetRegistrationTemp = assetRegistrationBLL.max();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AssetRegistration getAssetRegistration() {
        return assetRegistration;
    }

    public void setAssetRegistration(AssetRegistration assetRegistration) {
        this.assetRegistration = assetRegistration;
    }

    public AssetRegistrationTemp getAssetRegistrationTemp() {
        return assetRegistrationTemp;
    }

    public void setAssetRegistrationTemp(AssetRegistrationTemp assetRegistrationTemp) {
        this.assetRegistrationTemp = assetRegistrationTemp;
    }

    public List<AssetRegistrationTemp> getListAssetRegistrationTemp() {
        return listAssetRegistrationTemp;
    }

    public void setListAssetRegistrationTemp(List<AssetRegistrationTemp> listAssetRegistrationTemp) {
        this.listAssetRegistrationTemp = listAssetRegistrationTemp;
    }

    public String getAssetRegistrationSearchCode() {
        return assetRegistrationSearchCode;
    }

    public void setAssetRegistrationSearchCode(String assetRegistrationSearchCode) {
        this.assetRegistrationSearchCode = assetRegistrationSearchCode;
    }

    public String getAssetRegistrationSearchName() {
        return assetRegistrationSearchName;
    }

    public void setAssetRegistrationSearchName(String assetRegistrationSearchName) {
        this.assetRegistrationSearchName = assetRegistrationSearchName;
    }

    public String getAssetRegistrationSearchActiveStatus() {
        return assetRegistrationSearchActiveStatus;
    }

    public void setAssetRegistrationSearchActiveStatus(String assetRegistrationSearchActiveStatus) {
        this.assetRegistrationSearchActiveStatus = assetRegistrationSearchActiveStatus;
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
