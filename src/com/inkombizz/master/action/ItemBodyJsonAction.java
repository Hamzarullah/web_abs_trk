
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

import com.inkombizz.master.bll.ItemBodyBLL;
import com.inkombizz.master.model.ItemBody;
import com.inkombizz.master.model.ItemBodyTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBodyJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBody itemBody;
    private ItemBodyTemp itemBodyTemp;
    private List <ItemBodyTemp> listItemBodyTemp;
    private String itemBodySearchCode = "";
    private String itemBodySearchName = "";
    private String itemBodySearchActiveStatus="true";
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
    
    @Action("item-body-data")
    public String findData() {
        try {
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            ListPaging <ItemBodyTemp> listPaging = itemBodyBLL.findData(itemBodySearchCode,itemBodySearchName,itemBodySearchActiveStatus,paging);
            
            listItemBodyTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-get-data")
    public String findData1() {
        try {
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            this.itemBodyTemp = itemBodyBLL.findData(this.itemBody.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-get")
    public String findData2() {
        try {
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            this.itemBodyTemp = itemBodyBLL.findData(this.itemBody.getCode(),this.itemBody.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-authority")
    public String itemBodyAuthority(){
        try{
            
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-body-save")
    public String save() {
        try {
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            
          itemBody.setInActiveDate(commonFunction.setDateTime(itemBodyTemp.getInActiveDateTemp()));
         itemBody.setCreatedDate(commonFunction.setDateTime(itemBodyTemp.getCreatedDateTemp()));
            
            if(itemBodyBLL.isExist(this.itemBody.getCode())){
                this.errorMessage = "CODE "+this.itemBody.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBodyBLL.save(this.itemBody);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBody.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-update")
    public String update() {
        try {
            ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            itemBody.setInActiveDate(commonFunction.setDateTime(itemBodyTemp.getInActiveDateTemp()));
            itemBody.setCreatedDate(commonFunction.setDateTime(itemBodyTemp.getCreatedDateTemp()));
            itemBodyBLL.update(this.itemBody);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBody.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-delete")
    public String delete() {
        try {
           ItemBodyBLL itemBodyBLL = new ItemBodyBLL(hbmSession);
            itemBodyBLL.delete(this.itemBody.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBody.getCode();
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

    public ItemBody getItemBody() {
        return itemBody;
    }

    public void setItemBody(ItemBody itemBody) {
        this.itemBody = itemBody;
    }

    public ItemBodyTemp getItemBodyTemp() {
        return itemBodyTemp;
    }

    public void setItemBodyTemp(ItemBodyTemp itemBodyTemp) {
        this.itemBodyTemp = itemBodyTemp;
    }

    public List<ItemBodyTemp> getListItemBodyTemp() {
        return listItemBodyTemp;
    }

    public void setListItemBodyTemp(List<ItemBodyTemp> listItemBodyTemp) {
        this.listItemBodyTemp = listItemBodyTemp;
    }

    public String getItemBodySearchCode() {
        return itemBodySearchCode;
    }

    public void setItemBodySearchCode(String itemBodySearchCode) {
        this.itemBodySearchCode = itemBodySearchCode;
    }

    public String getItemBodySearchName() {
        return itemBodySearchName;
    }

    public void setItemBodySearchName(String itemBodySearchName) {
        this.itemBodySearchName = itemBodySearchName;
    }

    public String getItemBodySearchActiveStatus() {
        return itemBodySearchActiveStatus;
    }

    public void setItemBodySearchActiveStatus(String itemBodySearchActiveStatus) {
        this.itemBodySearchActiveStatus = itemBodySearchActiveStatus;
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
