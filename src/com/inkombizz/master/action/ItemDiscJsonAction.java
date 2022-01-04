
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

import com.inkombizz.master.bll.ItemDiscBLL;
import com.inkombizz.master.bll.ItemDiscBLL;
import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.ItemDiscTemp;
import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.ItemDisc;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemDiscJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemDisc itemDisc;
    private ItemDiscTemp itemDiscTemp;
    private List <ItemDiscTemp> listItemDiscTemp;
    private ItemDisc searchItemDisc = new ItemDisc();
    private List <ItemDisc> listItemDisc;
    private String itemDiscSearchCode = "";
    private String itemDiscSearchName = "";
    private String itemDiscSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemDiscActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-disc-data")
    public String findData() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            ListPaging <ItemDiscTemp> listPaging = itemDiscBLL.findData(itemDiscSearchCode,itemDiscSearchName,itemDiscSearchActiveStatus,paging);
            
            listItemDiscTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-disc-get-data")
    public String findData1() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            this.itemDiscTemp = itemDiscBLL.findData(this.itemDisc.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-disc-get")
    public String findData2() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            this.itemDiscTemp = itemDiscBLL.findData(this.itemDisc.getCode(),this.itemDisc.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-disc-authority")
    public String itemDiscAuthority(){
        try{
            
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDiscBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDiscBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemDiscBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-disc-search")
    public String search() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            
            ListPaging <ItemDisc> listPaging = itemDiscBLL.search(paging, searchItemDisc.getCode(), searchItemDisc.getName(), searchItemDiscActiveStatus);
            
            listItemDisc = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-disc-save")
    public String save() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            
          itemDisc.setInActiveDate(commonFunction.setDateTime(itemDiscTemp.getInActiveDateTemp()));
         itemDisc.setCreatedDate(commonFunction.setDateTime(itemDiscTemp.getCreatedDateTemp()));
            
            if(itemDiscBLL.isExist(this.itemDisc.getCode())){
                this.errorMessage = "CODE "+this.itemDisc.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemDiscBLL.save(this.itemDisc);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemDisc.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-disc-update")
    public String update() {
        try {
            ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            itemDisc.setInActiveDate(commonFunction.setDateTime(itemDiscTemp.getInActiveDateTemp()));
            itemDisc.setCreatedDate(commonFunction.setDateTime(itemDiscTemp.getCreatedDateTemp()));
            itemDiscBLL.update(this.itemDisc);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemDisc.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-disc-delete")
    public String delete() {
        try {
           ItemDiscBLL itemDiscBLL = new ItemDiscBLL(hbmSession);
            itemDiscBLL.delete(this.itemDisc.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemDisc.getCode();
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

    public ItemDisc getItemDisc() {
        return itemDisc;
    }

    public void setItemDisc(ItemDisc itemDisc) {
        this.itemDisc = itemDisc;
    }

    public ItemDiscTemp getItemDiscTemp() {
        return itemDiscTemp;
    }

    public void setItemDiscTemp(ItemDiscTemp itemDiscTemp) {
        this.itemDiscTemp = itemDiscTemp;
    }

    public List<ItemDiscTemp> getListItemDiscTemp() {
        return listItemDiscTemp;
    }

    public void setListItemDiscTemp(List<ItemDiscTemp> listItemDiscTemp) {
        this.listItemDiscTemp = listItemDiscTemp;
    }

    public String getItemDiscSearchCode() {
        return itemDiscSearchCode;
    }

    public void setItemDiscSearchCode(String itemDiscSearchCode) {
        this.itemDiscSearchCode = itemDiscSearchCode;
    }

    public String getItemDiscSearchName() {
        return itemDiscSearchName;
    }

    public void setItemDiscSearchName(String itemDiscSearchName) {
        this.itemDiscSearchName = itemDiscSearchName;
    }

    public String getItemDiscSearchActiveStatus() {
        return itemDiscSearchActiveStatus;
    }

    public void setItemDiscSearchActiveStatus(String itemDiscSearchActiveStatus) {
        this.itemDiscSearchActiveStatus = itemDiscSearchActiveStatus;
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

    public ItemDisc getSearchItemDisc() {
        return searchItemDisc;
    }

    public void setSearchItemDisc(ItemDisc searchItemDisc) {
        this.searchItemDisc = searchItemDisc;
    }

    public EnumTriState.Enum_TriState getSearchItemDiscActiveStatus() {
        return searchItemDiscActiveStatus;
    }

    public void setSearchItemDiscActiveStatus(EnumTriState.Enum_TriState searchItemDiscActiveStatus) {
        this.searchItemDiscActiveStatus = searchItemDiscActiveStatus;
    }

    public List<ItemDisc> getListItemDisc() {
        return listItemDisc;
    }

    public void setListItemDisc(List<ItemDisc> listItemDisc) {
        this.listItemDisc = listItemDisc;
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
