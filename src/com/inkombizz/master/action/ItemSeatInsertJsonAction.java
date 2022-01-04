
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

import com.inkombizz.master.bll.ItemSeatInsertBLL;
import com.inkombizz.master.model.ItemSeatInsert;
import com.inkombizz.master.model.ItemSeatInsertTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSeatInsertJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSeatInsert itemSeatInsert;
    private ItemSeatInsertTemp itemSeatInsertTemp;
    private List <ItemSeatInsertTemp> listItemSeatInsertTemp;
    private String itemSeatInsertSearchCode = "";
    private String itemSeatInsertSearchName = "";
    private String itemSeatInsertSearchActiveStatus="true";
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
    
    @Action("item-seat-insert-data")
    public String findData() {
        try {
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            ListPaging <ItemSeatInsertTemp> listPaging = itemSeatInsertBLL.findData(itemSeatInsertSearchCode,itemSeatInsertSearchName,itemSeatInsertSearchActiveStatus,paging);
            
            listItemSeatInsertTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-insert-get-data")
    public String findData1() {
        try {
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            this.itemSeatInsertTemp = itemSeatInsertBLL.findData(this.itemSeatInsert.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-insert-get")
    public String findData2() {
        try {
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            this.itemSeatInsertTemp = itemSeatInsertBLL.findData(this.itemSeatInsert.getCode(),this.itemSeatInsert.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-insert-authority")
    public String itemSeatInsertAuthority(){
        try{
            
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatInsertBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatInsertBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatInsertBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-seat-insert-save")
    public String save() {
        try {
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            
          itemSeatInsert.setInActiveDate(commonFunction.setDateTime(itemSeatInsertTemp.getInActiveDateTemp()));
         itemSeatInsert.setCreatedDate(commonFunction.setDateTime(itemSeatInsertTemp.getCreatedDateTemp()));
            
            if(itemSeatInsertBLL.isExist(this.itemSeatInsert.getCode())){
                this.errorMessage = "CODE "+this.itemSeatInsert.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSeatInsertBLL.save(this.itemSeatInsert);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSeatInsert.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-insert-update")
    public String update() {
        try {
            ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            itemSeatInsert.setInActiveDate(commonFunction.setDateTime(itemSeatInsertTemp.getInActiveDateTemp()));
            itemSeatInsert.setCreatedDate(commonFunction.setDateTime(itemSeatInsertTemp.getCreatedDateTemp()));
            itemSeatInsertBLL.update(this.itemSeatInsert);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSeatInsert.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-insert-delete")
    public String delete() {
        try {
           ItemSeatInsertBLL itemSeatInsertBLL = new ItemSeatInsertBLL(hbmSession);
            itemSeatInsertBLL.delete(this.itemSeatInsert.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSeatInsert.getCode();
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

    public ItemSeatInsert getItemSeatInsert() {
        return itemSeatInsert;
    }

    public void setItemSeatInsert(ItemSeatInsert itemSeatInsert) {
        this.itemSeatInsert = itemSeatInsert;
    }

    public ItemSeatInsertTemp getItemSeatInsertTemp() {
        return itemSeatInsertTemp;
    }

    public void setItemSeatInsertTemp(ItemSeatInsertTemp itemSeatInsertTemp) {
        this.itemSeatInsertTemp = itemSeatInsertTemp;
    }

    public List<ItemSeatInsertTemp> getListItemSeatInsertTemp() {
        return listItemSeatInsertTemp;
    }

    public void setListItemSeatInsertTemp(List<ItemSeatInsertTemp> listItemSeatInsertTemp) {
        this.listItemSeatInsertTemp = listItemSeatInsertTemp;
    }

    public String getItemSeatInsertSearchCode() {
        return itemSeatInsertSearchCode;
    }

    public void setItemSeatInsertSearchCode(String itemSeatInsertSearchCode) {
        this.itemSeatInsertSearchCode = itemSeatInsertSearchCode;
    }

    public String getItemSeatInsertSearchName() {
        return itemSeatInsertSearchName;
    }

    public void setItemSeatInsertSearchName(String itemSeatInsertSearchName) {
        this.itemSeatInsertSearchName = itemSeatInsertSearchName;
    }

    public String getItemSeatInsertSearchActiveStatus() {
        return itemSeatInsertSearchActiveStatus;
    }

    public void setItemSeatInsertSearchActiveStatus(String itemSeatInsertSearchActiveStatus) {
        this.itemSeatInsertSearchActiveStatus = itemSeatInsertSearchActiveStatus;
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
