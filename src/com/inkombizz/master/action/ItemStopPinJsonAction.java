
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ItemStopPinBLL;
import com.inkombizz.master.bll.ItemStopPinBLL;
import com.inkombizz.master.model.ItemStopPin;
import com.inkombizz.master.model.ItemStopPinTemp;
import com.inkombizz.master.model.ItemStopPin;
import com.inkombizz.master.model.ItemStopPin;
import com.inkombizz.master.model.ItemStopPin;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemStopPinJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemStopPin itemStopPin;
    private ItemStopPinTemp itemStopPinTemp;
    private List <ItemStopPinTemp> listItemStopPinTemp;
    private ItemStopPin searchItemStopPin = new ItemStopPin();
    private List <ItemStopPin> listItemStopPin;
    private String itemStopPinSearchCode = "";
    private String itemStopPinSearchName = "";
    private String itemStopPinSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemStopPinActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-data")
    public String findData() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            ListPaging <ItemStopPinTemp> listPaging = itemStopPinBLL.findData(itemStopPinSearchCode,itemStopPinSearchName,itemStopPinSearchActiveStatus,paging);
            
            listItemStopPinTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-get-data")
    public String findData1() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            this.itemStopPinTemp = itemStopPinBLL.findData(this.itemStopPin.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-get")
    public String findData2() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            this.itemStopPinTemp = itemStopPinBLL.findData(this.itemStopPin.getCode(),this.itemStopPin.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-authority")
    public String itemStopPinAuthority(){
        try{
            
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStopPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStopPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStopPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-stop-pin-search")
    public String search() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            
            ListPaging <ItemStopPin> listPaging = itemStopPinBLL.search(paging, searchItemStopPin.getCode(), searchItemStopPin.getName(), searchItemStopPinActiveStatus);
            
            listItemStopPin = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-stop-pin-save")
    public String save() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            
          itemStopPin.setInActiveDate(commonFunction.setDateTime(itemStopPinTemp.getInActiveDateTemp()));
         itemStopPin.setCreatedDate(commonFunction.setDateTime(itemStopPinTemp.getCreatedDateTemp()));
            
            if(itemStopPinBLL.isExist(this.itemStopPin.getCode())){
                this.errorMessage = "CODE "+this.itemStopPin.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemStopPinBLL.save(this.itemStopPin);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemStopPin.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-update")
    public String update() {
        try {
            ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            itemStopPin.setInActiveDate(commonFunction.setDateTime(itemStopPinTemp.getInActiveDateTemp()));
            itemStopPin.setCreatedDate(commonFunction.setDateTime(itemStopPinTemp.getCreatedDateTemp()));
            itemStopPinBLL.update(this.itemStopPin);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemStopPin.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stop-pin-delete")
    public String delete() {
        try {
           ItemStopPinBLL itemStopPinBLL = new ItemStopPinBLL(hbmSession);
            itemStopPinBLL.delete(this.itemStopPin.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemStopPin.getCode();
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

    public ItemStopPin getItemStopPin() {
        return itemStopPin;
    }

    public void setItemStopPin(ItemStopPin itemStopPin) {
        this.itemStopPin = itemStopPin;
    }

    public ItemStopPinTemp getItemStopPinTemp() {
        return itemStopPinTemp;
    }

    public void setItemStopPinTemp(ItemStopPinTemp itemStopPinTemp) {
        this.itemStopPinTemp = itemStopPinTemp;
    }

    public List<ItemStopPinTemp> getListItemStopPinTemp() {
        return listItemStopPinTemp;
    }

    public void setListItemStopPinTemp(List<ItemStopPinTemp> listItemStopPinTemp) {
        this.listItemStopPinTemp = listItemStopPinTemp;
    }

    public String getItemStopPinSearchCode() {
        return itemStopPinSearchCode;
    }

    public void setItemStopPinSearchCode(String itemStopPinSearchCode) {
        this.itemStopPinSearchCode = itemStopPinSearchCode;
    }

    public String getItemStopPinSearchName() {
        return itemStopPinSearchName;
    }

    public void setItemStopPinSearchName(String itemStopPinSearchName) {
        this.itemStopPinSearchName = itemStopPinSearchName;
    }

    public String getItemStopPinSearchActiveStatus() {
        return itemStopPinSearchActiveStatus;
    }

    public void setItemStopPinSearchActiveStatus(String itemStopPinSearchActiveStatus) {
        this.itemStopPinSearchActiveStatus = itemStopPinSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public ItemStopPin getSearchItemStopPin() {
        return searchItemStopPin;
    }

    public void setSearchItemStopPin(ItemStopPin searchItemStopPin) {
        this.searchItemStopPin = searchItemStopPin;
    }

    public EnumTriState.Enum_TriState getSearchItemStopPinActiveStatus() {
        return searchItemStopPinActiveStatus;
    }

    public void setSearchItemStopPinActiveStatus(EnumTriState.Enum_TriState searchItemStopPinActiveStatus) {
        this.searchItemStopPinActiveStatus = searchItemStopPinActiveStatus;
    }

    public List<ItemStopPin> getListItemStopPin() {
        return listItemStopPin;
    }

    public void setListItemStopPin(List<ItemStopPin> listItemStopPin) {
        this.listItemStopPin = listItemStopPin;
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
