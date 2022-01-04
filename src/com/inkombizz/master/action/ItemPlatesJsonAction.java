
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

import com.inkombizz.master.bll.ItemPlatesBLL;
import com.inkombizz.master.bll.ItemPlatesBLL;
import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.ItemPlatesTemp;
import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.ItemPlates;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemPlatesJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemPlates itemPlates;
    private ItemPlatesTemp itemPlatesTemp;
    private List <ItemPlatesTemp> listItemPlatesTemp;
    private ItemPlates searchItemPlates = new ItemPlates();
    private List <ItemPlates> listItemPlates;
    private String itemPlatesSearchCode = "";
    private String itemPlatesSearchName = "";
    private String itemPlatesSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemPlatesActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-plates-data")
    public String findData() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            ListPaging <ItemPlatesTemp> listPaging = itemPlatesBLL.findData(itemPlatesSearchCode,itemPlatesSearchName,itemPlatesSearchActiveStatus,paging);
            
            listItemPlatesTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-plates-get-data")
    public String findData1() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            this.itemPlatesTemp = itemPlatesBLL.findData(this.itemPlates.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-plates-get")
    public String findData2() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            this.itemPlatesTemp = itemPlatesBLL.findData(this.itemPlates.getCode(),this.itemPlates.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-plates-authority")
    public String itemPlatesAuthority(){
        try{
            
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemPlatesBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemPlatesBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemPlatesBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-plates-search")
    public String search() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            
            ListPaging <ItemPlates> listPaging = itemPlatesBLL.search(paging, searchItemPlates.getCode(), searchItemPlates.getName(), searchItemPlatesActiveStatus);
            
            listItemPlates = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-plates-save")
    public String save() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            
          itemPlates.setInActiveDate(commonFunction.setDateTime(itemPlatesTemp.getInActiveDateTemp()));
         itemPlates.setCreatedDate(commonFunction.setDateTime(itemPlatesTemp.getCreatedDateTemp()));
            
            if(itemPlatesBLL.isExist(this.itemPlates.getCode())){
                this.errorMessage = "CODE "+this.itemPlates.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemPlatesBLL.save(this.itemPlates);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemPlates.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-plates-update")
    public String update() {
        try {
            ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            itemPlates.setInActiveDate(commonFunction.setDateTime(itemPlatesTemp.getInActiveDateTemp()));
            itemPlates.setCreatedDate(commonFunction.setDateTime(itemPlatesTemp.getCreatedDateTemp()));
            itemPlatesBLL.update(this.itemPlates);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemPlates.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-plates-delete")
    public String delete() {
        try {
           ItemPlatesBLL itemPlatesBLL = new ItemPlatesBLL(hbmSession);
            itemPlatesBLL.delete(this.itemPlates.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemPlates.getCode();
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

    public ItemPlates getItemPlates() {
        return itemPlates;
    }

    public void setItemPlates(ItemPlates itemPlates) {
        this.itemPlates = itemPlates;
    }

    public ItemPlatesTemp getItemPlatesTemp() {
        return itemPlatesTemp;
    }

    public void setItemPlatesTemp(ItemPlatesTemp itemPlatesTemp) {
        this.itemPlatesTemp = itemPlatesTemp;
    }

    public List<ItemPlatesTemp> getListItemPlatesTemp() {
        return listItemPlatesTemp;
    }

    public void setListItemPlatesTemp(List<ItemPlatesTemp> listItemPlatesTemp) {
        this.listItemPlatesTemp = listItemPlatesTemp;
    }

    public String getItemPlatesSearchCode() {
        return itemPlatesSearchCode;
    }

    public void setItemPlatesSearchCode(String itemPlatesSearchCode) {
        this.itemPlatesSearchCode = itemPlatesSearchCode;
    }

    public String getItemPlatesSearchName() {
        return itemPlatesSearchName;
    }

    public void setItemPlatesSearchName(String itemPlatesSearchName) {
        this.itemPlatesSearchName = itemPlatesSearchName;
    }

    public String getItemPlatesSearchActiveStatus() {
        return itemPlatesSearchActiveStatus;
    }

    public void setItemPlatesSearchActiveStatus(String itemPlatesSearchActiveStatus) {
        this.itemPlatesSearchActiveStatus = itemPlatesSearchActiveStatus;
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

    public ItemPlates getSearchItemPlates() {
        return searchItemPlates;
    }

    public void setSearchItemPlates(ItemPlates searchItemPlates) {
        this.searchItemPlates = searchItemPlates;
    }

    public EnumTriState.Enum_TriState getSearchItemPlatesActiveStatus() {
        return searchItemPlatesActiveStatus;
    }

    public void setSearchItemPlatesActiveStatus(EnumTriState.Enum_TriState searchItemPlatesActiveStatus) {
        this.searchItemPlatesActiveStatus = searchItemPlatesActiveStatus;
    }

    public List<ItemPlates> getListItemPlates() {
        return listItemPlates;
    }

    public void setListItemPlates(List<ItemPlates> listItemPlates) {
        this.listItemPlates = listItemPlates;
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
