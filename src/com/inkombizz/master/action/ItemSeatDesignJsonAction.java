
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

import com.inkombizz.master.bll.ItemSeatDesignBLL;
import com.inkombizz.master.model.ItemSeatDesign;
import com.inkombizz.master.model.ItemSeatDesignTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSeatDesignJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSeatDesign itemSeatDesign;
    private ItemSeatDesignTemp itemSeatDesignTemp;
    private List <ItemSeatDesignTemp> listItemSeatDesignTemp;
    private String itemSeatDesignSearchCode = "";
    private String itemSeatDesignSearchName = "";
    private String itemSeatDesignSearchActiveStatus="true";
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
    
    @Action("item-seat-design-data")
    public String findData() {
        try {
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            ListPaging <ItemSeatDesignTemp> listPaging = itemSeatDesignBLL.findData(itemSeatDesignSearchCode,itemSeatDesignSearchName,itemSeatDesignSearchActiveStatus,paging);
            
            listItemSeatDesignTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-design-get-data")
    public String findData1() {
        try {
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            this.itemSeatDesignTemp = itemSeatDesignBLL.findData(this.itemSeatDesign.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-design-get")
    public String findData2() {
        try {
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            this.itemSeatDesignTemp = itemSeatDesignBLL.findData(this.itemSeatDesign.getCode(),this.itemSeatDesign.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-design-authority")
    public String itemSeatDesignAuthority(){
        try{
            
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-seat-design-save")
    public String save() {
        try {
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            
          itemSeatDesign.setInActiveDate(commonFunction.setDateTime(itemSeatDesignTemp.getInActiveDateTemp()));
         itemSeatDesign.setCreatedDate(commonFunction.setDateTime(itemSeatDesignTemp.getCreatedDateTemp()));
            
            if(itemSeatDesignBLL.isExist(this.itemSeatDesign.getCode())){
                this.errorMessage = "CODE "+this.itemSeatDesign.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSeatDesignBLL.save(this.itemSeatDesign);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSeatDesign.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-design-update")
    public String update() {
        try {
            ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            itemSeatDesign.setInActiveDate(commonFunction.setDateTime(itemSeatDesignTemp.getInActiveDateTemp()));
            itemSeatDesign.setCreatedDate(commonFunction.setDateTime(itemSeatDesignTemp.getCreatedDateTemp()));
            itemSeatDesignBLL.update(this.itemSeatDesign);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSeatDesign.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-design-delete")
    public String delete() {
        try {
           ItemSeatDesignBLL itemSeatDesignBLL = new ItemSeatDesignBLL(hbmSession);
            itemSeatDesignBLL.delete(this.itemSeatDesign.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSeatDesign.getCode();
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

    public ItemSeatDesign getItemSeatDesign() {
        return itemSeatDesign;
    }

    public void setItemSeatDesign(ItemSeatDesign itemSeatDesign) {
        this.itemSeatDesign = itemSeatDesign;
    }

    public ItemSeatDesignTemp getItemSeatDesignTemp() {
        return itemSeatDesignTemp;
    }

    public void setItemSeatDesignTemp(ItemSeatDesignTemp itemSeatDesignTemp) {
        this.itemSeatDesignTemp = itemSeatDesignTemp;
    }

    public List<ItemSeatDesignTemp> getListItemSeatDesignTemp() {
        return listItemSeatDesignTemp;
    }

    public void setListItemSeatDesignTemp(List<ItemSeatDesignTemp> listItemSeatDesignTemp) {
        this.listItemSeatDesignTemp = listItemSeatDesignTemp;
    }

    public String getItemSeatDesignSearchCode() {
        return itemSeatDesignSearchCode;
    }

    public void setItemSeatDesignSearchCode(String itemSeatDesignSearchCode) {
        this.itemSeatDesignSearchCode = itemSeatDesignSearchCode;
    }

    public String getItemSeatDesignSearchName() {
        return itemSeatDesignSearchName;
    }

    public void setItemSeatDesignSearchName(String itemSeatDesignSearchName) {
        this.itemSeatDesignSearchName = itemSeatDesignSearchName;
    }

    public String getItemSeatDesignSearchActiveStatus() {
        return itemSeatDesignSearchActiveStatus;
    }

    public void setItemSeatDesignSearchActiveStatus(String itemSeatDesignSearchActiveStatus) {
        this.itemSeatDesignSearchActiveStatus = itemSeatDesignSearchActiveStatus;
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
