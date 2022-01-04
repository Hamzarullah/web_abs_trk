
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

import com.inkombizz.master.bll.ItemDivisionBLL;
import com.inkombizz.master.model.ItemDivision;
import com.inkombizz.master.model.ItemDivisionTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemDivisionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemDivision itemDivision;
    private ItemDivisionTemp itemDivisionTemp;
    private List <ItemDivisionTemp> listItemDivisionTemp;
    private String itemDivisionSearchCode = "";
    private String itemDivisionSearchName = "";
    private String itemDivisionSearchActiveStatus="true";
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
    
    @Action("item-division-data")
    public String findData() {
        try {
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            ListPaging <ItemDivisionTemp> listPaging = itemDivisionBLL.findData(itemDivisionSearchCode,itemDivisionSearchName,itemDivisionSearchActiveStatus,paging);
            
            listItemDivisionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-division-get-data")
    public String findData1() {
        try {
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            this.itemDivisionTemp = itemDivisionBLL.findData(this.itemDivision.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-division-get")
    public String findData2() {
        try {
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            this.itemDivisionTemp = itemDivisionBLL.findData(this.itemDivision.getCode(),this.itemDivision.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-division-authority")
    public String itemDivisionAuthority(){
        try{
            
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDivisionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-division-save")
    public String save() {
        try {
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            
            itemDivision.setInActiveDate(commonFunction.setDateTime(itemDivisionTemp.getInActiveDateTemp()));
            itemDivision.setCreatedDate(commonFunction.setDateTime(itemDivisionTemp.getCreatedDateTemp()));
            
            if(itemDivisionBLL.isExist(this.itemDivision.getCode())){
                this.errorMessage = "CODE "+this.itemDivision.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemDivisionBLL.save(this.itemDivision);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemDivision.getCode();
            }
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-division-update")
    public String update() {
        try {
            ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            itemDivision.setInActiveDate(commonFunction.setDateTime(itemDivisionTemp.getInActiveDateTemp()));
            itemDivision.setCreatedDate(commonFunction.setDateTime(itemDivisionTemp.getCreatedDateTemp()));
            itemDivisionBLL.update(this.itemDivision);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemDivision.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-division-delete")
    public String delete() {
        try {
           ItemDivisionBLL itemDivisionBLL = new ItemDivisionBLL(hbmSession);
            itemDivisionBLL.delete(this.itemDivision.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemDivision.getCode();
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

    public ItemDivision getItemDivision() {
        return itemDivision;
    }

    public void setItemDivision(ItemDivision itemDivision) {
        this.itemDivision = itemDivision;
    }

    public ItemDivisionTemp getItemDivisionTemp() {
        return itemDivisionTemp;
    }

    public void setItemDivisionTemp(ItemDivisionTemp itemDivisionTemp) {
        this.itemDivisionTemp = itemDivisionTemp;
    }

    public List<ItemDivisionTemp> getListItemDivisionTemp() {
        return listItemDivisionTemp;
    }

    public void setListItemDivisionTemp(List<ItemDivisionTemp> listItemDivisionTemp) {
        this.listItemDivisionTemp = listItemDivisionTemp;
    }

    public String getItemDivisionSearchCode() {
        return itemDivisionSearchCode;
    }

    public void setItemDivisionSearchCode(String itemDivisionSearchCode) {
        this.itemDivisionSearchCode = itemDivisionSearchCode;
    }

    public String getItemDivisionSearchName() {
        return itemDivisionSearchName;
    }

    public void setItemDivisionSearchName(String itemDivisionSearchName) {
        this.itemDivisionSearchName = itemDivisionSearchName;
    }

    public String getItemDivisionSearchActiveStatus() {
        return itemDivisionSearchActiveStatus;
    }

    public void setItemDivisionSearchActiveStatus(String itemDivisionSearchActiveStatus) {
        this.itemDivisionSearchActiveStatus = itemDivisionSearchActiveStatus;
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
