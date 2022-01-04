
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

import com.inkombizz.master.bll.ItemSealBLL;
import com.inkombizz.master.model.ItemSeal;
import com.inkombizz.master.model.ItemSealTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSealJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSeal itemSeal;
    private ItemSealTemp itemSealTemp;
    private List <ItemSealTemp> listItemSealTemp;
    private String itemSealSearchCode = "";
    private String itemSealSearchName = "";
    private String itemSealSearchActiveStatus="true";
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
    
    @Action("item-seal-data")
    public String findData() {
        try {
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            ListPaging <ItemSealTemp> listPaging = itemSealBLL.findData(itemSealSearchCode,itemSealSearchName,itemSealSearchActiveStatus,paging);
            
            listItemSealTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seal-get-data")
    public String findData1() {
        try {
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            this.itemSealTemp = itemSealBLL.findData(this.itemSeal.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seal-get")
    public String findData2() {
        try {
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            this.itemSealTemp = itemSealBLL.findData(this.itemSeal.getCode(),this.itemSeal.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seal-authority")
    public String itemSealAuthority(){
        try{
            
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSealBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSealBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSealBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-seal-save")
    public String save() {
        try {
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            
          itemSeal.setInActiveDate(commonFunction.setDateTime(itemSealTemp.getInActiveDateTemp()));
         itemSeal.setCreatedDate(commonFunction.setDateTime(itemSealTemp.getCreatedDateTemp()));
            
            if(itemSealBLL.isExist(this.itemSeal.getCode())){
                this.errorMessage = "CODE "+this.itemSeal.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSealBLL.save(this.itemSeal);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSeal.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seal-update")
    public String update() {
        try {
            ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            itemSeal.setInActiveDate(commonFunction.setDateTime(itemSealTemp.getInActiveDateTemp()));
            itemSeal.setCreatedDate(commonFunction.setDateTime(itemSealTemp.getCreatedDateTemp()));
            itemSealBLL.update(this.itemSeal);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSeal.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-seal-delete")
    public String delete() {
        try {
           ItemSealBLL itemSealBLL = new ItemSealBLL(hbmSession);
            itemSealBLL.delete(this.itemSeal.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSeal.getCode();
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

    public ItemSeal getItemSeal() {
        return itemSeal;
    }

    public void setItemSeal(ItemSeal itemSeal) {
        this.itemSeal = itemSeal;
    }

    public ItemSealTemp getItemSealTemp() {
        return itemSealTemp;
    }

    public void setItemSealTemp(ItemSealTemp itemSealTemp) {
        this.itemSealTemp = itemSealTemp;
    }

    public List<ItemSealTemp> getListItemSealTemp() {
        return listItemSealTemp;
    }

    public void setListItemSealTemp(List<ItemSealTemp> listItemSealTemp) {
        this.listItemSealTemp = listItemSealTemp;
    }

    public String getItemSealSearchCode() {
        return itemSealSearchCode;
    }

    public void setItemSealSearchCode(String itemSealSearchCode) {
        this.itemSealSearchCode = itemSealSearchCode;
    }

    public String getItemSealSearchName() {
        return itemSealSearchName;
    }

    public void setItemSealSearchName(String itemSealSearchName) {
        this.itemSealSearchName = itemSealSearchName;
    }

    public String getItemSealSearchActiveStatus() {
        return itemSealSearchActiveStatus;
    }

    public void setItemSealSearchActiveStatus(String itemSealSearchActiveStatus) {
        this.itemSealSearchActiveStatus = itemSealSearchActiveStatus;
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
