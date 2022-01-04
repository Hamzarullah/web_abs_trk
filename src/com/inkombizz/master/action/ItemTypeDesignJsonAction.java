/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.ItemTypeDesignBLL;
import com.inkombizz.master.model.ItemTypeDesign;
import com.inkombizz.master.model.ItemTypeDesignTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author IKB_DEVOPS
 */

@Result (type="json")
public class ItemTypeDesignJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemTypeDesign itemTypeDesign;
    private ItemTypeDesignTemp itemTypeDesignTemp;
    private List <ItemTypeDesignTemp> listItemTypeDesignTemp;
    private String itemTypeDesignSearchCode = "";
    private String itemTypeDesignSearchName = "";
    private String itemTypeDesignSearchActiveStatus="true";
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
    
    @Action("item-type-design-data")
    public String findData() {
        try {
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            ListPaging <ItemTypeDesignTemp> listPaging = itemTypeDesignBLL.findData(itemTypeDesignSearchCode,itemTypeDesignSearchName,itemTypeDesignSearchActiveStatus,paging);
            
            listItemTypeDesignTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-type-design-get-data")
    public String findData1() {
        try {
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            this.itemTypeDesignTemp = itemTypeDesignBLL.findData(this.itemTypeDesign.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-type-design-get")
    public String findData2() {
        try {
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            this.itemTypeDesignTemp = itemTypeDesignBLL.findData(this.itemTypeDesign.getCode(),this.itemTypeDesign.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-type-design-authority")
    public String itemTypeDesignAuthority(){
        try{
            
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemTypeDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemTypeDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemTypeDesignBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-type-design-save")
    public String save() {
        try {
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            
          itemTypeDesign.setInActiveDate(commonFunction.setDateTime(itemTypeDesignTemp.getInActiveDateTemp()));
         itemTypeDesign.setCreatedDate(commonFunction.setDateTime(itemTypeDesignTemp.getCreatedDateTemp()));
            
            if(itemTypeDesignBLL.isExist(this.itemTypeDesign.getCode())){
                this.errorMessage = "CODE "+this.itemTypeDesign.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemTypeDesignBLL.save(this.itemTypeDesign);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemTypeDesign.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-type-design-update")
    public String update() {
        try {
            ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            itemTypeDesign.setInActiveDate(commonFunction.setDateTime(itemTypeDesignTemp.getInActiveDateTemp()));
            itemTypeDesign.setCreatedDate(commonFunction.setDateTime(itemTypeDesignTemp.getCreatedDateTemp()));
            itemTypeDesignBLL.update(this.itemTypeDesign);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemTypeDesign.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-type-design-delete")
    public String delete() {
        try {
           ItemTypeDesignBLL itemTypeDesignBLL = new ItemTypeDesignBLL(hbmSession);
            itemTypeDesignBLL.delete(this.itemTypeDesign.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemTypeDesign.getCode();
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

    public ItemTypeDesign getItemTypeDesign() {
        return itemTypeDesign;
    }

    public void setItemTypeDesign(ItemTypeDesign itemTypeDesign) {
        this.itemTypeDesign = itemTypeDesign;
    }

    public ItemTypeDesignTemp getItemTypeDesignTemp() {
        return itemTypeDesignTemp;
    }

    public void setItemTypeDesignTemp(ItemTypeDesignTemp itemTypeDesignTemp) {
        this.itemTypeDesignTemp = itemTypeDesignTemp;
    }

    public List<ItemTypeDesignTemp> getListItemTypeDesignTemp() {
        return listItemTypeDesignTemp;
    }

    public void setListItemTypeDesignTemp(List<ItemTypeDesignTemp> listItemTypeDesignTemp) {
        this.listItemTypeDesignTemp = listItemTypeDesignTemp;
    }

    public String getItemTypeDesignSearchCode() {
        return itemTypeDesignSearchCode;
    }

    public void setItemTypeDesignSearchCode(String itemTypeDesignSearchCode) {
        this.itemTypeDesignSearchCode = itemTypeDesignSearchCode;
    }

    public String getItemTypeDesignSearchName() {
        return itemTypeDesignSearchName;
    }

    public void setItemTypeDesignSearchName(String itemTypeDesignSearchName) {
        this.itemTypeDesignSearchName = itemTypeDesignSearchName;
    }

    public String getItemTypeDesignSearchActiveStatus() {
        return itemTypeDesignSearchActiveStatus;
    }

    public void setItemTypeDesignSearchActiveStatus(String itemTypeDesignSearchActiveStatus) {
        this.itemTypeDesignSearchActiveStatus = itemTypeDesignSearchActiveStatus;
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
