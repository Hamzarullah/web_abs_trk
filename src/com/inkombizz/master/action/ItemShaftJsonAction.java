
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

import com.inkombizz.master.bll.ItemShaftBLL;
import com.inkombizz.master.bll.ItemShaftBLL;
import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.ItemShaftTemp;
import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.ItemShaft;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemShaftJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemShaft itemShaft;
    private ItemShaftTemp itemShaftTemp;
    private List <ItemShaftTemp> listItemShaftTemp;
    private ItemShaft searchItemShaft = new ItemShaft();
    private List <ItemShaft> listItemShaft;
    private String itemShaftSearchCode = "";
    private String itemShaftSearchName = "";
    private String itemShaftSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemShaftActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-data")
    public String findData() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            ListPaging <ItemShaftTemp> listPaging = itemShaftBLL.findData(itemShaftSearchCode,itemShaftSearchName,itemShaftSearchActiveStatus,paging);
            
            listItemShaftTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-get-data")
    public String findData1() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            this.itemShaftTemp = itemShaftBLL.findData(this.itemShaft.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-get")
    public String findData2() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            this.itemShaftTemp = itemShaftBLL.findData(this.itemShaft.getCode(),this.itemShaft.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-authority")
    public String itemShaftAuthority(){
        try{
            
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemShaftBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemShaftBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemShaftBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-shaft-search")
    public String search() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            
            ListPaging <ItemShaft> listPaging = itemShaftBLL.search(paging, searchItemShaft.getCode(), searchItemShaft.getName(), searchItemShaftActiveStatus);
            
            listItemShaft = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-shaft-save")
    public String save() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            
          itemShaft.setInActiveDate(commonFunction.setDateTime(itemShaftTemp.getInActiveDateTemp()));
         itemShaft.setCreatedDate(commonFunction.setDateTime(itemShaftTemp.getCreatedDateTemp()));
            
            if(itemShaftBLL.isExist(this.itemShaft.getCode())){
                this.errorMessage = "CODE "+this.itemShaft.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemShaftBLL.save(this.itemShaft);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemShaft.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-update")
    public String update() {
        try {
            ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            itemShaft.setInActiveDate(commonFunction.setDateTime(itemShaftTemp.getInActiveDateTemp()));
            itemShaft.setCreatedDate(commonFunction.setDateTime(itemShaftTemp.getCreatedDateTemp()));
            itemShaftBLL.update(this.itemShaft);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemShaft.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-shaft-delete")
    public String delete() {
        try {
           ItemShaftBLL itemShaftBLL = new ItemShaftBLL(hbmSession);
            itemShaftBLL.delete(this.itemShaft.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemShaft.getCode();
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

    public ItemShaft getItemShaft() {
        return itemShaft;
    }

    public void setItemShaft(ItemShaft itemShaft) {
        this.itemShaft = itemShaft;
    }

    public ItemShaftTemp getItemShaftTemp() {
        return itemShaftTemp;
    }

    public void setItemShaftTemp(ItemShaftTemp itemShaftTemp) {
        this.itemShaftTemp = itemShaftTemp;
    }

    public List<ItemShaftTemp> getListItemShaftTemp() {
        return listItemShaftTemp;
    }

    public void setListItemShaftTemp(List<ItemShaftTemp> listItemShaftTemp) {
        this.listItemShaftTemp = listItemShaftTemp;
    }

    public String getItemShaftSearchCode() {
        return itemShaftSearchCode;
    }

    public void setItemShaftSearchCode(String itemShaftSearchCode) {
        this.itemShaftSearchCode = itemShaftSearchCode;
    }

    public String getItemShaftSearchName() {
        return itemShaftSearchName;
    }

    public void setItemShaftSearchName(String itemShaftSearchName) {
        this.itemShaftSearchName = itemShaftSearchName;
    }

    public String getItemShaftSearchActiveStatus() {
        return itemShaftSearchActiveStatus;
    }

    public void setItemShaftSearchActiveStatus(String itemShaftSearchActiveStatus) {
        this.itemShaftSearchActiveStatus = itemShaftSearchActiveStatus;
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

    public ItemShaft getSearchItemShaft() {
        return searchItemShaft;
    }

    public void setSearchItemShaft(ItemShaft searchItemShaft) {
        this.searchItemShaft = searchItemShaft;
    }

    public EnumTriState.Enum_TriState getSearchItemShaftActiveStatus() {
        return searchItemShaftActiveStatus;
    }

    public void setSearchItemShaftActiveStatus(EnumTriState.Enum_TriState searchItemShaftActiveStatus) {
        this.searchItemShaftActiveStatus = searchItemShaftActiveStatus;
    }

    public List<ItemShaft> getListItemShaft() {
        return listItemShaft;
    }

    public void setListItemShaft(List<ItemShaft> listItemShaft) {
        this.listItemShaft = listItemShaft;
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
