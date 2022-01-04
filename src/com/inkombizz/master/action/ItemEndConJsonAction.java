
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

import com.inkombizz.master.bll.ItemEndConBLL;
import com.inkombizz.master.model.ItemEndCon;
import com.inkombizz.master.model.ItemEndConTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemEndConJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemEndCon itemEndCon;
    private ItemEndConTemp itemEndConTemp;
    private List <ItemEndConTemp> listItemEndConTemp;
    private String itemEndConSearchCode = "";
    private String itemEndConSearchName = "";
    private String itemEndConSearchActiveStatus="true";
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
    
    @Action("item-end-con-data")
    public String findData() {
        try {
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            ListPaging <ItemEndConTemp> listPaging = itemEndConBLL.findData(itemEndConSearchCode,itemEndConSearchName,itemEndConSearchActiveStatus,paging);
            
            listItemEndConTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-end-con-get-data")
    public String findData1() {
        try {
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            this.itemEndConTemp = itemEndConBLL.findData(this.itemEndCon.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-end-con-get")
    public String findData2() {
        try {
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            this.itemEndConTemp = itemEndConBLL.findData(this.itemEndCon.getCode(),this.itemEndCon.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-end-con-authority")
    public String itemEndConAuthority(){
        try{
            
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemEndConBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemEndConBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemEndConBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-end-con-save")
    public String save() {
        try {
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            
          itemEndCon.setInActiveDate(commonFunction.setDateTime(itemEndConTemp.getInActiveDateTemp()));
         itemEndCon.setCreatedDate(commonFunction.setDateTime(itemEndConTemp.getCreatedDateTemp()));
            
            if(itemEndConBLL.isExist(this.itemEndCon.getCode())){
                this.errorMessage = "CODE "+this.itemEndCon.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemEndConBLL.save(this.itemEndCon);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemEndCon.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-end-con-update")
    public String update() {
        try {
            ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            itemEndCon.setInActiveDate(commonFunction.setDateTime(itemEndConTemp.getInActiveDateTemp()));
            itemEndCon.setCreatedDate(commonFunction.setDateTime(itemEndConTemp.getCreatedDateTemp()));
            itemEndConBLL.update(this.itemEndCon);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemEndCon.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-end-con-delete")
    public String delete() {
        try {
           ItemEndConBLL itemEndConBLL = new ItemEndConBLL(hbmSession);
            itemEndConBLL.delete(this.itemEndCon.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemEndCon.getCode();
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

    public ItemEndCon getItemEndCon() {
        return itemEndCon;
    }

    public void setItemEndCon(ItemEndCon itemEndCon) {
        this.itemEndCon = itemEndCon;
    }

    public ItemEndConTemp getItemEndConTemp() {
        return itemEndConTemp;
    }

    public void setItemEndConTemp(ItemEndConTemp itemEndConTemp) {
        this.itemEndConTemp = itemEndConTemp;
    }

    public List<ItemEndConTemp> getListItemEndConTemp() {
        return listItemEndConTemp;
    }

    public void setListItemEndConTemp(List<ItemEndConTemp> listItemEndConTemp) {
        this.listItemEndConTemp = listItemEndConTemp;
    }

    public String getItemEndConSearchCode() {
        return itemEndConSearchCode;
    }

    public void setItemEndConSearchCode(String itemEndConSearchCode) {
        this.itemEndConSearchCode = itemEndConSearchCode;
    }

    public String getItemEndConSearchName() {
        return itemEndConSearchName;
    }

    public void setItemEndConSearchName(String itemEndConSearchName) {
        this.itemEndConSearchName = itemEndConSearchName;
    }

    public String getItemEndConSearchActiveStatus() {
        return itemEndConSearchActiveStatus;
    }

    public void setItemEndConSearchActiveStatus(String itemEndConSearchActiveStatus) {
        this.itemEndConSearchActiveStatus = itemEndConSearchActiveStatus;
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
