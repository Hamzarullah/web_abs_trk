package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.model.InventoryActualStock;
import com.inkombizz.inventory.model.InventoryActualStockTemp;
import com.inkombizz.inventory.model.IvtActualStock;
import com.opensymphony.xwork2.ActionSupport;

import com.inkombizz.master.bll.ItemCurrentStockBLL;
import com.inkombizz.master.model.ItemCurrentStock;
import com.inkombizz.master.model.ItemCurrentStockTemp;
import com.inkombizz.master.model.Global;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


@Result (type="json")
public class ItemCurrentStockJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    
    private InventoryActualStock inventoryActualStock;
    private InventoryActualStockTemp inventoryActualStockTemp;
    private ItemCurrentStock itemLocation;
    private ItemCurrentStockTemp itemLocationTemp;
    private List <ItemCurrentStockTemp> listItemCurrentStockTemp;
    private List <InventoryActualStock> listInventoryActualStock;
    private List <InventoryActualStockTemp> listInventoryActualStockTemp;
    private List <IvtActualStock> listIvtActualStock;
    private List <IvtActualStock> listIvtActualStockBonus;
    private String itemLocationSearchCode = "";
    private String itemLocationSearchName = "";
    private String itemLocationSearchBranchCode = "";
    private String itemLocationSearchBranchName = "";
    private String itemLocationSearchWarehouseCode = "";
    private String itemLocationSearchWarehouseName = "";
    private String itemLocationSearchRackCode="";
    private String itemLocationSearchRackName="";
    private String itemLocationSearchActiveStatus = "true";
    private String itemLocationSearchDocumentType = "";
    private String actionAuthority="";
    private List<Global> lstGlobal;
    private String itemSearchCodeConcat="";
    private String listInventoryActualStockJSON="";
    private String listInventoryActualStockTempJSON="";
    private String customerCode = "";
    
    private String itemCurrentStockSearchItemCode = "";
    private String itemCurrentStockSearchItemName = "";
    private String itemCurrentStockSearchWarehouseCode = "";
    private String itemCurrentStockSearchRackCode = "";
    private String itemCurrentStockSearchRackName = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-data")
    public String findData() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findData(paging,itemLocationSearchCode,itemLocationSearchName,itemLocationSearchBranchCode,itemLocationSearchBranchName,itemLocationSearchWarehouseCode,itemLocationSearchWarehouseName,itemLocationSearchActiveStatus);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-by-adj-out-data")
    public String findDataByAdjustmentOut() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findDataByAdjustmentOut(paging,itemLocationSearchCode,itemLocationSearchName,itemLocationSearchBranchCode,itemLocationSearchBranchName,itemLocationSearchWarehouseCode,itemLocationSearchWarehouseName,itemLocationSearchActiveStatus);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-by-adj-out-search-data")
    public String findDataBySearchAdjustmentOut() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findDataBySearchAdjustmentOut(paging,itemCurrentStockSearchWarehouseCode,itemCurrentStockSearchItemCode,itemCurrentStockSearchItemName,itemCurrentStockSearchRackCode,itemCurrentStockSearchRackName);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-picking-list-so-item-data")
    public String findDataByPickingListSOItem() {
        try {
            ItemCurrentStockBLL itemCurrentStockBLL = new ItemCurrentStockBLL(hbmSession);
            Gson gson = new Gson();
            this.listInventoryActualStockTemp = gson.fromJson(this.listInventoryActualStockTempJSON, new TypeToken<List<InventoryActualStockTemp>>(){}.getType());           
            
            List<InventoryActualStockTemp> listInventoryActualStockNew = new ArrayList<InventoryActualStockTemp>();
            Map<String,Object> listItemQuantity = new HashMap<String,Object>();
            
            // loop buat dapetin summary per item
            for(InventoryActualStockTemp detail : listInventoryActualStockTemp){
                String keyDetail = detail.getItemMaterialCode();
                BigDecimal tempQuantity = BigDecimal.ZERO;
                BigDecimal newQuantity = BigDecimal.ZERO;
                
                if (listItemQuantity.get(keyDetail) == null) {
                    newQuantity = detail.getBookedStock();
                }else {
                    tempQuantity = (BigDecimal) listItemQuantity.get(keyDetail);
                    newQuantity = tempQuantity.add(detail.getBookedStock());
                }
                
                listItemQuantity.put(keyDetail, newQuantity);
            }
            
            // loop buat list baru
            for (String key : listItemQuantity.keySet()) {
                for(InventoryActualStockTemp detail : listInventoryActualStockTemp){
                    String validItem = detail.getItemMaterialCode();
                    if (key.equals(validItem)) {
                        InventoryActualStockTemp newLi = new InventoryActualStockTemp();
                        newLi.setWarehouseCode(detail.getWarehouseCode());
                        newLi.setItemMaterialCode(detail.getItemMaterialCode());
                        
                        BigDecimal qt = (BigDecimal) listItemQuantity.get(key);
                        newLi.setBookedStock(qt);
                        
                        listInventoryActualStockNew.add(newLi);
                        break;
                        
                    }
                }
            }
            
//            List<IvtActualStock> list = itemCurrentStockBLL.findDataByPickingListSOItem(listInventoryActualStockNew);
//            
//            //loop sesuai kebutuhan masing2
//            listIvtActualStock = new ArrayList<IvtActualStock>();
//            int need, necessary;
//            
//            for(InventoryActualStockTemp detail : listInventoryActualStockTemp){
//                String itemButuh = detail.getItemMaterialCode();
//                BigDecimal butuhQuantity = detail.getBookedStock();
//                
//                for(IvtActualStock hasil : list){
//                    String itemHasil = hasil.getItemMaterialCode();
//                    BigDecimal totalQuantity = hasil.getActualStock();
//                    BigDecimal nol = new BigDecimal("0");
//                    need = totalQuantity.compareTo(nol);
//                    necessary = butuhQuantity.compareTo(totalQuantity);
//                    
//                    if (itemButuh.equals(itemHasil)) {
//                        if (need == 1) {
//                            if (necessary == 0 || necessary == -1) {
//                                
//                                IvtActualStock newIVT = new IvtActualStock();
//                                    newIVT.setItemMaterialCode(itemHasil);
//                                    newIVT.setItemMaterialName(hasil.getItemMaterialName());
//                                    newIVT.setItemAlias(hasil.getItemAlias());
////                                    newIVT.setItemBrandCode(hasil.getItemBrandCode());
////                                    newIVT.setLotNo(hasil.getLotNo());
////                                    newIVT.setBatchNo(hasil.getBatchNo());
////                                    newIVT.setInTransactionNo(hasil.getInTransactionNo());
////                                    newIVT.setInDocumentType(hasil.getInDocumentType());
////                                    newIVT.setCOGSIDR(hasil.getCOGSIDR());
////                                    newIVT.setItemDate(hasil.getItemDate());
////                                    newIVT.setProductionDate(hasil.getProductionDate());
////                                    newIVT.setExpiredDate(hasil.getExpiredDate());
//                                    newIVT.setQuantity(butuhQuantity);
//                                    newIVT.setUnitOfMeasureCode(hasil.getUnitOfMeasureCode());
//                                    newIVT.setRackCode(hasil.getRackCode());
//                                    newIVT.setRackName(hasil.getRackName());
//                                
////                                if ("I".equals(detail.getCode())) {
//                                    listIvtActualStock.add(newIVT);
////                                }else if ("B".equals(detail.getCode())) {
////                                    listIvtActualStockBonus.add(newIVT);
////                                }
//                                
//                                // kurangi Qty yang udah berhasil
//                                detail.setBookedStock(nol);
//                                
//                                // kurangi Qty di hasil buat selanjutnya
//                                hasil.setQuantity(totalQuantity.subtract(butuhQuantity));
//                                
//                                break;
//                            } else if (necessary == 1) {
//                                
//                                IvtActualStock newIVT = new IvtActualStock();
//                                    newIVT.setItemMaterialCode(itemHasil);
//                                    newIVT.setItemMaterialName(hasil.getItemMaterialName());
//                                    newIVT.setItemAlias(hasil.getItemAlias());
////                                    newIVT.setItemBrandCode(hasil.getItemBrandCode());
////                                    newIVT.setLotNo(hasil.getLotNo());
////                                    newIVT.setBatchNo(hasil.getBatchNo());
////                                    newIVT.setInTransactionNo(hasil.getInTransactionNo());
////                                    newIVT.setInDocumentType(hasil.getInDocumentType());
////                                    newIVT.setCOGSIDR(hasil.getCOGSIDR());
////                                    newIVT.setItemDate(hasil.getItemDate());
////                                    newIVT.setProductionDate(hasil.getProductionDate());
////                                    newIVT.setExpiredDate(hasil.getExpiredDate());
//                                    newIVT.setQuantity(totalQuantity);
//                                    newIVT.setUnitOfMeasureCode(hasil.getUnitOfMeasureCode());
//                                    newIVT.setRackCode(hasil.getRackCode());
//                                    newIVT.setRackName(hasil.getRackName());
//                                    
////                                if ("I".equals(detail.getCode())) {
//                                    listIvtActualStock.add(newIVT);
////                                }else if ("B".equals(detail.getCode())) {
////                                    listIvtActualStockBonus.add(newIVT);
////                                }
//                                
//                                // kurangi Qty yang udah berhasil
//                                butuhQuantity =  butuhQuantity.add(totalQuantity.negate());
//                                
//                                // habiskan Qty di hasil
//                                hasil.setQuantity(nol);
//                                
//                            }
//                        }
//                    }
//                    
//                }
//            }
//            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("item-current-stock-picking-list-bo-item-data")
//    public String findDataByPickingListBOItem() {
//        try {
//            ItemCurrentStockBLL itemCurrentStockBLL = new ItemCurrentStockBLL(hbmSession);
//            Gson gson = new Gson();
//            this.listInventoryActualStock = gson.fromJson(this.listInventoryActualStockJSON, new TypeToken<List<InventoryActualStock>>(){}.getType());           
//            
//            List<IvtActualStock> list = itemCurrentStockBLL.findDataByPickingListBOItem(listInventoryActualStock);
//            
//            listIvtActualStock = list;
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("item-current-stock-assembly-realization-item-data")
    public String findDataByAssemblyRealization() {
        try {
            ItemCurrentStockBLL itemCurrentStockBLL = new ItemCurrentStockBLL(hbmSession);
            Gson gson = new Gson();
            this.listInventoryActualStock = gson.fromJson(this.listInventoryActualStockJSON, new TypeToken<List<InventoryActualStock>>(){}.getType());           
            
            List<IvtActualStock> list = itemCurrentStockBLL.findDataByAssemblyRealization(listInventoryActualStock);
            
            listIvtActualStock = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("item-current-stock-picking-list-whm-item-data")
//    public String findDataByPickingListWHMItem() {
//        try {
//            ItemCurrentStockBLL itemCurrentStockBLL = new ItemCurrentStockBLL(hbmSession);
//            Gson gson = new Gson();
//            this.listInventoryActualStock = gson.fromJson(this.listInventoryActualStockJSON, new TypeToken<List<InventoryActualStock>>(){}.getType());           
//            
//            List<IvtActualStock> list = itemCurrentStockBLL.findDataByPickingListWHMItem(listInventoryActualStock);
//            
//            listIvtActualStock = list;
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("item-current-stock-by-whm-data")
    public String findDataByWarehouseMutation() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findDataByWarehouseMutation(paging,itemCurrentStockSearchWarehouseCode,itemCurrentStockSearchItemCode,itemCurrentStockSearchItemName,itemCurrentStockSearchRackCode,itemCurrentStockSearchRackName);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-by-packing")
    public String findDataByPacking() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findDataByPacking(paging,itemLocationSearchCode,itemLocationSearchName,itemLocationSearchBranchCode,itemLocationSearchBranchName,itemLocationSearchWarehouseCode,itemLocationSearchWarehouseName,itemLocationSearchDocumentType);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-by-whm-data-with-array")
    public String populateDataByWarehouseMutation() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.populateDataByWarehouseMutation(paging,itemLocationSearchCode,itemLocationSearchName,itemLocationSearchBranchCode,itemLocationSearchBranchName,itemLocationSearchWarehouseCode,itemLocationSearchWarehouseName,itemLocationSearchActiveStatus,itemSearchCodeConcat);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("item-current-stock-get-data")
    public String findData1() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            this.itemLocationTemp = itemLocationBLL.findData(this.itemLocation.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-get")
    public String findData2() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            this.itemLocationTemp = itemLocationBLL.findData(this.itemLocation.getCode(),this.itemLocation.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-authority")
    public String itemLocationAuthority(){
        try{
            
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(itemLocationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
//    @Action("item-current-stock-promo-out-item-data")
//    public String findDataByPromoOutItem() {
//        try {
//            ItemCurrentStockBLL itemCurrentStockBLL = new ItemCurrentStockBLL(hbmSession);
//            Gson gson = new Gson();
//            this.listInventoryActualStock = gson.fromJson(this.listInventoryActualStockJSON, new TypeToken<List<InventoryActualStock>>(){}.getType());           
//            
//            List<IvtActualStock> list = itemCurrentStockBLL.findDataByPromoOutItem(listInventoryActualStock);
//            
//            listIvtActualStock = list;
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("item-current-stock-save")
    public String save() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
           
            if(itemLocationBLL.isExist(this.itemLocation.getCode())){
                this.errorMessage = "Code "+this.itemLocation.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                itemLocationBLL.save(this.itemLocation);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.itemLocation.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("item-current-stock-update")
    public String update() {
        try {
            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            
            itemLocationBLL.update(this.itemLocation);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.itemLocation.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("item-current-stock-delete")
//    public String delete() {
//        try {
//            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
//            GlobalBLL globalBLL=new GlobalBLL(hbmSession);
//            
//            lstGlobal=globalBLL.usedItemLocation(this.itemLocation.getCode());
//            
//            if(lstGlobal.isEmpty()){
//                itemLocationBLL.delete(this.itemLocation.getCode());
//                this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemLocation.getCode();
//            }else{
//                this.message = "Code: "+this.itemLocation.getCode() + " Is Used By "+lstGlobal.get(0).getUsedName()+" [ Code: "+ lstGlobal.get(0).getUsedCode() +" ]!";
//            }
//      
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("item-current-stock-delete")
    public String delete() {
        try {
           ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
            itemLocationBLL.delete(this.itemLocation.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.itemLocation.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("item-current-stock-by-plt-so-spv-data")
//    public String findDataByPLTSOSPV() {
//        try {
//            ItemCurrentStockBLL itemLocationBLL = new ItemCurrentStockBLL(hbmSession);
//            ListPaging <ItemCurrentStockTemp> listPaging = itemLocationBLL.findDataByPLTSOSPV(paging,
//                    itemCurrentStockSearchItemCode, itemCurrentStockSearchBranchCode, itemCurrentStockSearchWarehouseCode, 
//                    itemCurrentStockSearchDocumentNo, itemCurrentStockSearchLotNo, itemCurrentStockSearchBatchNo, 
//                    itemCurrentStockSearchRackCode, itemCurrentStockSearchRackName);
//            
//            listItemCurrentStockTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public InventoryActualStock getInventoryActualStock() {
        return inventoryActualStock;
    }

    public void setInventoryActualStock(InventoryActualStock inventoryActualStock) {
        this.inventoryActualStock = inventoryActualStock;
    }

    public ItemCurrentStock getItemLocation() {
        return itemLocation;
    }

    public void setItemLocation(ItemCurrentStock itemLocation) {
        this.itemLocation = itemLocation;
    }

    public ItemCurrentStockTemp getItemLocationTemp() {
        return itemLocationTemp;
    }

    public void setItemLocationTemp(ItemCurrentStockTemp itemLocationTemp) {
        this.itemLocationTemp = itemLocationTemp;
    }

    public List<ItemCurrentStockTemp> getListItemCurrentStockTemp() {
        return listItemCurrentStockTemp;
    }

    public void setListItemCurrentStockTemp(List<ItemCurrentStockTemp> listItemCurrentStockTemp) {
        this.listItemCurrentStockTemp = listItemCurrentStockTemp;
    }

    public List<InventoryActualStock> getListInventoryActualStock() {
        return listInventoryActualStock;
    }

    public void setListInventoryActualStock(List<InventoryActualStock> listInventoryActualStock) {
        this.listInventoryActualStock = listInventoryActualStock;
    }

    public List<IvtActualStock> getListIvtActualStock() {
        return listIvtActualStock;
    }

    public void setListIvtActualStock(List<IvtActualStock> listIvtActualStock) {
        this.listIvtActualStock = listIvtActualStock;
    }

    public List<IvtActualStock> getListIvtActualStockBonus() {
        return listIvtActualStockBonus;
    }

    public void setListIvtActualStockBonus(List<IvtActualStock> listIvtActualStockBonus) {
        this.listIvtActualStockBonus = listIvtActualStockBonus;
    }

    public String getItemLocationSearchCode() {
        return itemLocationSearchCode;
    }

    public void setItemLocationSearchCode(String itemLocationSearchCode) {
        this.itemLocationSearchCode = itemLocationSearchCode;
    }

    public String getItemLocationSearchName() {
        return itemLocationSearchName;
    }

    public void setItemLocationSearchName(String itemLocationSearchName) {
        this.itemLocationSearchName = itemLocationSearchName;
    }

    public String getItemLocationSearchBranchCode() {
        return itemLocationSearchBranchCode;
    }

    public void setItemLocationSearchBranchCode(String itemLocationSearchBranchCode) {
        this.itemLocationSearchBranchCode = itemLocationSearchBranchCode;
    }

    public String getItemLocationSearchBranchName() {
        return itemLocationSearchBranchName;
    }

    public void setItemLocationSearchBranchName(String itemLocationSearchBranchName) {
        this.itemLocationSearchBranchName = itemLocationSearchBranchName;
    }

    public String getItemLocationSearchWarehouseCode() {
        return itemLocationSearchWarehouseCode;
    }

    public void setItemLocationSearchWarehouseCode(String itemLocationSearchWarehouseCode) {
        this.itemLocationSearchWarehouseCode = itemLocationSearchWarehouseCode;
    }

    public String getItemLocationSearchWarehouseName() {
        return itemLocationSearchWarehouseName;
    }

    public void setItemLocationSearchWarehouseName(String itemLocationSearchWarehouseName) {
        this.itemLocationSearchWarehouseName = itemLocationSearchWarehouseName;
    }

    public String getItemLocationSearchRackCode() {
        return itemLocationSearchRackCode;
    }

    public void setItemLocationSearchRackCode(String itemLocationSearchRackCode) {
        this.itemLocationSearchRackCode = itemLocationSearchRackCode;
    }

    public String getItemLocationSearchRackName() {
        return itemLocationSearchRackName;
    }

    public void setItemLocationSearchRackName(String itemLocationSearchRackName) {
        this.itemLocationSearchRackName = itemLocationSearchRackName;
    }

    public String getItemLocationSearchActiveStatus() {
        return itemLocationSearchActiveStatus;
    }

    public void setItemLocationSearchActiveStatus(String itemLocationSearchActiveStatus) {
        this.itemLocationSearchActiveStatus = itemLocationSearchActiveStatus;
    }

    public String getItemLocationSearchDocumentType() {
        return itemLocationSearchDocumentType;
    }

    public void setItemLocationSearchDocumentType(String itemLocationSearchDocumentType) {
        this.itemLocationSearchDocumentType = itemLocationSearchDocumentType;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<Global> getLstGlobal() {
        return lstGlobal;
    }

    public void setLstGlobal(List<Global> lstGlobal) {
        this.lstGlobal = lstGlobal;
    }

    public String getItemSearchCodeConcat() {
        return itemSearchCodeConcat;
    }

    public void setItemSearchCodeConcat(String itemSearchCodeConcat) {
        this.itemSearchCodeConcat = itemSearchCodeConcat;
    }

    public String getListInventoryActualStockJSON() {
        return listInventoryActualStockJSON;
    }

    public void setListInventoryActualStockJSON(String listInventoryActualStockJSON) {
        this.listInventoryActualStockJSON = listInventoryActualStockJSON;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getItemCurrentStockSearchItemCode() {
        return itemCurrentStockSearchItemCode;
    }

    public void setItemCurrentStockSearchItemCode(String itemCurrentStockSearchItemCode) {
        this.itemCurrentStockSearchItemCode = itemCurrentStockSearchItemCode;
    }

    public String getItemCurrentStockSearchItemName() {
        return itemCurrentStockSearchItemName;
    }

    public void setItemCurrentStockSearchItemName(String itemCurrentStockSearchItemName) {
        this.itemCurrentStockSearchItemName = itemCurrentStockSearchItemName;
    }

    public String getItemCurrentStockSearchWarehouseCode() {
        return itemCurrentStockSearchWarehouseCode;
    }

    public void setItemCurrentStockSearchWarehouseCode(String itemCurrentStockSearchWarehouseCode) {
        this.itemCurrentStockSearchWarehouseCode = itemCurrentStockSearchWarehouseCode;
    }

    public String getItemCurrentStockSearchRackCode() {
        return itemCurrentStockSearchRackCode;
    }

    public void setItemCurrentStockSearchRackCode(String itemCurrentStockSearchRackCode) {
        this.itemCurrentStockSearchRackCode = itemCurrentStockSearchRackCode;
    }

    public String getItemCurrentStockSearchRackName() {
        return itemCurrentStockSearchRackName;
    }

    public void setItemCurrentStockSearchRackName(String itemCurrentStockSearchRackName) {
        this.itemCurrentStockSearchRackName = itemCurrentStockSearchRackName;
    }

    public InventoryActualStockTemp getInventoryActualStockTemp() {
        return inventoryActualStockTemp;
    }

    public void setInventoryActualStockTemp(InventoryActualStockTemp inventoryActualStockTemp) {
        this.inventoryActualStockTemp = inventoryActualStockTemp;
    }

    public List<InventoryActualStockTemp> getListInventoryActualStockTemp() {
        return listInventoryActualStockTemp;
    }

    public void setListInventoryActualStockTemp(List<InventoryActualStockTemp> listInventoryActualStockTemp) {
        this.listInventoryActualStockTemp = listInventoryActualStockTemp;
    }

    public String getListInventoryActualStockTempJSON() {
        return listInventoryActualStockTempJSON;
    }

    public void setListInventoryActualStockTempJSON(String listInventoryActualStockTempJSON) {
        this.listInventoryActualStockTempJSON = listInventoryActualStockTempJSON;
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