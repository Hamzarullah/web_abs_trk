
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

import com.inkombizz.master.bll.ItemArmPinBLL;
import com.inkombizz.master.bll.ItemArmPinBLL;
import com.inkombizz.master.model.ItemArmPin;
import com.inkombizz.master.model.ItemArmPinTemp;
import com.inkombizz.master.model.ItemArmPin;
import com.inkombizz.master.model.ItemArmPin;
import com.inkombizz.master.model.ItemArmPin;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemArmPinJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemArmPin itemArmPin;
    private ItemArmPinTemp itemArmPinTemp;
    private List <ItemArmPinTemp> listItemArmPinTemp;
    private ItemArmPin searchItemArmPin = new ItemArmPin();
    private List <ItemArmPin> listItemArmPin;
    private String itemArmPinSearchCode = "";
    private String itemArmPinSearchName = "";
    private String itemArmPinSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemArmPinActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-data")
    public String findData() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            ListPaging <ItemArmPinTemp> listPaging = itemArmPinBLL.findData(itemArmPinSearchCode,itemArmPinSearchName,itemArmPinSearchActiveStatus,paging);
            
            listItemArmPinTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-get-data")
    public String findData1() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            this.itemArmPinTemp = itemArmPinBLL.findData(this.itemArmPin.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-get")
    public String findData2() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            this.itemArmPinTemp = itemArmPinBLL.findData(this.itemArmPin.getCode(),this.itemArmPin.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-authority")
    public String itemArmPinAuthority(){
        try{
            
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmPinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-arm-pin-search")
    public String search() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            
            ListPaging <ItemArmPin> listPaging = itemArmPinBLL.search(paging, searchItemArmPin.getCode(), searchItemArmPin.getName(), searchItemArmPinActiveStatus);
            
            listItemArmPin = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-arm-pin-save")
    public String save() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            
          itemArmPin.setInActiveDate(commonFunction.setDateTime(itemArmPinTemp.getInActiveDateTemp()));
         itemArmPin.setCreatedDate(commonFunction.setDateTime(itemArmPinTemp.getCreatedDateTemp()));
            
            if(itemArmPinBLL.isExist(this.itemArmPin.getCode())){
                this.errorMessage = "CODE "+this.itemArmPin.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemArmPinBLL.save(this.itemArmPin);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemArmPin.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-update")
    public String update() {
        try {
            ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            itemArmPin.setInActiveDate(commonFunction.setDateTime(itemArmPinTemp.getInActiveDateTemp()));
            itemArmPin.setCreatedDate(commonFunction.setDateTime(itemArmPinTemp.getCreatedDateTemp()));
            itemArmPinBLL.update(this.itemArmPin);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemArmPin.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-pin-delete")
    public String delete() {
        try {
           ItemArmPinBLL itemArmPinBLL = new ItemArmPinBLL(hbmSession);
            itemArmPinBLL.delete(this.itemArmPin.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemArmPin.getCode();
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

    public ItemArmPin getItemArmPin() {
        return itemArmPin;
    }

    public void setItemArmPin(ItemArmPin itemArmPin) {
        this.itemArmPin = itemArmPin;
    }

    public ItemArmPinTemp getItemArmPinTemp() {
        return itemArmPinTemp;
    }

    public void setItemArmPinTemp(ItemArmPinTemp itemArmPinTemp) {
        this.itemArmPinTemp = itemArmPinTemp;
    }

    public List<ItemArmPinTemp> getListItemArmPinTemp() {
        return listItemArmPinTemp;
    }

    public void setListItemArmPinTemp(List<ItemArmPinTemp> listItemArmPinTemp) {
        this.listItemArmPinTemp = listItemArmPinTemp;
    }

    public String getItemArmPinSearchCode() {
        return itemArmPinSearchCode;
    }

    public void setItemArmPinSearchCode(String itemArmPinSearchCode) {
        this.itemArmPinSearchCode = itemArmPinSearchCode;
    }

    public String getItemArmPinSearchName() {
        return itemArmPinSearchName;
    }

    public void setItemArmPinSearchName(String itemArmPinSearchName) {
        this.itemArmPinSearchName = itemArmPinSearchName;
    }

    public String getItemArmPinSearchActiveStatus() {
        return itemArmPinSearchActiveStatus;
    }

    public void setItemArmPinSearchActiveStatus(String itemArmPinSearchActiveStatus) {
        this.itemArmPinSearchActiveStatus = itemArmPinSearchActiveStatus;
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

    public ItemArmPin getSearchItemArmPin() {
        return searchItemArmPin;
    }

    public void setSearchItemArmPin(ItemArmPin searchItemArmPin) {
        this.searchItemArmPin = searchItemArmPin;
    }

    public EnumTriState.Enum_TriState getSearchItemArmPinActiveStatus() {
        return searchItemArmPinActiveStatus;
    }

    public void setSearchItemArmPinActiveStatus(EnumTriState.Enum_TriState searchItemArmPinActiveStatus) {
        this.searchItemArmPinActiveStatus = searchItemArmPinActiveStatus;
    }

    public List<ItemArmPin> getListItemArmPin() {
        return listItemArmPin;
    }

    public void setListItemArmPin(List<ItemArmPin> listItemArmPin) {
        this.listItemArmPin = listItemArmPin;
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
