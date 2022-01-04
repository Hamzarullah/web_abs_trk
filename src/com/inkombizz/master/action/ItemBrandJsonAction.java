
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

import com.inkombizz.master.bll.ItemBrandBLL;
import com.inkombizz.master.bll.ItemBrandBLL;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrandTemp;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrand;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemBrandJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemBrand itemBrand;
    private ItemBrandTemp itemBrandTemp;
    private List <ItemBrandTemp> listItemBrandTemp;
    private ItemBrand searchItemBrand = new ItemBrand();
    private List <ItemBrand> listItemBrand;
    private String itemBrandSearchCode = "";
    private String itemBrandSearchName = "";
    private String itemBrandSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchItemBrandActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-brand-data")
    public String findData() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            ListPaging <ItemBrandTemp> listPaging = itemBrandBLL.findData(itemBrandSearchCode,itemBrandSearchName,itemBrandSearchActiveStatus,paging);
            
            listItemBrandTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-brand-get-data")
    public String findData1() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            this.itemBrandTemp = itemBrandBLL.findData(this.itemBrand.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-brand-get")
    public String findData2() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            this.itemBrandTemp = itemBrandBLL.findData(this.itemBrand.getCode(),this.itemBrand.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-brand-authority")
    public String itemBrandAuthority(){
        try{
            
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBrandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBrandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemBrandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("item-brand-search")
    public String search() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            
            ListPaging <ItemBrand> listPaging = itemBrandBLL.search(paging, searchItemBrand.getCode(), searchItemBrand.getName(), searchItemBrandActiveStatus);
            
            listItemBrand = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-brand-save")
    public String save() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            
          itemBrand.setInActiveDate(commonFunction.setDateTime(itemBrandTemp.getInActiveDateTemp()));
         itemBrand.setCreatedDate(commonFunction.setDateTime(itemBrandTemp.getCreatedDateTemp()));
            
            if(itemBrandBLL.isExist(this.itemBrand.getCode())){
                this.errorMessage = "CODE "+this.itemBrand.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemBrandBLL.save(this.itemBrand);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemBrand.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-brand-update")
    public String update() {
        try {
            ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            itemBrand.setInActiveDate(commonFunction.setDateTime(itemBrandTemp.getInActiveDateTemp()));
            itemBrand.setCreatedDate(commonFunction.setDateTime(itemBrandTemp.getCreatedDateTemp()));
            itemBrandBLL.update(this.itemBrand);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemBrand.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-brand-delete")
    public String delete() {
        try {
           ItemBrandBLL itemBrandBLL = new ItemBrandBLL(hbmSession);
            itemBrandBLL.delete(this.itemBrand.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemBrand.getCode();
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

    public ItemBrand getItemBrand() {
        return itemBrand;
    }

    public void setItemBrand(ItemBrand itemBrand) {
        this.itemBrand = itemBrand;
    }

    public ItemBrandTemp getItemBrandTemp() {
        return itemBrandTemp;
    }

    public void setItemBrandTemp(ItemBrandTemp itemBrandTemp) {
        this.itemBrandTemp = itemBrandTemp;
    }

    public List<ItemBrandTemp> getListItemBrandTemp() {
        return listItemBrandTemp;
    }

    public void setListItemBrandTemp(List<ItemBrandTemp> listItemBrandTemp) {
        this.listItemBrandTemp = listItemBrandTemp;
    }

    public String getItemBrandSearchCode() {
        return itemBrandSearchCode;
    }

    public void setItemBrandSearchCode(String itemBrandSearchCode) {
        this.itemBrandSearchCode = itemBrandSearchCode;
    }

    public String getItemBrandSearchName() {
        return itemBrandSearchName;
    }

    public void setItemBrandSearchName(String itemBrandSearchName) {
        this.itemBrandSearchName = itemBrandSearchName;
    }

    public String getItemBrandSearchActiveStatus() {
        return itemBrandSearchActiveStatus;
    }

    public void setItemBrandSearchActiveStatus(String itemBrandSearchActiveStatus) {
        this.itemBrandSearchActiveStatus = itemBrandSearchActiveStatus;
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

    public ItemBrand getSearchItemBrand() {
        return searchItemBrand;
    }

    public void setSearchItemBrand(ItemBrand searchItemBrand) {
        this.searchItemBrand = searchItemBrand;
    }

    public EnumTriState.Enum_TriState getSearchItemBrandActiveStatus() {
        return searchItemBrandActiveStatus;
    }

    public void setSearchItemBrandActiveStatus(EnumTriState.Enum_TriState searchItemBrandActiveStatus) {
        this.searchItemBrandActiveStatus = searchItemBrandActiveStatus;
    }

    public List<ItemBrand> getListItemBrand() {
        return listItemBrand;
    }

    public void setListItemBrand(List<ItemBrand> listItemBrand) {
        this.listItemBrand = listItemBrand;
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
