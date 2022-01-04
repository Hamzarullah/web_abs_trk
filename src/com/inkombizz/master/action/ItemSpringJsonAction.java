
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

import com.inkombizz.master.bll.ItemSpringBLL;
import com.inkombizz.master.bll.ItemSpringBLL;
import com.inkombizz.master.model.ItemSpring;
import com.inkombizz.master.model.ItemSpringTemp;
import com.inkombizz.master.model.ItemSpring;
import com.inkombizz.master.model.ItemSpring;
import com.inkombizz.master.model.ItemSpring;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemSpringJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemSpring itemSpring;
    private ItemSpringTemp itemSpringTemp;
    private List <ItemSpringTemp> listItemSpringTemp;
    private ItemSpring searchItemSpring = new ItemSpring();
    private List <ItemSpring> listItemSpring;
    private String itemSpringSearchCode = "";
    private String itemSpringSearchName = "";
    private String itemSpringSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemSpringActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-spring-data")
    public String findData() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            ListPaging <ItemSpringTemp> listPaging = itemSpringBLL.findData(itemSpringSearchCode,itemSpringSearchName,itemSpringSearchActiveStatus,paging);
            
            listItemSpringTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-spring-get-data")
    public String findData1() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            this.itemSpringTemp = itemSpringBLL.findData(this.itemSpring.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-spring-get")
    public String findData2() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            this.itemSpringTemp = itemSpringBLL.findData(this.itemSpring.getCode(),this.itemSpring.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-spring-authority")
    public String itemSpringAuthority(){
        try{
            
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSpringBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSpringBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemSpringBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-spring-search")
    public String search() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            
            ListPaging <ItemSpring> listPaging = itemSpringBLL.search(paging, searchItemSpring.getCode(), searchItemSpring.getName(), searchItemSpringActiveStatus);
            
            listItemSpring = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-spring-save")
    public String save() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            
          itemSpring.setInActiveDate(commonFunction.setDateTime(itemSpringTemp.getInActiveDateTemp()));
         itemSpring.setCreatedDate(commonFunction.setDateTime(itemSpringTemp.getCreatedDateTemp()));
            
            if(itemSpringBLL.isExist(this.itemSpring.getCode())){
                this.errorMessage = "CODE "+this.itemSpring.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemSpringBLL.save(this.itemSpring);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemSpring.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-spring-update")
    public String update() {
        try {
            ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            itemSpring.setInActiveDate(commonFunction.setDateTime(itemSpringTemp.getInActiveDateTemp()));
            itemSpring.setCreatedDate(commonFunction.setDateTime(itemSpringTemp.getCreatedDateTemp()));
            itemSpringBLL.update(this.itemSpring);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemSpring.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-spring-delete")
    public String delete() {
        try {
           ItemSpringBLL itemSpringBLL = new ItemSpringBLL(hbmSession);
            itemSpringBLL.delete(this.itemSpring.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemSpring.getCode();
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

    public ItemSpring getItemSpring() {
        return itemSpring;
    }

    public void setItemSpring(ItemSpring itemSpring) {
        this.itemSpring = itemSpring;
    }

    public ItemSpringTemp getItemSpringTemp() {
        return itemSpringTemp;
    }

    public void setItemSpringTemp(ItemSpringTemp itemSpringTemp) {
        this.itemSpringTemp = itemSpringTemp;
    }

    public List<ItemSpringTemp> getListItemSpringTemp() {
        return listItemSpringTemp;
    }

    public void setListItemSpringTemp(List<ItemSpringTemp> listItemSpringTemp) {
        this.listItemSpringTemp = listItemSpringTemp;
    }

    public String getItemSpringSearchCode() {
        return itemSpringSearchCode;
    }

    public void setItemSpringSearchCode(String itemSpringSearchCode) {
        this.itemSpringSearchCode = itemSpringSearchCode;
    }

    public String getItemSpringSearchName() {
        return itemSpringSearchName;
    }

    public void setItemSpringSearchName(String itemSpringSearchName) {
        this.itemSpringSearchName = itemSpringSearchName;
    }

    public String getItemSpringSearchActiveStatus() {
        return itemSpringSearchActiveStatus;
    }

    public void setItemSpringSearchActiveStatus(String itemSpringSearchActiveStatus) {
        this.itemSpringSearchActiveStatus = itemSpringSearchActiveStatus;
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

    public ItemSpring getSearchItemSpring() {
        return searchItemSpring;
    }

    public void setSearchItemSpring(ItemSpring searchItemSpring) {
        this.searchItemSpring = searchItemSpring;
    }

    public EnumTriState.Enum_TriState getSearchItemSpringActiveStatus() {
        return searchItemSpringActiveStatus;
    }

    public void setSearchItemSpringActiveStatus(EnumTriState.Enum_TriState searchItemSpringActiveStatus) {
        this.searchItemSpringActiveStatus = searchItemSpringActiveStatus;
    }

    public List<ItemSpring> getListItemSpring() {
        return listItemSpring;
    }

    public void setListItemSpring(List<ItemSpring> listItemSpring) {
        this.listItemSpring = listItemSpring;
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
