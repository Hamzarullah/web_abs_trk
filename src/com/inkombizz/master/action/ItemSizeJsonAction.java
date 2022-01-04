
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

import com.inkombizz.master.bll.ItemSizeBLL;
import com.inkombizz.master.model.ItemSize;
import com.inkombizz.master.model.ItemSizeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSizeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSize itemSize;
    private ItemSizeTemp itemSizeTemp;
    private List <ItemSizeTemp> listItemSizeTemp;
    private String itemSizeSearchCode = "";
    private String itemSizeSearchName = "";
    private String itemSizeSearchActiveStatus="true";
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
    
    @Action("item-size-data")
    public String findData() {
        try {
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            ListPaging <ItemSizeTemp> listPaging = itemSizeBLL.findData(itemSizeSearchCode,itemSizeSearchName,itemSizeSearchActiveStatus,paging);
            
            listItemSizeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-size-get-data")
    public String findData1() {
        try {
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            this.itemSizeTemp = itemSizeBLL.findData(this.itemSize.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-size-get")
    public String findData2() {
        try {
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            this.itemSizeTemp = itemSizeBLL.findData(this.itemSize.getCode(),this.itemSize.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-size-authority")
    public String itemSizeAuthority(){
        try{
            
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSizeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSizeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSizeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-size-save")
    public String save() {
        try {
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            
          itemSize.setInActiveDate(commonFunction.setDateTime(itemSizeTemp.getInActiveDateTemp()));
         itemSize.setCreatedDate(commonFunction.setDateTime(itemSizeTemp.getCreatedDateTemp()));
            
            if(itemSizeBLL.isExist(this.itemSize.getCode())){
                this.errorMessage = "CODE "+this.itemSize.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSizeBLL.save(this.itemSize);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSize.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-size-update")
    public String update() {
        try {
            ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            itemSize.setInActiveDate(commonFunction.setDateTime(itemSizeTemp.getInActiveDateTemp()));
            itemSize.setCreatedDate(commonFunction.setDateTime(itemSizeTemp.getCreatedDateTemp()));
            itemSizeBLL.update(this.itemSize);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSize.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-size-delete")
    public String delete() {
        try {
           ItemSizeBLL itemSizeBLL = new ItemSizeBLL(hbmSession);
            itemSizeBLL.delete(this.itemSize.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSize.getCode();
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

    public ItemSize getItemSize() {
        return itemSize;
    }

    public void setItemSize(ItemSize itemSize) {
        this.itemSize = itemSize;
    }

    public ItemSizeTemp getItemSizeTemp() {
        return itemSizeTemp;
    }

    public void setItemSizeTemp(ItemSizeTemp itemSizeTemp) {
        this.itemSizeTemp = itemSizeTemp;
    }

    public List<ItemSizeTemp> getListItemSizeTemp() {
        return listItemSizeTemp;
    }

    public void setListItemSizeTemp(List<ItemSizeTemp> listItemSizeTemp) {
        this.listItemSizeTemp = listItemSizeTemp;
    }

    public String getItemSizeSearchCode() {
        return itemSizeSearchCode;
    }

    public void setItemSizeSearchCode(String itemSizeSearchCode) {
        this.itemSizeSearchCode = itemSizeSearchCode;
    }

    public String getItemSizeSearchName() {
        return itemSizeSearchName;
    }

    public void setItemSizeSearchName(String itemSizeSearchName) {
        this.itemSizeSearchName = itemSizeSearchName;
    }

    public String getItemSizeSearchActiveStatus() {
        return itemSizeSearchActiveStatus;
    }

    public void setItemSizeSearchActiveStatus(String itemSizeSearchActiveStatus) {
        this.itemSizeSearchActiveStatus = itemSizeSearchActiveStatus;
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
