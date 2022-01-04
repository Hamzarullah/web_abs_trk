
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ItemCategoryBLL;
import com.inkombizz.master.model.ItemCategory;
import com.inkombizz.master.model.ItemCategoryTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class ItemCategoryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ItemCategory itemCategory;
    private ItemCategory searchItemCategory = new ItemCategory();
    private ItemCategoryTemp itemCategoryTemp;
    private List <ItemCategoryTemp> listItemCategoryTemp;
    private List <ItemCategory> listItemCategory;
    private String actionAuthority="";
    private Enum_TriState searchItemCategoryActiveStatus = Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("item-category-search")
    public String search() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            
            ListPaging <ItemCategory> listPaging = itemCategoryBLL.search(paging, searchItemCategory.getCode(), searchItemCategory.getName(), searchItemCategoryActiveStatus);
            
            listItemCategory = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-category-data")
    public String populateData() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            ListPaging<ItemCategory> listPaging = itemCategoryBLL.get(paging);
            listItemCategory = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-category-get")
    public String populateDataForUpdate() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            this.itemCategory = itemCategoryBLL.get(this.itemCategory.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-category-get-data")
    public String findData2() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            this.itemCategoryTemp = itemCategoryBLL.findData(this.itemCategory.getCode(),this.itemCategory.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-category-save")
    public String save() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }                
            
            if(itemCategory.isActiveStatus() == false){
                itemCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemCategory.setInActiveDate(new Date());
            }
            
            if(itemCategoryBLL.isExist(this.itemCategory.getCode())){
                this.errorMessage = "CODE "+this.itemCategory.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemCategoryBLL.save(this.itemCategory);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemCategory.getCode();
            }
           
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-category-update")
    public String update() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }     
            
            if(itemCategory.isActiveStatus() == false){
                itemCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemCategory.setInActiveDate(new Date());
            }
            itemCategoryBLL.update(this.itemCategory);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-category-delete")
    public String delete() {
        try {
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            itemCategoryBLL.delete(this.itemCategory.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-category-get-min")
    public String populateDataSupplierMin() {
        try {
            ItemCategoryBLL itemCategoryBLL=new ItemCategoryBLL(hbmSession);
            this.itemCategoryTemp = itemCategoryBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-category-get-max")
    public String populateDataSupplierMax() {
        try {
            ItemCategoryBLL itemCategoryBLL=new ItemCategoryBLL(hbmSession);
            this.itemCategoryTemp = itemCategoryBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("item-category-authority")
    public String itemCategoryAuthority(){
        try{
            
            ItemCategoryBLL itemCategoryBLL = new ItemCategoryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public ItemCategory getItemCategory() {
            return itemCategory;
        }

        public void setItemCategory(ItemCategory itemCategory) {
            this.itemCategory = itemCategory;
        }

        public ItemCategoryTemp getItemCategoryTemp() {
            return itemCategoryTemp;
        }

        public void setItemCategoryTemp(ItemCategoryTemp itemCategoryTemp) {
            this.itemCategoryTemp = itemCategoryTemp;
        }

        public List<ItemCategoryTemp> getListItemCategoryTemp() {
            return listItemCategoryTemp;
        }

        public void setListItemCategoryTemp(List<ItemCategoryTemp> listItemCategoryTemp) {
            this.listItemCategoryTemp = listItemCategoryTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public ItemCategory getSearchItemCategory() {
            return searchItemCategory;
        }

        public void setSearchItemCategory(ItemCategory searchItemCategory) {
            this.searchItemCategory = searchItemCategory;
        }

        public List<ItemCategory> getListItemCategory() {
            return listItemCategory;
        }

        public void setListItemCategory(List<ItemCategory> listItemCategory) {
            this.listItemCategory = listItemCategory;
        }

        public Enum_TriState getSearchItemCategoryActiveStatus() {
            return searchItemCategoryActiveStatus;
        }

        public void setSearchItemCategoryActiveStatus(Enum_TriState searchItemCategoryActiveStatus) {
            this.searchItemCategoryActiveStatus = searchItemCategoryActiveStatus;
        }
        

    // </editor-fold>    
    
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
