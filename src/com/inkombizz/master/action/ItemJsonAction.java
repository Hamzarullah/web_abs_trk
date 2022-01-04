
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

import com.inkombizz.master.bll.ItemBLL;
import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemTemp;

@Result (type = "json")
public class ItemJsonAction extends ActionSupport{
 
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Item item;
    private ItemTemp itemTemp;
    private List <ItemTemp> listItemTemp;
    private String itemSearchCode = "";
    private String itemSearchName = "";
    private String itemSearchInventoryType = "";
    private String itemSearchInventoryCategory = "";
    private String itemSearchItemDivision = "";
    private String itemSearchActiveStatus="true";
    private String itemSearchPackageStatus="true";
    private String itemSerialNoSearchWarehouseCode="";
    private String itemSearchItemDivisionCode="";
    private String itemSearchItemDivisionName="";
    private String itemSearchPriorityStatus="";
    private String itemSearchSerialNoStatus="";
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
    
    @Action("item-data")
    public String findData() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            ListPaging <ItemTemp> listPaging = itemBLL.findData(itemSearchCode,itemSearchName,itemSearchInventoryType,itemSearchInventoryCategory,itemSearchActiveStatus,itemSearchPackageStatus,paging);
            
            listItemTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-data-search")
    public String findDataSearch() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            ListPaging <ItemTemp> listPaging = itemBLL.findDataSearch(itemSearchCode,itemSearchName,itemSearchInventoryType,itemSearchInventoryCategory,itemSearchActiveStatus,itemSearchPackageStatus,paging);
            
            listItemTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-serial-no-data")
    public String findDataInSerialNoDetail() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            ListPaging <ItemTemp> listPaging = itemBLL.findData(itemSearchCode,itemSearchName,itemSerialNoSearchWarehouseCode,paging);
            
            listItemTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-get-data")
    public String findData1() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            this.itemTemp = itemBLL.findData(this.item.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-get")
    public String findData2() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
//            this.itemTemp = itemBLL.findData(this.item.getCode(),this.item.isActiveStatus(),itemSearchInventoryType,itemSearchInventoryCategory,this.item.isPackageStatus());
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-serial-no-get")
    public String findDataItemSerialNo() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            this.itemTemp = itemBLL.findData(this.item.getCode(),itemSerialNoSearchWarehouseCode);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-authority")
    public String itemAuthority(){
        try{
            
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-save")
    public String save() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
           
            if(itemBLL.isExist(this.item.getCode())){
                this.error = true;
                this.errorMessage = "CODE "+this.item.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBLL.save(this.item);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.item.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-update")
    public String update() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            
            itemBLL.update(this.item);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.item.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-delete")
    public String delete() {
        try {
            ItemBLL itemBLL = new ItemBLL(hbmSession);
            boolean check=false;// = itemBLL.isExistToDelete(this.item.getCode());
            if(check == true){
                this.message = "CODE "+this.item.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                itemBLL.delete(this.item.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.item.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("item-get-min")
    public String populateDataSupplierMin() {
        try {
            ItemBLL itemBLL=new ItemBLL(hbmSession);
            this.itemTemp = itemBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-get-max")
    public String populateDataSupplierMax() {
        try {
            ItemBLL itemBLL=new ItemBLL(hbmSession);
            this.itemTemp = itemBLL.getMax();
            
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

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public ItemTemp getItemTemp() {
        return itemTemp;
    }

    public void setItemTemp(ItemTemp itemTemp) {
        this.itemTemp = itemTemp;
    }

    public List<ItemTemp> getListItemTemp() {
        return listItemTemp;
    }

    public void setListItemTemp(List<ItemTemp> listItemTemp) {
        this.listItemTemp = listItemTemp;
    }

    public String getItemSearchCode() {
        return itemSearchCode;
    }

    public void setItemSearchCode(String itemSearchCode) {
        this.itemSearchCode = itemSearchCode;
    }

    public String getItemSearchName() {
        return itemSearchName;
    }

    public void setItemSearchName(String itemSearchName) {
        this.itemSearchName = itemSearchName;
    }

    public String getItemSearchInventoryType() {
        return itemSearchInventoryType;
    }

    public void setItemSearchInventoryType(String itemSearchInventoryType) {
        this.itemSearchInventoryType = itemSearchInventoryType;
    }

    public String getItemSearchItemDivision() {
        return itemSearchItemDivision;
    }

    public void setItemSearchItemDivision(String itemSearchItemDivision) {
        this.itemSearchItemDivision = itemSearchItemDivision;
    }

    public String getItemSearchActiveStatus() {
        return itemSearchActiveStatus;
    }

    public void setItemSearchActiveStatus(String itemSearchActiveStatus) {
        this.itemSearchActiveStatus = itemSearchActiveStatus;
    }

    public String getItemSearchPackageStatus() {
        return itemSearchPackageStatus;
    }

    public void setItemSearchPackageStatus(String itemSearchPackageStatus) {
        this.itemSearchPackageStatus = itemSearchPackageStatus;
    }

    public String getItemSerialNoSearchWarehouseCode() {
        return itemSerialNoSearchWarehouseCode;
    }

    public void setItemSerialNoSearchWarehouseCode(String itemSerialNoSearchWarehouseCode) {
        this.itemSerialNoSearchWarehouseCode = itemSerialNoSearchWarehouseCode;
    }

    public String getItemSearchItemDivisionCode() {
        return itemSearchItemDivisionCode;
    }

    public void setItemSearchItemDivisionCode(String itemSearchItemDivisionCode) {
        this.itemSearchItemDivisionCode = itemSearchItemDivisionCode;
    }

    public String getItemSearchItemDivisionName() {
        return itemSearchItemDivisionName;
    }

    public void setItemSearchItemDivisionName(String itemSearchItemDivisionName) {
        this.itemSearchItemDivisionName = itemSearchItemDivisionName;
    }

    public String getItemSearchPriorityStatus() {
        return itemSearchPriorityStatus;
    }

    public void setItemSearchPriorityStatus(String itemSearchPriorityStatus) {
        this.itemSearchPriorityStatus = itemSearchPriorityStatus;
    }

    public String getItemSearchSerialNoStatus() {
        return itemSearchSerialNoStatus;
    }

    public void setItemSearchSerialNoStatus(String itemSearchSerialNoStatus) {
        this.itemSearchSerialNoStatus = itemSearchSerialNoStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getItemSearchInventoryCategory() {
        return itemSearchInventoryCategory;
    }

    public void setItemSearchInventoryCategory(String itemSearchInventoryCategory) {
        this.itemSearchInventoryCategory = itemSearchInventoryCategory;
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
    
    // <editor-fold defaultstate="collapsed" desc="Paging">
    
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
