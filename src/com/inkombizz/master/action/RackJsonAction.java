package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.bll.RackBLL;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.RackTemp;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;

@Result(type = "json")
public class RackJsonAction extends ActionSupport {
    
    protected HBMSession hbmSession = new HBMSession();
    
    private static final long serialVersionUID = 1L;
    
    private Rack rack;
    private Rack searchRack;
    private RackTemp rackTemp;
    private List<Rack> listRack;
    private List<RackTemp> listRackTemp;
    private String actionAuthority="";
    private String rackSearchCode="";
    private String rackSearchName="";
    private String rackSearchWarehouseCode = "";
    private String rackSearchWarehouseName = "";
    
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
    private String idWarehouseCode="";
    private String tempWarehouse="";
    private String tempRackCategory="";
    private String userRack="";
    private String headerCode="";
   
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("rack-search-data")
    public String findSearchData() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            String userCodeTemp = BaseSession.loadProgramSession().getUserCode();
            ListPaging <RackTemp> listPaging = rackBLL.findSearchDataView(rackSearchCode, rackSearchName, rackSearchWarehouseCode, rackSearchWarehouseName, 
                    rackSearchActiveStatus, userCodeTemp, paging);
            
            listRackTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("rack-search-data-for-rkm")
    public String findSearchDataForRkm() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            ListPaging <RackTemp> listPaging = rackBLL.findSearchDataForRkm(rackSearchCode,rackSearchName,idWarehouseCode,rackSearchActiveStatus,paging);
            
            listRackTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("rack-item-search-rack-data")
    public String findSearchRackData() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            //User user tidak perlu.
            User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserCode());
            ListPaging <RackTemp> listPaging = rackBLL.findSearchData(rackItemSearchRackCode,rackItemSearchRackName,rackItemSearchRackActiveStatus,user.getCode(),paging);
            
            listRackTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("rack-item-search-rack-data-list")
    public String findSearchRackDataList() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
             String userCodeTemp = BaseSession.loadProgramSession().getUserCode();
            ListPaging <RackTemp> listPaging = rackBLL.findSearchDataView(rackItemSearchRackCode,rackItemSearchRackName,rackItemSearchWarehouseCode,rackItemSearchWarehouseName,rackItemSearchRackActiveStatus,userCodeTemp ,paging);
            
            listRackTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("rack-search")
    public String search() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            
            if(searchRack == null)
            {
                searchRack = new Rack();
                
                searchRack.setCode("");
                searchRack.setName("");
            }
            
            ListPaging <Rack> listPaging = rackBLL.search(paging, searchRack.getCode(), searchRack.getName(), Enum_TriState.YES);
            
            listRack = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rack-stock-search-data")
    public String findData() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            ListPaging<RackTemp> listPaging = rackBLL.findData(paging,searchRack.getCode(), searchRack.getName());
            
            listRackTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("rack-data-detail")
    public String populateData() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            ListPaging<Rack> listPaging = rackBLL.find(paging);
            listRack = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    

    @Action("rack-get-data")
    public String findData1() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            ListPaging<RackTemp> listPaging = rackBLL.findData1(rackSearchCode,rackSearchName,rackSearchActiveStatus,paging);     
            listRackTemp = listPaging.getList();
                
            return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("rack-get")
    public String populateDataForUpdate() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            this.rackTemp = rackBLL.get(this.rack.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("rack-save")
    public String save() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }              
            
            if(rack.isActiveStatus() == false){
                rack.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                rack.setInActiveDate(new Date());
            }
            if(rackBLL.isExist(this.rack.getCode())){
                this.errorMessage = "Code "+this.rack.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                if(this.rack.getRackCategory().equals("DOCK_IN")){
                    if(rackBLL.isExistRackCategory(this.rack.getWarehouse().getCode())>0){
                    this.errorMessage = "RACK CATEGORY DOCK_IN HAS BEEN EXIST IN WAREHOUSE "+this.rack.getWarehouse().getCode()+" !";   
                    }
                    else{
                        rackBLL.save(this.rack);
                        this.message = "SAVE DATA SUCCESS. \n Code : " + this.rack.getCode();
                    }
                }
                else{
                    rackBLL.save(this.rack);
                    this.message = "SAVE DATA SUCCESS. \n Code : " + this.rack.getCode();
                }
            }

            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("rack-update")
    public String update() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }            
            
             if(rack.isActiveStatus() == false){
                rack.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                rack.setInActiveDate(new Date());
            }
            if(this.rack.getRackCategory().equals("DOCK_IN")){
                if(this.tempWarehouse.equals(this.rack.getWarehouse().getCode()) && this.tempRackCategory.equals(this.rack.getRackCategory())){
                    rackBLL.update(this.rack);
                    this.message = "UPDATE DATA SUCCESS. \n Code : " + this.rack.getCode();
                }
                else{
                    if(rackBLL.isExistRackCategory(this.rack.getWarehouse().getCode())>0){
                        this.errorMessage = "RACK CATEGORY DOCK_IN HAS BEEN EXIST IN WAREHOUSE "+this.rack.getWarehouse().getCode()+" !";   
                    }
                    else{
                        rackBLL.update(this.rack);
                        this.message = "UPDATE DATA SUCCESS. \n Code : " + this.rack.getCode();
                    }
                }
                
            }
            else{
                rackBLL.update(this.rack);
                this.message = "UPDATE DATA SUCCESS. \n Code : " + this.rack.getCode();
            }
     
    
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("rack-authority")
    public String rackAuthority(){
        try{
            
            RackBLL rackBLL = new RackBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(rackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("rack-check-exist-in-rack-item")
    public String rackCheckInRackItem(){
        try{
            
            RackBLL rackBLL = new RackBLL(hbmSession);
            if(rackBLL.rackCheckInRackItem(headerCode)>0){
                this.error = true;
                this.errorMessage = "Can't Delete, Data has been Used in Master Rack Item !";
                 return SUCCESS;
            }else{
                this.error = false;
            }
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
	
    @Action("rack-delete")
    public String delete() {
        try {
            RackBLL rackBLL = new RackBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(RackBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            rackBLL.delete(this.rack.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.rack.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
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
    
    public Rack getRack() {
        return rack;
    }
    public void setRack(Rack rack) {
        this.rack = rack;
    }
	
    public List<Rack> getListRack() {
        return listRack;
    }
    public void setListRack(List<Rack> listRack) {
        this.listRack = listRack;
    }

    public Rack getSearchRack() {
        return searchRack;
    }
    public void setSearchRack(Rack searchRack) {
        this.searchRack = searchRack;
    }   
	
    Paging paging = new Paging();

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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }

    public List<RackTemp> getListRackTemp() {
        return listRackTemp;
    }

    public void setListRackTemp(List<RackTemp> listRackTemp) {
        this.listRackTemp = listRackTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getRackSearchCode() {
        return rackSearchCode;
    }

    public void setRackSearchCode(String rackSearchCode) {
        this.rackSearchCode = rackSearchCode;
    }

    public String getRackSearchName() {
        return rackSearchName;
    }

    public void setRackSearchName(String rackSearchName) {
        this.rackSearchName = rackSearchName;
    }

    public String getRackSearchActiveStatus() {
        return rackSearchActiveStatus;
    }

    public void setRackSearchActiveStatus(String rackSearchActiveStatus) {
        this.rackSearchActiveStatus = rackSearchActiveStatus;
    }

    public RackTemp getRackTemp() {
        return rackTemp;
    }

    public void setRackTemp(RackTemp rackTemp) {
        this.rackTemp = rackTemp;
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

    public String getRackItemSearchRackActiveStatus() {
        return rackItemSearchRackActiveStatus;
    }

    public void setRackItemSearchRackActiveStatus(String rackItemSearchRackActiveStatus) {
        this.rackItemSearchRackActiveStatus = rackItemSearchRackActiveStatus;
    }

    public String getIdWarehouseCode() {
        return idWarehouseCode;
    }

    public void setIdWarehouseCode(String idWarehouseCode) {
        this.idWarehouseCode = idWarehouseCode;
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

    public String getTempWarehouse() {
        return tempWarehouse;
    }

    public void setTempWarehouse(String tempWarehouse) {
        this.tempWarehouse = tempWarehouse;
    }

    public String getTempRackCategory() {
        return tempRackCategory;
    }

    public void setTempRackCategory(String tempRackCategory) {
        this.tempRackCategory = tempRackCategory;
    }

    public String getUserRack() {
        return userRack;
    }

    public void setUserRack(String userRack) {
        this.userRack = userRack;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
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

    public String getRackSearchWarehouseCode() {
        return rackSearchWarehouseCode;
    }

    public void setRackSearchWarehouseCode(String rackSearchWarehouseCode) {
        this.rackSearchWarehouseCode = rackSearchWarehouseCode;
    }

    public String getRackSearchWarehouseName() {
        return rackSearchWarehouseName;
    }

    public void setRackSearchWarehouseName(String rackSearchWarehouseName) {
        this.rackSearchWarehouseName = rackSearchWarehouseName;
    }
    
}