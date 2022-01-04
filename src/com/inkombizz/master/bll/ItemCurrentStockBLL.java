package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.model.InventoryActualStock;
import com.inkombizz.inventory.model.InventoryActualStockTemp;
import com.inkombizz.inventory.model.IvtActualStock;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemCurrentStockDAO;
import com.inkombizz.master.model.ItemCurrentStock;
import com.inkombizz.master.model.ItemCurrentStockField;
import com.inkombizz.master.model.ItemCurrentStockTemp;

public class ItemCurrentStockBLL {
    
    public final String MODULECODE = "006_MST_ITEM_LOCATION";
    
    private ItemCurrentStockDAO itemCurrentStockDAO;
    
    public ItemCurrentStockBLL(HBMSession hbmSession) {
        this.itemCurrentStockDAO = new ItemCurrentStockDAO(hbmSession);
    }
    
    public ListPaging<ItemCurrentStockTemp> findData(Paging paging,String code, String name, String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countData(code,name, BranchCode, BranchName, WarehouseCode, WarehouseName,active));

            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findData(code,name,BranchCode, BranchName, WarehouseCode, WarehouseName,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
    public ListPaging<ItemCurrentStockTemp> findDataByAdjustmentOut(Paging paging,String code, String name, String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countDataByAdjustmentOut(code,name, BranchCode, BranchName, WarehouseCode, WarehouseName,active));       
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findDataByAdjustmentOut(code,name,BranchCode, BranchName, WarehouseCode, WarehouseName,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    public ListPaging<ItemCurrentStockTemp> findDataBySearchAdjustmentOut(Paging paging,String warehouseCode,String itemCode,String itemName,String rackCode, String rackName) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countDataBySearchAdjustmentOut(warehouseCode,itemCode,itemName,rackCode,rackName));       
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findDataBySearchAdjustmentOut(warehouseCode,itemCode,itemName,rackCode,rackName,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    public ListPaging<ItemCurrentStockTemp> findDataByWarehouseMutation(Paging paging,String warehouseCode,String itemCode,String itemName,String rackCode, String rackName) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countDataByWHM(warehouseCode,itemCode,itemName,rackCode, rackName));         
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findDataByWHM(warehouseCode,itemCode,itemName,rackCode, rackName,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }  
    
    public ListPaging<ItemCurrentStockTemp> findDataByPacking(Paging paging,String code, String name, String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String documentType) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countDataByPacking(code,name, BranchCode, BranchName, WarehouseCode, WarehouseName,documentType));       
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findDataByPacking(code,name,BranchCode, BranchName, WarehouseCode, WarehouseName,documentType,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }  
    
    public ListPaging<ItemCurrentStockTemp> populateDataByWarehouseMutation(Paging paging,String code, String name, String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active, String concat) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countPopulateDataByWHM(code,name, BranchCode, BranchName, WarehouseCode, WarehouseName,active,concat));       
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.populateDataByWHM(code,name,BranchCode, BranchName, WarehouseCode, WarehouseName,active,paging.getFromRow(), paging.getToRow(),concat);
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }             
    public ItemCurrentStockTemp findData(String code) throws Exception {
        try {
            return (ItemCurrentStockTemp) itemCurrentStockDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemCurrentStockTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemCurrentStockTemp) itemCurrentStockDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemCurrentStock itemLocation) throws Exception {
        try {
            itemCurrentStockDAO.save(itemLocation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemCurrentStock itemLocation) throws Exception {
        try {
            itemCurrentStockDAO.update(itemLocation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemCurrentStockDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
      
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemCurrentStock.class)
                            .add(Restrictions.eq(ItemCurrentStockField.CODE, code));
             
            if(itemCurrentStockDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
 
//    public List<IvtActualStock> findDataByPickingListSOItem(List<InventoryActualStockTemp> lstInventoryActualStockTemp) throws Exception {
//        try {
//            
//            List<IvtActualStock> listItemCurrentStockTemp = itemCurrentStockDAO.findDataByPickingListSOItem(lstInventoryActualStockTemp);
//                        
//            return listItemCurrentStockTemp;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
//    public List<IvtActualStock> findDataByPickingListBOItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            
//            List<IvtActualStock> listItemCurrentStockTemp = itemCurrentStockDAO.findDataByPickingListBOItem(lstInventoryActualStock);
//                        
//            return listItemCurrentStockTemp;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
    public List<IvtActualStock> findDataByAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
        try {
            
            List<IvtActualStock> listItemCurrentStockTemp = itemCurrentStockDAO.findDataByAssemblyRealization(lstInventoryActualStock);
                        
            return listItemCurrentStockTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public List<IvtActualStock> findDataByPickingListWHMItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            
//            List<IvtActualStock> listItemCurrentStockTemp = itemCurrentStockDAO.findDataByPickingListWHMItem(lstInventoryActualStock);
//                        
//            return listItemCurrentStockTemp;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
//    public List<IvtActualStock> findDataByPromoOutItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            
//            List<IvtActualStock> listItemCurrentStockTemp = itemCurrentStockDAO.findDataByPromoOutItem(lstInventoryActualStock);
//                        
//            return listItemCurrentStockTemp;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }

    public ItemCurrentStockDAO getItemCurrentStockDAO() {
        return itemCurrentStockDAO;
    }

    public void setItemCurrentStockDAO(ItemCurrentStockDAO itemCurrentStockDAO) {
        this.itemCurrentStockDAO = itemCurrentStockDAO;
    }
    
    public ListPaging<ItemCurrentStockTemp> findDataByPLTSOSPV(Paging paging,
            String ItemCode, String BranchCode, String WarehouseCode, String DocumentNo,
            String LotNo, String BatchNo, String RackCode, String RackName) throws Exception {
        try {
            paging.setRecords(itemCurrentStockDAO.countDataByPLTSOSPV(ItemCode, BranchCode, WarehouseCode, 
                    DocumentNo, LotNo, BatchNo, RackCode, RackName));       
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemLocationTemp = itemCurrentStockDAO.findDataByPLTSOSPV(ItemCode, 
                    BranchCode, WarehouseCode, DocumentNo, LotNo, BatchNo, RackCode, RackName,
                    paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ItemCurrentStockTemp findDataValidForPLTSOSPV(ItemCurrentStockTemp itemCurrentStockTemp) throws Exception {
        try {
            return (ItemCurrentStockTemp) itemCurrentStockDAO.findDataValidForPLTSOSPV(itemCurrentStockTemp);
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public String getMODULECODE() {
        return MODULECODE;
    }
    
}