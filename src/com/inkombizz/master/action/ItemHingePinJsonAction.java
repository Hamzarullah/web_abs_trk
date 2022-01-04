
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

import com.inkombizz.master.bll.ItemHingePinBLL;
import com.inkombizz.master.bll.ItemHingePinBLL;
import com.inkombizz.master.model.ItemHingePin;
import com.inkombizz.master.model.ItemHingePinTemp;
import com.inkombizz.master.model.ItemHingePin;
import com.inkombizz.master.model.ItemHingePin;
import com.inkombizz.master.model.ItemHingePin;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemHingePinJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemHingePin itemHingePin;
    private ItemHingePinTemp itemHingePinTemp;
    private List <ItemHingePinTemp> listItemHingePinTemp;
    private ItemHingePin searchItemHingePin = new ItemHingePin();
    private List <ItemHingePin> listItemHingePin;
    private String itemHingePinSearchCode = "";
    private String itemHingePinSearchName = "";
    private String itemHingePinSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemHingePinActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-data")
    public String findData() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            ListPaging <ItemHingePinTemp> listPaging = itemHingePinBLL.findData(itemHingePinSearchCode,itemHingePinSearchName,itemHingePinSearchActiveStatus,paging);
            
            listItemHingePinTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-get-data")
    public String findData1() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            this.itemHingePinTemp = itemHingePinBLL.findData(this.itemHingePin.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-get")
    public String findData2() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            this.itemHingePinTemp = itemHingePinBLL.findData(this.itemHingePin.getCode(),this.itemHingePin.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-authority")
    public String itemHingePinAuthority(){
        try{
            
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemHingePinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemHingePinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemHingePinBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-hinge-pin-search")
    public String search() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            
            ListPaging <ItemHingePin> listPaging = itemHingePinBLL.search(paging, searchItemHingePin.getCode(), searchItemHingePin.getName(), searchItemHingePinActiveStatus);
            
            listItemHingePin = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-hinge-pin-save")
    public String save() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            
          itemHingePin.setInActiveDate(commonFunction.setDateTime(itemHingePinTemp.getInActiveDateTemp()));
         itemHingePin.setCreatedDate(commonFunction.setDateTime(itemHingePinTemp.getCreatedDateTemp()));
            
            if(itemHingePinBLL.isExist(this.itemHingePin.getCode())){
                this.errorMessage = "CODE "+this.itemHingePin.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemHingePinBLL.save(this.itemHingePin);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemHingePin.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-update")
    public String update() {
        try {
            ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            itemHingePin.setInActiveDate(commonFunction.setDateTime(itemHingePinTemp.getInActiveDateTemp()));
            itemHingePin.setCreatedDate(commonFunction.setDateTime(itemHingePinTemp.getCreatedDateTemp()));
            itemHingePinBLL.update(this.itemHingePin);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemHingePin.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-hinge-pin-delete")
    public String delete() {
        try {
           ItemHingePinBLL itemHingePinBLL = new ItemHingePinBLL(hbmSession);
            itemHingePinBLL.delete(this.itemHingePin.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemHingePin.getCode();
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

    public ItemHingePin getItemHingePin() {
        return itemHingePin;
    }

    public void setItemHingePin(ItemHingePin itemHingePin) {
        this.itemHingePin = itemHingePin;
    }

    public ItemHingePinTemp getItemHingePinTemp() {
        return itemHingePinTemp;
    }

    public void setItemHingePinTemp(ItemHingePinTemp itemHingePinTemp) {
        this.itemHingePinTemp = itemHingePinTemp;
    }

    public List<ItemHingePinTemp> getListItemHingePinTemp() {
        return listItemHingePinTemp;
    }

    public void setListItemHingePinTemp(List<ItemHingePinTemp> listItemHingePinTemp) {
        this.listItemHingePinTemp = listItemHingePinTemp;
    }

    public String getItemHingePinSearchCode() {
        return itemHingePinSearchCode;
    }

    public void setItemHingePinSearchCode(String itemHingePinSearchCode) {
        this.itemHingePinSearchCode = itemHingePinSearchCode;
    }

    public String getItemHingePinSearchName() {
        return itemHingePinSearchName;
    }

    public void setItemHingePinSearchName(String itemHingePinSearchName) {
        this.itemHingePinSearchName = itemHingePinSearchName;
    }

    public String getItemHingePinSearchActiveStatus() {
        return itemHingePinSearchActiveStatus;
    }

    public void setItemHingePinSearchActiveStatus(String itemHingePinSearchActiveStatus) {
        this.itemHingePinSearchActiveStatus = itemHingePinSearchActiveStatus;
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

    public ItemHingePin getSearchItemHingePin() {
        return searchItemHingePin;
    }

    public void setSearchItemHingePin(ItemHingePin searchItemHingePin) {
        this.searchItemHingePin = searchItemHingePin;
    }

    public EnumTriState.Enum_TriState getSearchItemHingePinActiveStatus() {
        return searchItemHingePinActiveStatus;
    }

    public void setSearchItemHingePinActiveStatus(EnumTriState.Enum_TriState searchItemHingePinActiveStatus) {
        this.searchItemHingePinActiveStatus = searchItemHingePinActiveStatus;
    }

    public List<ItemHingePin> getListItemHingePin() {
        return listItemHingePin;
    }

    public void setListItemHingePin(List<ItemHingePin> listItemHingePin) {
        this.listItemHingePin = listItemHingePin;
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
