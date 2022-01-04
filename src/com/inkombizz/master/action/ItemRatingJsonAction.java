
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

import com.inkombizz.master.bll.ItemRatingBLL;
import com.inkombizz.master.model.ItemRating;
import com.inkombizz.master.model.ItemRatingTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemRatingJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemRating itemRating;
    private ItemRatingTemp itemRatingTemp;
    private List <ItemRatingTemp> listItemRatingTemp;
    private String itemRatingSearchCode = "";
    private String itemRatingSearchName = "";
    private String itemRatingSearchActiveStatus="true";
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
    
    @Action("item-rating-data")
    public String findData() {
        try {
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            ListPaging <ItemRatingTemp> listPaging = itemRatingBLL.findData(itemRatingSearchCode,itemRatingSearchName,itemRatingSearchActiveStatus,paging);
            
            listItemRatingTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-rating-get-data")
    public String findData1() {
        try {
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            this.itemRatingTemp = itemRatingBLL.findData(this.itemRating.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-rating-get")
    public String findData2() {
        try {
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            this.itemRatingTemp = itemRatingBLL.findData(this.itemRating.getCode(),this.itemRating.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-rating-authority")
    public String itemRatingAuthority(){
        try{
            
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemRatingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemRatingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemRatingBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-rating-save")
    public String save() {
        try {
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            
          itemRating.setInActiveDate(commonFunction.setDateTime(itemRatingTemp.getInActiveDateTemp()));
         itemRating.setCreatedDate(commonFunction.setDateTime(itemRatingTemp.getCreatedDateTemp()));
            
            if(itemRatingBLL.isExist(this.itemRating.getCode())){
                this.errorMessage = "CODE "+this.itemRating.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemRatingBLL.save(this.itemRating);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemRating.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-rating-update")
    public String update() {
        try {
            ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            itemRating.setInActiveDate(commonFunction.setDateTime(itemRatingTemp.getInActiveDateTemp()));
            itemRating.setCreatedDate(commonFunction.setDateTime(itemRatingTemp.getCreatedDateTemp()));
            itemRatingBLL.update(this.itemRating);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemRating.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-rating-delete")
    public String delete() {
        try {
           ItemRatingBLL itemRatingBLL = new ItemRatingBLL(hbmSession);
            itemRatingBLL.delete(this.itemRating.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemRating.getCode();
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

    public ItemRating getItemRating() {
        return itemRating;
    }

    public void setItemRating(ItemRating itemRating) {
        this.itemRating = itemRating;
    }

    public ItemRatingTemp getItemRatingTemp() {
        return itemRatingTemp;
    }

    public void setItemRatingTemp(ItemRatingTemp itemRatingTemp) {
        this.itemRatingTemp = itemRatingTemp;
    }

    public List<ItemRatingTemp> getListItemRatingTemp() {
        return listItemRatingTemp;
    }

    public void setListItemRatingTemp(List<ItemRatingTemp> listItemRatingTemp) {
        this.listItemRatingTemp = listItemRatingTemp;
    }

    public String getItemRatingSearchCode() {
        return itemRatingSearchCode;
    }

    public void setItemRatingSearchCode(String itemRatingSearchCode) {
        this.itemRatingSearchCode = itemRatingSearchCode;
    }

    public String getItemRatingSearchName() {
        return itemRatingSearchName;
    }

    public void setItemRatingSearchName(String itemRatingSearchName) {
        this.itemRatingSearchName = itemRatingSearchName;
    }

    public String getItemRatingSearchActiveStatus() {
        return itemRatingSearchActiveStatus;
    }

    public void setItemRatingSearchActiveStatus(String itemRatingSearchActiveStatus) {
        this.itemRatingSearchActiveStatus = itemRatingSearchActiveStatus;
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
