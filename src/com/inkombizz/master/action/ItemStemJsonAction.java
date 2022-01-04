
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

import com.inkombizz.master.bll.ItemStemBLL;
import com.inkombizz.master.model.ItemStem;
import com.inkombizz.master.model.ItemStemTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemStemJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemStem itemStem;
    private ItemStemTemp itemStemTemp;
    private List <ItemStemTemp> listItemStemTemp;
    private String itemStemSearchCode = "";
    private String itemStemSearchName = "";
    private String itemStemSearchActiveStatus="true";
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
    
    @Action("item-stem-data")
    public String findData() {
        try {
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            ListPaging <ItemStemTemp> listPaging = itemStemBLL.findData(itemStemSearchCode,itemStemSearchName,itemStemSearchActiveStatus,paging);
            
            listItemStemTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stem-get-data")
    public String findData1() {
        try {
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            this.itemStemTemp = itemStemBLL.findData(this.itemStem.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stem-get")
    public String findData2() {
        try {
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            this.itemStemTemp = itemStemBLL.findData(this.itemStem.getCode(),this.itemStem.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stem-authority")
    public String itemStemAuthority(){
        try{
            
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemStemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-stem-save")
    public String save() {
        try {
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            
          itemStem.setInActiveDate(commonFunction.setDateTime(itemStemTemp.getInActiveDateTemp()));
         itemStem.setCreatedDate(commonFunction.setDateTime(itemStemTemp.getCreatedDateTemp()));
            
            if(itemStemBLL.isExist(this.itemStem.getCode())){
                this.errorMessage = "CODE "+this.itemStem.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemStemBLL.save(this.itemStem);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemStem.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stem-update")
    public String update() {
        try {
            ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            itemStem.setInActiveDate(commonFunction.setDateTime(itemStemTemp.getInActiveDateTemp()));
            itemStem.setCreatedDate(commonFunction.setDateTime(itemStemTemp.getCreatedDateTemp()));
            itemStemBLL.update(this.itemStem);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemStem.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-stem-delete")
    public String delete() {
        try {
           ItemStemBLL itemStemBLL = new ItemStemBLL(hbmSession);
            itemStemBLL.delete(this.itemStem.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemStem.getCode();
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

    public ItemStem getItemStem() {
        return itemStem;
    }

    public void setItemStem(ItemStem itemStem) {
        this.itemStem = itemStem;
    }

    public ItemStemTemp getItemStemTemp() {
        return itemStemTemp;
    }

    public void setItemStemTemp(ItemStemTemp itemStemTemp) {
        this.itemStemTemp = itemStemTemp;
    }

    public List<ItemStemTemp> getListItemStemTemp() {
        return listItemStemTemp;
    }

    public void setListItemStemTemp(List<ItemStemTemp> listItemStemTemp) {
        this.listItemStemTemp = listItemStemTemp;
    }

    public String getItemStemSearchCode() {
        return itemStemSearchCode;
    }

    public void setItemStemSearchCode(String itemStemSearchCode) {
        this.itemStemSearchCode = itemStemSearchCode;
    }

    public String getItemStemSearchName() {
        return itemStemSearchName;
    }

    public void setItemStemSearchName(String itemStemSearchName) {
        this.itemStemSearchName = itemStemSearchName;
    }

    public String getItemStemSearchActiveStatus() {
        return itemStemSearchActiveStatus;
    }

    public void setItemStemSearchActiveStatus(String itemStemSearchActiveStatus) {
        this.itemStemSearchActiveStatus = itemStemSearchActiveStatus;
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
