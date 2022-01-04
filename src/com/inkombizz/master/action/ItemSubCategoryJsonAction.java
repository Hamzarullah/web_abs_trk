
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

import com.inkombizz.master.bll.ItemSubCategoryBLL;
import com.inkombizz.master.model.ItemSubCategory;
import com.inkombizz.master.model.ItemSubCategoryTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSubCategoryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSubCategory itemSubCategory;
    private ItemSubCategoryTemp itemSubCategoryTemp;
    private List <ItemSubCategoryTemp> listItemSubCategoryTemp;
    private String itemSubCategorySearchCode = "";
    private String itemSubCategorySearchName = "";
    private String itemSubCategorySearchActiveStatus="true";
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
    
    @Action("item-sub-category-data")
    public String findData() {
        try {
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            ListPaging <ItemSubCategoryTemp> listPaging = itemSubCategoryBLL.findData(itemSubCategorySearchCode,itemSubCategorySearchName,itemSubCategorySearchActiveStatus,paging);
            
            listItemSubCategoryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-sub-category-get-data")
    public String findData1() {
        try {
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            this.itemSubCategoryTemp = itemSubCategoryBLL.findData(this.itemSubCategory.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-sub-category-get")
    public String findData2() {
        try {
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            this.itemSubCategoryTemp = itemSubCategoryBLL.findData(this.itemSubCategory.getCode(),this.itemSubCategory.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-sub-category-authority")
    public String itemSubCategoryAuthority(){
        try{
            
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSubCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSubCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSubCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-sub-category-save")
    public String save() {
        try {
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            
//            itemSubCategory.setInActiveDate(commonFunction.setDateTime(itemSubCategoryTemp.getInActiveDateTemp()));
//            itemSubCategory.setCreatedDate(commonFunction.setDateTime(itemSubCategoryTemp.getCreatedDateTemp()));
            
            if(itemSubCategoryBLL.isExist(this.itemSubCategory.getCode())){
                this.errorMessage = "CODE "+this.itemSubCategory.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSubCategoryBLL.save(this.itemSubCategory);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSubCategory.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-sub-category-update")
    public String update() {
        try {
            ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
//            itemSubCategory.setInActiveDate(commonFunction.setDateTime(itemSubCategoryTemp.getInActiveDateTemp()));
//            itemSubCategory.setCreatedDate(commonFunction.setDateTime(itemSubCategoryTemp.getCreatedDateTemp()));
            itemSubCategoryBLL.update(this.itemSubCategory);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSubCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-sub-category-delete")
    public String delete() {
        try {
           ItemSubCategoryBLL itemSubCategoryBLL = new ItemSubCategoryBLL(hbmSession);
            itemSubCategoryBLL.delete(this.itemSubCategory.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSubCategory.getCode();
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

    public ItemSubCategory getItemSubCategory() {
        return itemSubCategory;
    }

    public void setItemSubCategory(ItemSubCategory itemSubCategory) {
        this.itemSubCategory = itemSubCategory;
    }

    public ItemSubCategoryTemp getItemSubCategoryTemp() {
        return itemSubCategoryTemp;
    }

    public void setItemSubCategoryTemp(ItemSubCategoryTemp itemSubCategoryTemp) {
        this.itemSubCategoryTemp = itemSubCategoryTemp;
    }

    public List<ItemSubCategoryTemp> getListItemSubCategoryTemp() {
        return listItemSubCategoryTemp;
    }

    public void setListItemSubCategoryTemp(List<ItemSubCategoryTemp> listItemSubCategoryTemp) {
        this.listItemSubCategoryTemp = listItemSubCategoryTemp;
    }

    public String getItemSubCategorySearchCode() {
        return itemSubCategorySearchCode;
    }

    public void setItemSubCategorySearchCode(String itemSubCategorySearchCode) {
        this.itemSubCategorySearchCode = itemSubCategorySearchCode;
    }

    public String getItemSubCategorySearchName() {
        return itemSubCategorySearchName;
    }

    public void setItemSubCategorySearchName(String itemSubCategorySearchName) {
        this.itemSubCategorySearchName = itemSubCategorySearchName;
    }

    public String getItemSubCategorySearchActiveStatus() {
        return itemSubCategorySearchActiveStatus;
    }

    public void setItemSubCategorySearchActiveStatus(String itemSubCategorySearchActiveStatus) {
        this.itemSubCategorySearchActiveStatus = itemSubCategorySearchActiveStatus;
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
