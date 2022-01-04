
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

import com.inkombizz.master.bll.VendorCategoryBLL;
import com.inkombizz.master.model.VendorCategory;
import com.inkombizz.master.model.VendorCategoryTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class VendorCategoryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private VendorCategory vendorCategory;
    private VendorCategoryTemp vendorCategoryTemp;
    private List <VendorCategoryTemp> listVendorCategoryTemp;
    private String vendorCategorySearchCode = "";
    private String vendorCategorySearchName = "";
    private String vendorCategorySearchActiveStatus="true";
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
    
    @Action("vendor-category-data")
    public String findData() {
        try {
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            ListPaging <VendorCategoryTemp> listPaging = vendorCategoryBLL.findData(vendorCategorySearchCode,vendorCategorySearchName,vendorCategorySearchActiveStatus,paging);
            
            listVendorCategoryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-category-get-data")
    public String findData1() {
        try {
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            this.vendorCategoryTemp = vendorCategoryBLL.findData(this.vendorCategory.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-category-get")
    public String findData2() {
        try {
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            this.vendorCategoryTemp = vendorCategoryBLL.findData(this.vendorCategory.getCode(),this.vendorCategory.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-category-authority")
    public String vendorCategoryAuthority(){
        try{
            
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("vendor-category-save")
    public String save() {
        try {
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            
          vendorCategory.setInActiveDate(commonFunction.setDateTime(vendorCategoryTemp.getInActiveDateTemp()));
         vendorCategory.setCreatedDate(commonFunction.setDateTime(vendorCategoryTemp.getCreatedDateTemp()));
            
            if(vendorCategoryBLL.isExist(this.vendorCategory.getCode())){
                this.errorMessage = "CODE "+this.vendorCategory.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                vendorCategoryBLL.save(this.vendorCategory);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.vendorCategory.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-category-update")
    public String update() {
        try {
            VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            vendorCategory.setInActiveDate(commonFunction.setDateTime(vendorCategoryTemp.getInActiveDateTemp()));
            vendorCategory.setCreatedDate(commonFunction.setDateTime(vendorCategoryTemp.getCreatedDateTemp()));
            vendorCategoryBLL.update(this.vendorCategory);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.vendorCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-category-delete")
    public String delete() {
        try {
           VendorCategoryBLL vendorCategoryBLL = new VendorCategoryBLL(hbmSession);
            vendorCategoryBLL.delete(this.vendorCategory.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.vendorCategory.getCode();
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

    public VendorCategory getVendorCategory() {
        return vendorCategory;
    }

    public void setVendorCategory(VendorCategory vendorCategory) {
        this.vendorCategory = vendorCategory;
    }

    public VendorCategoryTemp getVendorCategoryTemp() {
        return vendorCategoryTemp;
    }

    public void setVendorCategoryTemp(VendorCategoryTemp vendorCategoryTemp) {
        this.vendorCategoryTemp = vendorCategoryTemp;
    }

    public List<VendorCategoryTemp> getListVendorCategoryTemp() {
        return listVendorCategoryTemp;
    }

    public void setListVendorCategoryTemp(List<VendorCategoryTemp> listVendorCategoryTemp) {
        this.listVendorCategoryTemp = listVendorCategoryTemp;
    }

    public String getVendorCategorySearchCode() {
        return vendorCategorySearchCode;
    }

    public void setVendorCategorySearchCode(String vendorCategorySearchCode) {
        this.vendorCategorySearchCode = vendorCategorySearchCode;
    }

    public String getVendorCategorySearchName() {
        return vendorCategorySearchName;
    }

    public void setVendorCategorySearchName(String vendorCategorySearchName) {
        this.vendorCategorySearchName = vendorCategorySearchName;
    }

    public String getVendorCategorySearchActiveStatus() {
        return vendorCategorySearchActiveStatus;
    }

    public void setVendorCategorySearchActiveStatus(String vendorCategorySearchActiveStatus) {
        this.vendorCategorySearchActiveStatus = vendorCategorySearchActiveStatus;
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
