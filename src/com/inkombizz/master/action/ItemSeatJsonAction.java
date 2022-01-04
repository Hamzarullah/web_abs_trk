
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

import com.inkombizz.master.bll.ItemSeatBLL;
import com.inkombizz.master.model.ItemSeat;
import com.inkombizz.master.model.ItemSeatTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSeatJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSeat itemSeat;
    private ItemSeatTemp itemSeatTemp;
    private List <ItemSeatTemp> listItemSeatTemp;
    private String itemSeatSearchCode = "";
    private String itemSeatSearchName = "";
    private String itemSeatSearchActiveStatus="true";
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
    
    @Action("item-seat-data")
    public String findData() {
        try {
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            ListPaging <ItemSeatTemp> listPaging = itemSeatBLL.findData(itemSeatSearchCode,itemSeatSearchName,itemSeatSearchActiveStatus,paging);
            
            listItemSeatTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-get-data")
    public String findData1() {
        try {
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            this.itemSeatTemp = itemSeatBLL.findData(this.itemSeat.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-get")
    public String findData2() {
        try {
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            this.itemSeatTemp = itemSeatBLL.findData(this.itemSeat.getCode(),this.itemSeat.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-authority")
    public String itemSeatAuthority(){
        try{
            
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSeatBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-seat-save")
    public String save() {
        try {
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            
          itemSeat.setInActiveDate(commonFunction.setDateTime(itemSeatTemp.getInActiveDateTemp()));
         itemSeat.setCreatedDate(commonFunction.setDateTime(itemSeatTemp.getCreatedDateTemp()));
            
            if(itemSeatBLL.isExist(this.itemSeat.getCode())){
                this.errorMessage = "CODE "+this.itemSeat.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSeatBLL.save(this.itemSeat);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSeat.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-update")
    public String update() {
        try {
            ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            itemSeat.setInActiveDate(commonFunction.setDateTime(itemSeatTemp.getInActiveDateTemp()));
            itemSeat.setCreatedDate(commonFunction.setDateTime(itemSeatTemp.getCreatedDateTemp()));
            itemSeatBLL.update(this.itemSeat);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSeat.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seat-delete")
    public String delete() {
        try {
           ItemSeatBLL itemSeatBLL = new ItemSeatBLL(hbmSession);
            itemSeatBLL.delete(this.itemSeat.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSeat.getCode();
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

    public ItemSeat getItemSeat() {
        return itemSeat;
    }

    public void setItemSeat(ItemSeat itemSeat) {
        this.itemSeat = itemSeat;
    }

    public ItemSeatTemp getItemSeatTemp() {
        return itemSeatTemp;
    }

    public void setItemSeatTemp(ItemSeatTemp itemSeatTemp) {
        this.itemSeatTemp = itemSeatTemp;
    }

    public List<ItemSeatTemp> getListItemSeatTemp() {
        return listItemSeatTemp;
    }

    public void setListItemSeatTemp(List<ItemSeatTemp> listItemSeatTemp) {
        this.listItemSeatTemp = listItemSeatTemp;
    }

    public String getItemSeatSearchCode() {
        return itemSeatSearchCode;
    }

    public void setItemSeatSearchCode(String itemSeatSearchCode) {
        this.itemSeatSearchCode = itemSeatSearchCode;
    }

    public String getItemSeatSearchName() {
        return itemSeatSearchName;
    }

    public void setItemSeatSearchName(String itemSeatSearchName) {
        this.itemSeatSearchName = itemSeatSearchName;
    }

    public String getItemSeatSearchActiveStatus() {
        return itemSeatSearchActiveStatus;
    }

    public void setItemSeatSearchActiveStatus(String itemSeatSearchActiveStatus) {
        this.itemSeatSearchActiveStatus = itemSeatSearchActiveStatus;
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
