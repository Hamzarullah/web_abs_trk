
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

import com.inkombizz.master.bll.ItemArmBLL;
import com.inkombizz.master.model.ItemArmTemp;
import com.inkombizz.master.model.ItemArm;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemArmJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemArm itemArm;
    private ItemArmTemp itemArmTemp;
    private List <ItemArmTemp> listItemArmTemp;
    private ItemArm searchItemArm = new ItemArm();
    private List <ItemArm> listItemArm;
    private String itemArmSearchCode = "";
    private String itemArmSearchName = "";
    private String itemArmSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemArmActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-arm-data")
    public String findData() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            ListPaging <ItemArmTemp> listPaging = itemArmBLL.findData(itemArmSearchCode,itemArmSearchName,itemArmSearchActiveStatus,paging);
            
            listItemArmTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-get-data")
    public String findData1() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            this.itemArmTemp = itemArmBLL.findData(this.itemArm.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-get")
    public String findData2() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            this.itemArmTemp = itemArmBLL.findData(this.itemArm.getCode(),this.itemArm.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-authority")
    public String itemArmAuthority(){
        try{
            
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemArmBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-arm-search")
    public String search() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            
            ListPaging <ItemArm> listPaging = itemArmBLL.search(paging, searchItemArm.getCode(), searchItemArm.getName(), searchItemArmActiveStatus);
            
            listItemArm = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-arm-save")
    public String save() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            
          itemArm.setInActiveDate(commonFunction.setDateTime(itemArmTemp.getInActiveDateTemp()));
         itemArm.setCreatedDate(commonFunction.setDateTime(itemArmTemp.getCreatedDateTemp()));
            
            if(itemArmBLL.isExist(this.itemArm.getCode())){
                this.errorMessage = "CODE "+this.itemArm.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemArmBLL.save(this.itemArm);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemArm.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-update")
    public String update() {
        try {
            ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            itemArm.setInActiveDate(commonFunction.setDateTime(itemArmTemp.getInActiveDateTemp()));
            itemArm.setCreatedDate(commonFunction.setDateTime(itemArmTemp.getCreatedDateTemp()));
            itemArmBLL.update(this.itemArm);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemArm.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-arm-delete")
    public String delete() {
        try {
           ItemArmBLL itemArmBLL = new ItemArmBLL(hbmSession);
            itemArmBLL.delete(this.itemArm.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemArm.getCode();
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

    public ItemArm getItemArm() {
        return itemArm;
    }

    public void setItemArm(ItemArm itemArm) {
        this.itemArm = itemArm;
    }

    public ItemArmTemp getItemArmTemp() {
        return itemArmTemp;
    }

    public void setItemArmTemp(ItemArmTemp itemArmTemp) {
        this.itemArmTemp = itemArmTemp;
    }

    public List<ItemArmTemp> getListItemArmTemp() {
        return listItemArmTemp;
    }

    public void setListItemArmTemp(List<ItemArmTemp> listItemArmTemp) {
        this.listItemArmTemp = listItemArmTemp;
    }

    public String getItemArmSearchCode() {
        return itemArmSearchCode;
    }

    public void setItemArmSearchCode(String itemArmSearchCode) {
        this.itemArmSearchCode = itemArmSearchCode;
    }

    public String getItemArmSearchName() {
        return itemArmSearchName;
    }

    public void setItemArmSearchName(String itemArmSearchName) {
        this.itemArmSearchName = itemArmSearchName;
    }

    public String getItemArmSearchActiveStatus() {
        return itemArmSearchActiveStatus;
    }

    public void setItemArmSearchActiveStatus(String itemArmSearchActiveStatus) {
        this.itemArmSearchActiveStatus = itemArmSearchActiveStatus;
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

    public ItemArm getSearchItemArm() {
        return searchItemArm;
    }

    public void setSearchItemArm(ItemArm searchItemArm) {
        this.searchItemArm = searchItemArm;
    }

    public EnumTriState.Enum_TriState getSearchItemArmActiveStatus() {
        return searchItemArmActiveStatus;
    }

    public void setSearchItemArmActiveStatus(EnumTriState.Enum_TriState searchItemArmActiveStatus) {
        this.searchItemArmActiveStatus = searchItemArmActiveStatus;
    }

    public List<ItemArm> getListItemArm() {
        return listItemArm;
    }

    public void setListItemArm(List<ItemArm> listItemArm) {
        this.listItemArm = listItemArm;
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
