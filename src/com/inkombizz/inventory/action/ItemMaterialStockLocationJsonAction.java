
package com.inkombizz.inventory.action;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.ItemMaterialStockLocationBLL;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.inventory.model.ItemMaterialStockLocation;

import static com.opensymphony.xwork2.Action.SUCCESS;
import org.apache.struts2.convention.annotation.Action;


@Result(type = "json")
public class ItemMaterialStockLocationJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ItemMaterialStockLocation itemMaterialStockLocation=new ItemMaterialStockLocation();
    private List<ItemMaterialStockLocation> listItemMaterialStockLocation;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    

    @Action("item-material-stock-location-data")
    public String findData() {
        try {
            ItemMaterialStockLocationBLL itemMaterialStockLocationBLL = new ItemMaterialStockLocationBLL(hbmSession);
            
            ListPaging<ItemMaterialStockLocation> listPaging = itemMaterialStockLocationBLL.findData(paging,itemMaterialStockLocation);

            listItemMaterialStockLocation = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-stock-location-search-data")
    public String findSearchData() {
        try {
            ItemMaterialStockLocationBLL itemMaterialStockLocationBLL = new ItemMaterialStockLocationBLL(hbmSession);
            
            ListPaging<ItemMaterialStockLocation> listPaging = itemMaterialStockLocationBLL.findSearchData(paging,itemMaterialStockLocation);

            listItemMaterialStockLocation = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ItemMaterialStockLocation getItemMaterialStockLocation() {
        return itemMaterialStockLocation;
    }

    public void setItemMaterialStockLocation(ItemMaterialStockLocation itemMaterialStockLocation) {
        this.itemMaterialStockLocation = itemMaterialStockLocation;
    }

    public List<ItemMaterialStockLocation> getListItemMaterialStockLocation() {
        return listItemMaterialStockLocation;
    }

    public void setListItemMaterialStockLocation(List<ItemMaterialStockLocation> listItemMaterialStockLocation) {
        this.listItemMaterialStockLocation = listItemMaterialStockLocation;
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