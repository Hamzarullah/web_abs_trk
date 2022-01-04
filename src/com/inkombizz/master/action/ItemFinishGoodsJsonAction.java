package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;

import com.inkombizz.master.bll.ItemFinishGoodsBLL;
import com.inkombizz.master.dao.ItemFinishGoodsDAO;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.master.model.ItemFinishGoodsTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ItemFinishGoodsJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ItemFinishGoods itemFinishGoods;
    private ItemFinishGoodsTemp itemFinishGoodsTemp;
    private List <ItemFinishGoodsTemp> listItemFinishGoodsTemp;
    private String itemFinishGoodsSearchCode = "";
    private String itemFinishGoodsSearchName = "";
    private String itemFinishGoodsSearchCustomerCode = "";
    private String itemFinishGoodsSearchActiveStatus = "true";
    private String actionAuthority="";
    private boolean isItemFinishGoodsByCustomer=false;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-data")
    public String findData() {
        try {
            ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            ListPaging <ItemFinishGoodsTemp> listPaging = itemFinishGoodsBLL.findData(paging,itemFinishGoodsSearchCode,itemFinishGoodsSearchName,itemFinishGoodsSearchActiveStatus);
            
            listItemFinishGoodsTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-get-data")
    public String findData1() {
        try {
            ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            this.itemFinishGoodsTemp = itemFinishGoodsBLL.findData(this.itemFinishGoods.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-data-search")
    public String findDataSearch() {
        try {
            ItemFinishGoodsBLL itemFinishGoodssBLL = new ItemFinishGoodsBLL(hbmSession);
            ListPaging <ItemFinishGoodsTemp> listPaging = itemFinishGoodssBLL.findDataSearch(paging,itemFinishGoodsSearchCode,itemFinishGoodsSearchCustomerCode,itemFinishGoodsSearchActiveStatus);
            
            listItemFinishGoodsTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-authority")
    public String itemFinishGoodsAuthority(){
        try{
            
            ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemFinishGoodsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemFinishGoodsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemFinishGoodsBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-finish-goods-save")
    public String save() {
        try {
            ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            
            ItemFinishGoodsDAO itemFinishGoodsDAO = new ItemFinishGoodsDAO(hbmSession);
            
            itemFinishGoods.setCode(itemFinishGoodsDAO.createCode(itemFinishGoods));
            if(itemFinishGoodsBLL.isExist(itemFinishGoods.getCode())){
                throw new Exception ("Code "+itemFinishGoods.getCode()+" HAS BEEN EXISTS IN DATABASE!");
            }else{
                itemFinishGoodsBLL.save(this.itemFinishGoods);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemFinishGoods.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-update")
    public String update() {
        try {
            ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            
            itemFinishGoodsBLL.update(this.itemFinishGoods);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemFinishGoods.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-finish-goods-delete")
    public String delete() {
        try {
           ItemFinishGoodsBLL itemFinishGoodsBLL = new ItemFinishGoodsBLL(hbmSession);
            itemFinishGoodsBLL.delete(this.itemFinishGoods.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemFinishGoods.getCode();
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

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public ItemFinishGoodsTemp getItemFinishGoodsTemp() {
        return itemFinishGoodsTemp;
    }

    public void setItemFinishGoodsTemp(ItemFinishGoodsTemp itemFinishGoodsTemp) {
        this.itemFinishGoodsTemp = itemFinishGoodsTemp;
    }

    public List<ItemFinishGoodsTemp> getListItemFinishGoodsTemp() {
        return listItemFinishGoodsTemp;
    }

    public void setListItemFinishGoodsTemp(List<ItemFinishGoodsTemp> listItemFinishGoodsTemp) {
        this.listItemFinishGoodsTemp = listItemFinishGoodsTemp;
    }

    public String getItemFinishGoodsSearchCode() {
        return itemFinishGoodsSearchCode;
    }

    public void setItemFinishGoodsSearchCode(String itemFinishGoodsSearchCode) {
        this.itemFinishGoodsSearchCode = itemFinishGoodsSearchCode;
    }

    public String getItemFinishGoodsSearchName() {
        return itemFinishGoodsSearchName;
    }

    public void setItemFinishGoodsSearchName(String itemFinishGoodsSearchName) {
        this.itemFinishGoodsSearchName = itemFinishGoodsSearchName;
    }

    public String getItemFinishGoodsSearchActiveStatus() {
        return itemFinishGoodsSearchActiveStatus;
    }

    public void setItemFinishGoodsSearchActiveStatus(String itemFinishGoodsSearchActiveStatus) {
        this.itemFinishGoodsSearchActiveStatus = itemFinishGoodsSearchActiveStatus;
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

    public boolean isIsItemFinishGoodsByCustomer() {
        return isItemFinishGoodsByCustomer;
    }

    public void setIsItemFinishGoodsByCustomer(boolean isItemFinishGoodsByCustomer) {
        this.isItemFinishGoodsByCustomer = isItemFinishGoodsByCustomer;
    }

    public String getItemFinishGoodsSearchCustomerCode() {
        return itemFinishGoodsSearchCustomerCode;
    }

    public void setItemFinishGoodsSearchCustomerCode(String itemFinishGoodsSearchCustomerCode) {
        this.itemFinishGoodsSearchCustomerCode = itemFinishGoodsSearchCustomerCode;
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
    
    Paging paging = new Paging();

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