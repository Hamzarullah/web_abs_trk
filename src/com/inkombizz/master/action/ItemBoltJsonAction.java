
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

import com.inkombizz.master.bll.ItemBoltBLL;
import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.master.model.ItemBoltTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBoltJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBolt itemBolt;
    private ItemBoltTemp itemBoltTemp;
    private List <ItemBoltTemp> listItemBoltTemp;
    private String itemBoltSearchCode = "";
    private String itemBoltSearchName = "";
    private String itemBoltSearchActiveStatus="true";
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
    
    @Action("item-bolt-data")
    public String findData() {
        try {
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            ListPaging <ItemBoltTemp> listPaging = itemBoltBLL.findData(itemBoltSearchCode,itemBoltSearchName,itemBoltSearchActiveStatus,paging);
            
            listItemBoltTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bolt-get-data")
    public String findData1() {
        try {
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            this.itemBoltTemp = itemBoltBLL.findData(this.itemBolt.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bolt-get")
    public String findData2() {
        try {
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            this.itemBoltTemp = itemBoltBLL.findData(this.itemBolt.getCode(),this.itemBolt.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bolt-authority")
    public String itemBoltAuthority(){
        try{
            
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoltBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoltBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBoltBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-bolt-save")
    public String save() {
        try {
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            
          itemBolt.setInActiveDate(commonFunction.setDateTime(itemBoltTemp.getInActiveDateTemp()));
         itemBolt.setCreatedDate(commonFunction.setDateTime(itemBoltTemp.getCreatedDateTemp()));
            
            if(itemBoltBLL.isExist(this.itemBolt.getCode())){
                this.errorMessage = "CODE "+this.itemBolt.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBoltBLL.save(this.itemBolt);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBolt.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bolt-update")
    public String update() {
        try {
            ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            itemBolt.setInActiveDate(commonFunction.setDateTime(itemBoltTemp.getInActiveDateTemp()));
            itemBolt.setCreatedDate(commonFunction.setDateTime(itemBoltTemp.getCreatedDateTemp()));
            itemBoltBLL.update(this.itemBolt);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBolt.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-bolt-delete")
    public String delete() {
        try {
           ItemBoltBLL itemBoltBLL = new ItemBoltBLL(hbmSession);
            itemBoltBLL.delete(this.itemBolt.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBolt.getCode();
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

    public ItemBolt getItemBolt() {
        return itemBolt;
    }

    public void setItemBolt(ItemBolt itemBolt) {
        this.itemBolt = itemBolt;
    }

    public ItemBoltTemp getItemBoltTemp() {
        return itemBoltTemp;
    }

    public void setItemBoltTemp(ItemBoltTemp itemBoltTemp) {
        this.itemBoltTemp = itemBoltTemp;
    }

    public List<ItemBoltTemp> getListItemBoltTemp() {
        return listItemBoltTemp;
    }

    public void setListItemBoltTemp(List<ItemBoltTemp> listItemBoltTemp) {
        this.listItemBoltTemp = listItemBoltTemp;
    }

    public String getItemBoltSearchCode() {
        return itemBoltSearchCode;
    }

    public void setItemBoltSearchCode(String itemBoltSearchCode) {
        this.itemBoltSearchCode = itemBoltSearchCode;
    }

    public String getItemBoltSearchName() {
        return itemBoltSearchName;
    }

    public void setItemBoltSearchName(String itemBoltSearchName) {
        this.itemBoltSearchName = itemBoltSearchName;
    }

    public String getItemBoltSearchActiveStatus() {
        return itemBoltSearchActiveStatus;
    }

    public void setItemBoltSearchActiveStatus(String itemBoltSearchActiveStatus) {
        this.itemBoltSearchActiveStatus = itemBoltSearchActiveStatus;
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
