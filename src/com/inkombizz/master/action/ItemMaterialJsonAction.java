
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ItemMaterialBLL;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.ItemMaterialTemp;
import com.inkombizz.master.model.ItemMaterialVendor;
import com.inkombizz.master.model.ItemMaterialVendorTemp;

@Result (type = "json")
public class ItemMaterialJsonAction extends ActionSupport{
 
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ItemMaterial itemMaterial = new ItemMaterial();
    private ItemMaterialVendor itemMaterialVendor = new ItemMaterialVendor();
    private ItemMaterialTemp itemMaterialTemp;
    private ItemMaterialVendorTemp itemMaterialVendorTemp;
    private List <ItemMaterialTemp> listItemMaterialTemp;
    private List <ItemMaterial> listItemMaterial;
    private List <ItemMaterialVendor> listItemMaterialVendorDetail;
    private List <ItemMaterialVendor> listItemMaterialVendorDetailExisting;
    private ItemMaterial searchItemMaterial = new ItemMaterial();
    
    private String itemMaterialSearchCode = "";
    private String itemMaterialSearchName = "";
    private String itemMaterialSearchInventoryType = "";
    private String itemMaterialSearchItemMaterialDivision = "";
    private String itemMaterialSearchActiveStatus="true";
    private String itemMaterialSerialNoSearchWarehouseCode="";
    private String itemMaterialSearchItemMaterialDivisionCode="";
    private String itemMaterialSearchItemMaterialDivisionName="";
    private String itemMaterialSearchPriorityStatus="";
//    private String itemMaterialSearchSerialNoStatus="";
    private String actionAuthority="";
    private EnumTriState.Enum_TriState searchItemMaterialActiveStatus = EnumTriState.Enum_TriState.YES;
    private String listItemMaterialVendorDetailJSON;
    private String listItemMaterialVendorDetailExistingJSON;
    private String itemMaterialVendorSearchCode = "";
    private String itemMaterialVendorSearchName = "";
    private String itemMaterialVendorSearchVendorCode = "";
    private String itemMaterialJnVendorSearchCode = "";
    private String itemMaterialJnVendorSearchName = "";
    private String itemMaterialJnVendorSearchVendorCode = "";
    private String itemMaterialVendorSearchActiveStatus="true";
    private String itemMaterialVendorSearchNonSerialNoStatus="false";
    
    private String warehouseCode = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-material-data")
    public String findData() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.findData(itemMaterialSearchCode,itemMaterialSearchName,itemMaterialSearchInventoryType,itemMaterialSearchActiveStatus,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("item-material-vendor-data")
//    public String findDataMaterialVendor() {
//        try {
//            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
//            ListPaging <ItemMaterialVendor> listPaging = itemMaterialBLL.findDataMaterialVendor(itemMaterialVendorSearchCode,itemMaterialVendorSearchVendorCode,paging);
//            
//            listItemMaterialVendorDetail = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("item-material-jn-vendor-data")
    public String findDataMaterialJnVendor() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialVendor> listPaging = itemMaterialBLL.findDataMaterialJnVendor(itemMaterialJnVendorSearchCode,itemMaterialJnVendorSearchVendorCode,paging);
            
            listItemMaterialVendorDetail = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-vendor-detail-exisitng")
    public String findDataDetailExisting() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialVendor> listPaging = itemMaterialBLL.findDataDetailExisting(itemMaterialVendor.getCode());
            
            listItemMaterialVendorDetailExisting = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-data-so")
    public String findDataSo() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.findDataSo(itemMaterialSearchCode,itemMaterialSearchName,itemMaterialSearchInventoryType,itemMaterialSearchActiveStatus,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-serial-no-data")
    public String findDataInSerialNoDetail() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.findData(itemMaterialSearchCode,itemMaterialSearchName,itemMaterialSerialNoSearchWarehouseCode,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-get-data")
    public String findData1() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            this.itemMaterialTemp = itemMaterialBLL.findData(this.itemMaterial.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-get")
    public String findData2() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            this.itemMaterialTemp = itemMaterialBLL.findData(this.itemMaterial.getCode(),this.itemMaterial.isActiveStatus(),itemMaterialSearchInventoryType);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-material-serial-no-get")
    public String findDataItemMaterialSerialNo() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            this.itemMaterialTemp = itemMaterialBLL.findData(this.itemMaterial.getCode(),itemMaterialSerialNoSearchWarehouseCode);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-data-nonsn")
    public String findDataNonSN() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.findDataNonSN(itemMaterialVendorSearchCode,itemMaterialVendorSearchName,itemMaterialVendorSearchActiveStatus,itemMaterialVendorSearchNonSerialNoStatus,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-data-sn")
    public String findDataSN() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.findDataSN(itemMaterialVendorSearchCode,itemMaterialVendorSearchName,itemMaterialVendorSearchActiveStatus,itemMaterialVendorSearchNonSerialNoStatus,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-authority")
    public String itemMaterialAuthority(){
        try{
            
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("item-material-search")
    public String search() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.search(itemMaterial.getCode(),itemMaterial.getName(),itemMaterialSearchActiveStatus,paging);
            
            listItemMaterialTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
        @Action("item-material-booked-search")
        public String searchItemBooked() {
            try {
                ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
                ListPaging <ItemMaterialTemp> listPaging = itemMaterialBLL.searchBooked(itemMaterial.getCode(),itemMaterial.getName(),warehouseCode,paging);
                
                listItemMaterialTemp = listPaging.getList();
                
                return SUCCESS;
            }
            catch(Exception ex) {
                this.error = true;
                this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
                return SUCCESS;
            }
        }
    
    @Action("item-material-save")
    public String save() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
           
            if(itemMaterialBLL.isExist(this.itemMaterial.getCode())){
                this.error = true;
                this.errorMessage = "CODE "+this.itemMaterial.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemMaterialBLL.save(this.itemMaterial);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemMaterial.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-vendor-save")
    public String vendorSave() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
           
            Gson gson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listItemMaterialVendorDetail = gson.fromJson(this.listItemMaterialVendorDetailJSON, new TypeToken<List<ItemMaterialVendor>>(){}.getType());
            
//            if(itemMaterialBLL.isExist(this.itemMaterialVendorTemp.getCode())){
//                this.error = true;
//                this.errorMessage = "CODE "+this.itemMaterialVendorTemp.getCode()+" HAS BEEN EXISTS IN DATABASE!";
//            }else{
                itemMaterialBLL.vendorSave(this.listItemMaterialVendorDetail);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemMaterial.getCode();
//            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-update")
    public String update() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            
            itemMaterialBLL.update(this.itemMaterial);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemMaterial.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-delete")
    public String delete() {
        try {
            ItemMaterialBLL itemMaterialBLL = new ItemMaterialBLL(hbmSession);
            boolean check=false;// = itemMaterialBLL.isExistToDelete(this.itemMaterial.getCode());
            if(check == true){
                this.message = "CODE "+this.itemMaterial.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                itemMaterialBLL.delete(this.itemMaterial.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemMaterial.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("item-material-get-min")
    public String populateDataSupplierMin() {
        try {
            ItemMaterialBLL itemMaterialBLL=new ItemMaterialBLL(hbmSession);
            this.itemMaterialTemp = itemMaterialBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-material-get-max")
    public String populateDataSupplierMax() {
        try {
            ItemMaterialBLL itemMaterialBLL=new ItemMaterialBLL(hbmSession);
            this.itemMaterialTemp = itemMaterialBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ItemMaterial getItemMaterial() {
        return itemMaterial;
    }

    public void setItemMaterial(ItemMaterial itemMaterial) {
        this.itemMaterial = itemMaterial;
    }

    public ItemMaterialTemp getItemMaterialTemp() {
        return itemMaterialTemp;
    }

    public void setItemMaterialTemp(ItemMaterialTemp itemMaterialTemp) {
        this.itemMaterialTemp = itemMaterialTemp;
    }

    public List<ItemMaterialTemp> getListItemMaterialTemp() {
        return listItemMaterialTemp;
    }

    public void setListItemMaterialTemp(List<ItemMaterialTemp> listItemMaterialTemp) {
        this.listItemMaterialTemp = listItemMaterialTemp;
    }

    public String getItemMaterialSearchCode() {
        return itemMaterialSearchCode;
    }

    public void setItemMaterialSearchCode(String itemMaterialSearchCode) {
        this.itemMaterialSearchCode = itemMaterialSearchCode;
    }

    public String getItemMaterialSearchName() {
        return itemMaterialSearchName;
    }

    public void setItemMaterialSearchName(String itemMaterialSearchName) {
        this.itemMaterialSearchName = itemMaterialSearchName;
    }

    public String getItemMaterialSearchInventoryType() {
        return itemMaterialSearchInventoryType;
    }

    public void setItemMaterialSearchInventoryType(String itemMaterialSearchInventoryType) {
        this.itemMaterialSearchInventoryType = itemMaterialSearchInventoryType;
    }

    public String getItemMaterialSearchItemMaterialDivision() {
        return itemMaterialSearchItemMaterialDivision;
    }

    public void setItemMaterialSearchItemMaterialDivision(String itemMaterialSearchItemMaterialDivision) {
        this.itemMaterialSearchItemMaterialDivision = itemMaterialSearchItemMaterialDivision;
    }

    public String getItemMaterialSearchActiveStatus() {
        return itemMaterialSearchActiveStatus;
    }

    public void setItemMaterialSearchActiveStatus(String itemMaterialSearchActiveStatus) {
        this.itemMaterialSearchActiveStatus = itemMaterialSearchActiveStatus;
    }

    public String getItemMaterialSerialNoSearchWarehouseCode() {
        return itemMaterialSerialNoSearchWarehouseCode;
    }

    public void setItemMaterialSerialNoSearchWarehouseCode(String itemMaterialSerialNoSearchWarehouseCode) {
        this.itemMaterialSerialNoSearchWarehouseCode = itemMaterialSerialNoSearchWarehouseCode;
    }

    public String getItemMaterialSearchItemMaterialDivisionCode() {
        return itemMaterialSearchItemMaterialDivisionCode;
    }

    public void setItemMaterialSearchItemMaterialDivisionCode(String itemMaterialSearchItemMaterialDivisionCode) {
        this.itemMaterialSearchItemMaterialDivisionCode = itemMaterialSearchItemMaterialDivisionCode;
    }

    public String getItemMaterialSearchItemMaterialDivisionName() {
        return itemMaterialSearchItemMaterialDivisionName;
    }

    public void setItemMaterialSearchItemMaterialDivisionName(String itemMaterialSearchItemMaterialDivisionName) {
        this.itemMaterialSearchItemMaterialDivisionName = itemMaterialSearchItemMaterialDivisionName;
    }

    public String getItemMaterialSearchPriorityStatus() {
        return itemMaterialSearchPriorityStatus;
    }

    public void setItemMaterialSearchPriorityStatus(String itemMaterialSearchPriorityStatus) {
        this.itemMaterialSearchPriorityStatus = itemMaterialSearchPriorityStatus;
    }

//    public String getItemMaterialSearchSerialNoStatus() {
//        return itemMaterialSearchSerialNoStatus;
//    }
//
//    public void setItemMaterialSearchSerialNoStatus(String itemMaterialSearchSerialNoStatus) {
//        this.itemMaterialSearchSerialNoStatus = itemMaterialSearchSerialNoStatus;
//    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<ItemMaterial> getListItemMaterial() {
        return listItemMaterial;
    }

    public void setListItemMaterial(List<ItemMaterial> listItemMaterial) {
        this.listItemMaterial = listItemMaterial;
    }

    public ItemMaterial getSearchItemMaterial() {
        return searchItemMaterial;
    }

    public void setSearchItemMaterial(ItemMaterial searchItemMaterial) {
        this.searchItemMaterial = searchItemMaterial;
    }

    public EnumTriState.Enum_TriState getSearchItemMaterialActiveStatus() {
        return searchItemMaterialActiveStatus;
    }

    public void setSearchItemMaterialActiveStatus(EnumTriState.Enum_TriState searchItemMaterialActiveStatus) {
        this.searchItemMaterialActiveStatus = searchItemMaterialActiveStatus;
    }

    public ItemMaterialVendorTemp getItemMaterialVendorTemp() {
        return itemMaterialVendorTemp;
    }

    public void setItemMaterialVendorTemp(ItemMaterialVendorTemp itemMaterialVendorTemp) {
        this.itemMaterialVendorTemp = itemMaterialVendorTemp;
    }

    public List<ItemMaterialVendor> getListItemMaterialVendorDetail() {
        return listItemMaterialVendorDetail;
    }

    public void setListItemMaterialVendorDetail(List<ItemMaterialVendor> listItemMaterialVendorDetail) {
        this.listItemMaterialVendorDetail = listItemMaterialVendorDetail;
    }

    public String getListItemMaterialVendorDetailJSON() {
        return listItemMaterialVendorDetailJSON;
    }

    public void setListItemMaterialVendorDetailJSON(String listItemMaterialVendorDetailJSON) {
        this.listItemMaterialVendorDetailJSON = listItemMaterialVendorDetailJSON;
    }

    public ItemMaterialVendor getItemMaterialVendor() {
        return itemMaterialVendor;
    }

    public void setItemMaterialVendor(ItemMaterialVendor itemMaterialVendor) {
        this.itemMaterialVendor = itemMaterialVendor;
    }

    public List<ItemMaterialVendor> getListItemMaterialVendorDetailExisting() {
        return listItemMaterialVendorDetailExisting;
    }

    public void setListItemMaterialVendorDetailExisting(List<ItemMaterialVendor> listItemMaterialVendorDetailExisting) {
        this.listItemMaterialVendorDetailExisting = listItemMaterialVendorDetailExisting;
    }

    public String getListItemMaterialVendorDetailExistingJSON() {
        return listItemMaterialVendorDetailExistingJSON;
    }

    public void setListItemMaterialVendorDetailExistingJSON(String listItemMaterialVendorDetailExistingJSON) {
        this.listItemMaterialVendorDetailExistingJSON = listItemMaterialVendorDetailExistingJSON;
    }

    public String getItemMaterialVendorSearchCode() {
        return itemMaterialVendorSearchCode;
    }

    public void setItemMaterialVendorSearchCode(String itemMaterialVendorSearchCode) {
        this.itemMaterialVendorSearchCode = itemMaterialVendorSearchCode;
    }

    public String getItemMaterialVendorSearchName() {
        return itemMaterialVendorSearchName;
    }

    public void setItemMaterialVendorSearchName(String itemMaterialVendorSearchName) {
        this.itemMaterialVendorSearchName = itemMaterialVendorSearchName;
    }

    public String getItemMaterialVendorSearchActiveStatus() {
        return itemMaterialVendorSearchActiveStatus;
    }

    public void setItemMaterialVendorSearchActiveStatus(String itemMaterialVendorSearchActiveStatus) {
        this.itemMaterialVendorSearchActiveStatus = itemMaterialVendorSearchActiveStatus;
    }

    public String getItemMaterialVendorSearchNonSerialNoStatus() {
        return itemMaterialVendorSearchNonSerialNoStatus;
    }

    public void setItemMaterialVendorSearchNonSerialNoStatus(String itemMaterialVendorSearchNonSerialNoStatus) {
        this.itemMaterialVendorSearchNonSerialNoStatus = itemMaterialVendorSearchNonSerialNoStatus;
    }

    public String getItemMaterialVendorSearchVendorCode() {
        return itemMaterialVendorSearchVendorCode;
    }

    public void setItemMaterialVendorSearchVendorCode(String itemMaterialVendorSearchVendorCode) {
        this.itemMaterialVendorSearchVendorCode = itemMaterialVendorSearchVendorCode;
    }

    public String getItemMaterialJnVendorSearchCode() {
        return itemMaterialJnVendorSearchCode;
    }

    public void setItemMaterialJnVendorSearchCode(String itemMaterialJnVendorSearchCode) {
        this.itemMaterialJnVendorSearchCode = itemMaterialJnVendorSearchCode;
    }

    public String getItemMaterialJnVendorSearchName() {
        return itemMaterialJnVendorSearchName;
    }

    public void setItemMaterialJnVendorSearchName(String itemMaterialJnVendorSearchName) {
        this.itemMaterialJnVendorSearchName = itemMaterialJnVendorSearchName;
    }

    public String getItemMaterialJnVendorSearchVendorCode() {
        return itemMaterialJnVendorSearchVendorCode;
    }

    public void setItemMaterialJnVendorSearchVendorCode(String itemMaterialJnVendorSearchVendorCode) {
        this.itemMaterialJnVendorSearchVendorCode = itemMaterialJnVendorSearchVendorCode;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
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
    
    // <editor-fold defaultstate="collapsed" desc="Paging">
    
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
