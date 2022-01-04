
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

import com.inkombizz.master.bll.ItemBodyConstructionBLL;
import com.inkombizz.master.bll.ItemBodyConstructionBLL;
import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.ItemBodyConstructionTemp;
import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.ItemBodyConstruction;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBodyConstructionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBodyConstruction itemBodyConstruction;
    private ItemBodyConstructionTemp itemBodyConstructionTemp;
    private List <ItemBodyConstructionTemp> listItemBodyConstructionTemp;
    private ItemBodyConstruction searchItemBodyConstruction = new ItemBodyConstruction();
    private List <ItemBodyConstruction> listItemBodyConstruction;
    private String itemBodyConstructionSearchCode = "";
    private String itemBodyConstructionSearchName = "";
    private String itemBodyConstructionSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemBodyConstructionActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-data")
    public String findData() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            ListPaging <ItemBodyConstructionTemp> listPaging = itemBodyConstructionBLL.findData(itemBodyConstructionSearchCode,itemBodyConstructionSearchName,itemBodyConstructionSearchActiveStatus,paging);
            
            listItemBodyConstructionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-get-data")
    public String findData1() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            this.itemBodyConstructionTemp = itemBodyConstructionBLL.findData(this.itemBodyConstruction.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-get")
    public String findData2() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            this.itemBodyConstructionTemp = itemBodyConstructionBLL.findData(this.itemBodyConstruction.getCode(),this.itemBodyConstruction.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-authority")
    public String itemBodyConstructionAuthority(){
        try{
            
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyConstructionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyConstructionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBodyConstructionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-body-construction-search")
    public String search() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            
            ListPaging <ItemBodyConstruction> listPaging = itemBodyConstructionBLL.search(paging, searchItemBodyConstruction.getCode(), searchItemBodyConstruction.getName(), searchItemBodyConstructionActiveStatus);
            
            listItemBodyConstruction = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-body-construction-save")
    public String save() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            
          itemBodyConstruction.setInActiveDate(commonFunction.setDateTime(itemBodyConstructionTemp.getInActiveDateTemp()));
         itemBodyConstruction.setCreatedDate(commonFunction.setDateTime(itemBodyConstructionTemp.getCreatedDateTemp()));
            
            if(itemBodyConstructionBLL.isExist(this.itemBodyConstruction.getCode())){
                this.errorMessage = "CODE "+this.itemBodyConstruction.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBodyConstructionBLL.save(this.itemBodyConstruction);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBodyConstruction.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-update")
    public String update() {
        try {
            ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            itemBodyConstruction.setInActiveDate(commonFunction.setDateTime(itemBodyConstructionTemp.getInActiveDateTemp()));
            itemBodyConstruction.setCreatedDate(commonFunction.setDateTime(itemBodyConstructionTemp.getCreatedDateTemp()));
            itemBodyConstructionBLL.update(this.itemBodyConstruction);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBodyConstruction.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-body-construction-delete")
    public String delete() {
        try {
           ItemBodyConstructionBLL itemBodyConstructionBLL = new ItemBodyConstructionBLL(hbmSession);
            itemBodyConstructionBLL.delete(this.itemBodyConstruction.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBodyConstruction.getCode();
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

    public ItemBodyConstruction getItemBodyConstruction() {
        return itemBodyConstruction;
    }

    public void setItemBodyConstruction(ItemBodyConstruction itemBodyConstruction) {
        this.itemBodyConstruction = itemBodyConstruction;
    }

    public ItemBodyConstructionTemp getItemBodyConstructionTemp() {
        return itemBodyConstructionTemp;
    }

    public void setItemBodyConstructionTemp(ItemBodyConstructionTemp itemBodyConstructionTemp) {
        this.itemBodyConstructionTemp = itemBodyConstructionTemp;
    }

    public List<ItemBodyConstructionTemp> getListItemBodyConstructionTemp() {
        return listItemBodyConstructionTemp;
    }

    public void setListItemBodyConstructionTemp(List<ItemBodyConstructionTemp> listItemBodyConstructionTemp) {
        this.listItemBodyConstructionTemp = listItemBodyConstructionTemp;
    }

    public String getItemBodyConstructionSearchCode() {
        return itemBodyConstructionSearchCode;
    }

    public void setItemBodyConstructionSearchCode(String itemBodyConstructionSearchCode) {
        this.itemBodyConstructionSearchCode = itemBodyConstructionSearchCode;
    }

    public String getItemBodyConstructionSearchName() {
        return itemBodyConstructionSearchName;
    }

    public void setItemBodyConstructionSearchName(String itemBodyConstructionSearchName) {
        this.itemBodyConstructionSearchName = itemBodyConstructionSearchName;
    }

    public String getItemBodyConstructionSearchActiveStatus() {
        return itemBodyConstructionSearchActiveStatus;
    }

    public void setItemBodyConstructionSearchActiveStatus(String itemBodyConstructionSearchActiveStatus) {
        this.itemBodyConstructionSearchActiveStatus = itemBodyConstructionSearchActiveStatus;
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

    public ItemBodyConstruction getSearchItemBodyConstruction() {
        return searchItemBodyConstruction;
    }

    public void setSearchItemBodyConstruction(ItemBodyConstruction searchItemBodyConstruction) {
        this.searchItemBodyConstruction = searchItemBodyConstruction;
    }

    public EnumTriState.Enum_TriState getSearchItemBodyConstructionActiveStatus() {
        return searchItemBodyConstructionActiveStatus;
    }

    public void setSearchItemBodyConstructionActiveStatus(EnumTriState.Enum_TriState searchItemBodyConstructionActiveStatus) {
        this.searchItemBodyConstructionActiveStatus = searchItemBodyConstructionActiveStatus;
    }

    public List<ItemBodyConstruction> getListItemBodyConstruction() {
        return listItemBodyConstruction;
    }

    public void setListItemBodyConstruction(List<ItemBodyConstruction> listItemBodyConstruction) {
        this.listItemBodyConstruction = listItemBodyConstruction;
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
