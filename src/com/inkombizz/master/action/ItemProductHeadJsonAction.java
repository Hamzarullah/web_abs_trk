
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ItemProductHeadBLL;
import com.inkombizz.master.model.ItemProductHead;
import com.inkombizz.master.model.ItemProductHeadTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class ItemProductHeadJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ItemProductHead itemProductHead;
    private ItemProductHead searchItemProductHead = new ItemProductHead();
    private ItemProductHeadTemp itemProductHeadTemp;
    private List <ItemProductHeadTemp> listItemProductHeadTemp;
    private List <ItemProductHead> listItemProductHead;
    private String actionAuthority="";
    private Enum_TriState searchItemProductHeadActiveStatus = Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("item-product-head-search")
    public String search() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            
            ListPaging <ItemProductHead> listPaging = itemProductHeadBLL.search(paging, searchItemProductHead.getCode(), searchItemProductHead.getName(), searchItemProductHeadActiveStatus);
            
            listItemProductHead = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-product-head-data")
    public String populateData() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            ListPaging<ItemProductHead> listPaging = itemProductHeadBLL.get(paging);
            listItemProductHead = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-product-head-get")
    public String populateDataForUpdate() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            this.itemProductHead = itemProductHeadBLL.get(this.itemProductHead.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-product-head-get-data")
    public String findData2() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            this.itemProductHeadTemp = itemProductHeadBLL.findData(this.itemProductHead.getCode(),this.itemProductHead.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-product-head-save")
    public String save() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }                
            
            if(itemProductHead.isActiveStatus() == false){
                itemProductHead.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemProductHead.setInActiveDate(new Date());
            }
            itemProductHeadBLL.save(this.itemProductHead);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemProductHead.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-product-head-update")
    public String update() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }     
            
            if(itemProductHead.isActiveStatus() == false){
                itemProductHead.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemProductHead.setInActiveDate(new Date());
            }
            itemProductHeadBLL.update(this.itemProductHead);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemProductHead.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-product-head-delete")
    public String delete() {
        try {
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ItemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            itemProductHeadBLL.delete(this.itemProductHead.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemProductHead.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("item-product-head-get-min")
    public String populateDataSupplierMin() {
        try {
            ItemProductHeadBLL itemProductHeadBLL=new ItemProductHeadBLL(hbmSession);
            this.itemProductHeadTemp = itemProductHeadBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-product-head-get-max")
    public String populateDataSupplierMax() {
        try {
            ItemProductHeadBLL itemProductHeadBLL=new ItemProductHeadBLL(hbmSession);
            this.itemProductHeadTemp = itemProductHeadBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("item-product-head-authority")
    public String itemProductHeadAuthority(){
        try{
            
            ItemProductHeadBLL itemProductHeadBLL = new ItemProductHeadBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemProductHeadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public ItemProductHead getItemProductHead() {
            return itemProductHead;
        }

        public void setItemProductHead(ItemProductHead itemProductHead) {
            this.itemProductHead = itemProductHead;
        }

        public ItemProductHeadTemp getItemProductHeadTemp() {
            return itemProductHeadTemp;
        }

        public void setItemProductHeadTemp(ItemProductHeadTemp itemProductHeadTemp) {
            this.itemProductHeadTemp = itemProductHeadTemp;
        }

        public List<ItemProductHeadTemp> getListItemProductHeadTemp() {
            return listItemProductHeadTemp;
        }

        public void setListItemProductHeadTemp(List<ItemProductHeadTemp> listItemProductHeadTemp) {
            this.listItemProductHeadTemp = listItemProductHeadTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public ItemProductHead getSearchItemProductHead() {
            return searchItemProductHead;
        }

        public void setSearchItemProductHead(ItemProductHead searchItemProductHead) {
            this.searchItemProductHead = searchItemProductHead;
        }

        public List<ItemProductHead> getListItemProductHead() {
            return listItemProductHead;
        }

        public void setListItemProductHead(List<ItemProductHead> listItemProductHead) {
            this.listItemProductHead = listItemProductHead;
        }

        public Enum_TriState getSearchItemProductHeadActiveStatus() {
            return searchItemProductHeadActiveStatus;
        }

        public void setSearchItemProductHeadActiveStatus(Enum_TriState searchItemProductHeadActiveStatus) {
            this.searchItemProductHeadActiveStatus = searchItemProductHeadActiveStatus;
        }
        

    // </editor-fold>    
    
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">

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
