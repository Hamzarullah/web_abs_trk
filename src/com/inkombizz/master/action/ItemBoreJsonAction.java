
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

import com.inkombizz.master.bll.ItemBoreBLL;
import com.inkombizz.master.model.ItemBore;
import com.inkombizz.master.model.ItemBoreTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBoreJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBore itemBore;
    private ItemBoreTemp itemBoreTemp;
    private List <ItemBoreTemp> listItemBoreTemp;
    private String itemBoreSearchCode = "";
    private String itemBoreSearchName = "";
    private String itemBoreSearchActiveStatus="true";
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
    
    @Action("item-bore-data")
    public String findData() {
        try {
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            ListPaging <ItemBoreTemp> listPaging = itemBoreBLL.findData(itemBoreSearchCode,itemBoreSearchName,itemBoreSearchActiveStatus,paging);
            
            listItemBoreTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bore-get-data")
    public String findData1() {
        try {
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            this.itemBoreTemp = itemBoreBLL.findData(this.itemBore.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bore-get")
    public String findData2() {
        try {
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            this.itemBoreTemp = itemBoreBLL.findData(this.itemBore.getCode(),this.itemBore.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bore-authority")
    public String itemBoreAuthority(){
        try{
            
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoreBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoreBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoreBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-bore-save")
    public String save() {
        try {
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            
          itemBore.setInActiveDate(commonFunction.setDateTime(itemBoreTemp.getInActiveDateTemp()));
         itemBore.setCreatedDate(commonFunction.setDateTime(itemBoreTemp.getCreatedDateTemp()));
            
            if(itemBoreBLL.isExist(this.itemBore.getCode())){
                this.errorMessage = "CODE "+this.itemBore.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBoreBLL.save(this.itemBore);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBore.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bore-update")
    public String update() {
        try {
            ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            itemBore.setInActiveDate(commonFunction.setDateTime(itemBoreTemp.getInActiveDateTemp()));
            itemBore.setCreatedDate(commonFunction.setDateTime(itemBoreTemp.getCreatedDateTemp()));
            itemBoreBLL.update(this.itemBore);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBore.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bore-delete")
    public String delete() {
        try {
           ItemBoreBLL itemBoreBLL = new ItemBoreBLL(hbmSession);
            itemBoreBLL.delete(this.itemBore.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBore.getCode();
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

    public ItemBore getItemBore() {
        return itemBore;
    }

    public void setItemBore(ItemBore itemBore) {
        this.itemBore = itemBore;
    }

    public ItemBoreTemp getItemBoreTemp() {
        return itemBoreTemp;
    }

    public void setItemBoreTemp(ItemBoreTemp itemBoreTemp) {
        this.itemBoreTemp = itemBoreTemp;
    }

    public List<ItemBoreTemp> getListItemBoreTemp() {
        return listItemBoreTemp;
    }

    public void setListItemBoreTemp(List<ItemBoreTemp> listItemBoreTemp) {
        this.listItemBoreTemp = listItemBoreTemp;
    }

    public String getItemBoreSearchCode() {
        return itemBoreSearchCode;
    }

    public void setItemBoreSearchCode(String itemBoreSearchCode) {
        this.itemBoreSearchCode = itemBoreSearchCode;
    }

    public String getItemBoreSearchName() {
        return itemBoreSearchName;
    }

    public void setItemBoreSearchName(String itemBoreSearchName) {
        this.itemBoreSearchName = itemBoreSearchName;
    }

    public String getItemBoreSearchActiveStatus() {
        return itemBoreSearchActiveStatus;
    }

    public void setItemBoreSearchActiveStatus(String itemBoreSearchActiveStatus) {
        this.itemBoreSearchActiveStatus = itemBoreSearchActiveStatus;
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
