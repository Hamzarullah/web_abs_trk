
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.RackBLL;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.RackItemBLL;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackItem;
import com.inkombizz.master.model.RackItemTemp;
import com.inkombizz.master.model.RackTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class RackItemJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Rack rack;
    private RackItem rackItem;
    private RackItem searchRackItem = new RackItem();
    private RackItemTemp rackItemTemp;
    private List <RackItemTemp> listRackItemTemp;
    private List <RackItem> listRackItem;
    private List <Rack> listRack;
    private List<RackTemp> listRackTemp;
    private String listRackItemJSON;
    private String actionAuthority="";
    private String rackItemStatus ="YES";
    private String warehouseSearchCode="";
    private String warehouseSearchName="";
    private String rackTypeSearchCode="";
    private String rackTypeSearchName="";
    private String rackSearchActiveStatus="true";
    private String rackItemSearchRackCode="";
    private String rackItemSearchRackName="";
    private String rackItemSearchRackTypeCode="";
    private String rackItemSearchRackTypeName="";
    private String rackItemSearchWarehouseCode="";
    private String rackItemSearchWarehouseName="";
    
    private String rackItemSearchRackActiveStatus="true";
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("rack-item-search")
    public String search() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            
            ListPaging <Rack> listPaging = rackItemBLL.search(paging, this.rack.getCode(), this.rack.getName(), Enum_TriState.YES);
            
            listRack = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
	
    @Action("rack-item-data")
    public String populateData() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
             List<RackItemTemp> list = rackItemBLL.getRackItem(this.rack.getCode());
            
            listRackItemTemp = list;
            
//            ListPaging<RackItemTemp> listPaging = rackItemBLL.get(this.rackItem.getCode());
//            listRackItemTemp = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("rack-item-get")
    public String populateDataForUpdate() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            this.rackItem = rackItemBLL.get(this.rackItem.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rack-item-save")
    public String save() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            Gson gson = new Gson();
            this.listRackItem = gson.fromJson(this.listRackItemJSON, new TypeToken<List<RackItem>>(){}.getType());
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }                
            
//            if(rackItem.isActiveStatus() == false){
//                rackItem.setInActiveBy(BaseSession.loadProgramSession().getUserName());
//                rackItem.setInActiveDate(new Date());
//            }
//            this.rack.setActiveStatus(true);
//            this.rack.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//            this.rack.setCreatedDate(new Date());
            
            rackItemBLL.save(this.rack,this.listRackItem);
//            rackItemBLL.save(this.listRackItem);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.rack.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("rack-item-update")
    public String update() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }     
            
            rackItemBLL.update(this.rackItem);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.rackItem.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("rack-item-delete")
    public String delete() {
        try {
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            rackItemBLL.delete(this.rackItem.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.rackItem.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("rack-item-get-min")
    public String populateDataSupplierMin() {
        try {
            RackItemBLL rackItemBLL=new RackItemBLL(hbmSession);
            this.rackItemTemp = rackItemBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rack-item-get-max")
    public String populateDataSupplierMax() {
        try {
            RackItemBLL rackItemBLL=new RackItemBLL(hbmSession);
            this.rackItemTemp = rackItemBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("rack-item-authority")
    public String rackItemAuthority(){
        try{
            
            RackItemBLL rackItemBLL = new RackItemBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackItemBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    public String getListRackItemJSON() {
        return listRackItemJSON;
    }

    public void setListRackItemJSON(String listRackItemJSON) {
        this.listRackItemJSON = listRackItemJSON;
    }

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public String getRackItemStatus() {
        return rackItemStatus;
    }

    public void setRackItemStatus(String rackItemStatus) {
        this.rackItemStatus = rackItemStatus;
    }

    public List<Rack> getListRack() {
        return listRack;
    }

    public void setListRack(List<Rack> listRack) {
        this.listRack = listRack;
    }

    public List<RackTemp> getListRackTemp() {
        return listRackTemp;
    }

    public void setListRackTemp(List<RackTemp> listRackTemp) {
        this.listRackTemp = listRackTemp;
    }

    public String getWarehouseSearchCode() {
        return warehouseSearchCode;
    }

    public void setWarehouseSearchCode(String warehouseSearchCode) {
        this.warehouseSearchCode = warehouseSearchCode;
    }

    public String getWarehouseSearchName() {
        return warehouseSearchName;
    }

    public void setWarehouseSearchName(String warehouseSearchName) {
        this.warehouseSearchName = warehouseSearchName;
    }

    public String getRackTypeSearchCode() {
        return rackTypeSearchCode;
    }

    public void setRackTypeSearchCode(String rackTypeSearchCode) {
        this.rackTypeSearchCode = rackTypeSearchCode;
    }

    public String getRackTypeSearchName() {
        return rackTypeSearchName;
    }

    public void setRackTypeSearchName(String rackTypeSearchName) {
        this.rackTypeSearchName = rackTypeSearchName;
    }

    public String getRackSearchActiveStatus() {
        return rackSearchActiveStatus;
    }

    public void setRackSearchActiveStatus(String rackSearchActiveStatus) {
        this.rackSearchActiveStatus = rackSearchActiveStatus;
    }

    public String getRackItemSearchRackCode() {
        return rackItemSearchRackCode;
    }

    public void setRackItemSearchRackCode(String rackItemSearchRackCode) {
        this.rackItemSearchRackCode = rackItemSearchRackCode;
    }

    public String getRackItemSearchRackName() {
        return rackItemSearchRackName;
    }

    public void setRackItemSearchRackName(String rackItemSearchRackName) {
        this.rackItemSearchRackName = rackItemSearchRackName;
    }

    public String getRackItemSearchRackTypeCode() {
        return rackItemSearchRackTypeCode;
    }

    public void setRackItemSearchRackTypeCode(String rackItemSearchRackTypeCode) {
        this.rackItemSearchRackTypeCode = rackItemSearchRackTypeCode;
    }

    public String getRackItemSearchRackTypeName() {
        return rackItemSearchRackTypeName;
    }

    public void setRackItemSearchRackTypeName(String rackItemSearchRackTypeName) {
        this.rackItemSearchRackTypeName = rackItemSearchRackTypeName;
    }

    public String getRackItemSearchWarehouseCode() {
        return rackItemSearchWarehouseCode;
    }

    public void setRackItemSearchWarehouseCode(String rackItemSearchWarehouseCode) {
        this.rackItemSearchWarehouseCode = rackItemSearchWarehouseCode;
    }

    public String getRackItemSearchWarehouseName() {
        return rackItemSearchWarehouseName;
    }

    public void setRackItemSearchWarehouseName(String rackItemSearchWarehouseName) {
        this.rackItemSearchWarehouseName = rackItemSearchWarehouseName;
    }

    public String getRackItemSearchRackActiveStatus() {
        return rackItemSearchRackActiveStatus;
    }

    public void setRackItemSearchRackActiveStatus(String rackItemSearchRackActiveStatus) {
        this.rackItemSearchRackActiveStatus = rackItemSearchRackActiveStatus;
    }
    
    
    

    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public RackItem getRackItem() {
            return rackItem;
        }

        public void setRackItem(RackItem rackItem) {
            this.rackItem = rackItem;
        }

        public RackItemTemp getRackItemTemp() {
            return rackItemTemp;
        }

        public void setRackItemTemp(RackItemTemp rackItemTemp) {
            this.rackItemTemp = rackItemTemp;
        }

        public List<RackItemTemp> getListRackItemTemp() {
            return listRackItemTemp;
        }

        public void setListRackItemTemp(List<RackItemTemp> listRackItemTemp) {
            this.listRackItemTemp = listRackItemTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public RackItem getSearchRackItem() {
            return searchRackItem;
        }

        public void setSearchRackItem(RackItem searchRackItem) {
            this.searchRackItem = searchRackItem;
        }

        public List<RackItem> getListRackItem() {
            return listRackItem;
        }

        public void setListRackItem(List<RackItem> listRackItem) {
            this.listRackItem = listRackItem;
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
