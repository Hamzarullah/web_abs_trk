
package com.inkombizz.common;

import com.inkombizz.inventory.model.InventoryActualStock;
import com.inkombizz.inventory.model.InventoryMinusStock;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.inventory.model.IvtCogsIdr;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Warehouse;
import java.math.BigDecimal;
import java.util.Date;

public class InventoryCommon {
    
    /* Untuk Set mst_minus_stock */
//    public static InventoryMinusStock newInstance(String branchCode,  Warehouse warehouse, ItemMaterial itemMaterial, double quantity) {
//        
//        InventoryMinusStock inventoryStockMinus = new InventoryMinusStock();
//        
//        String code = branchCode + "/" + warehouse.getCode() + "-" + itemMaterial.getCode();
//
//        inventoryStockMinus.setCode(code);
//        inventoryStockMinus.setBranchCode(branchCode);
//        inventoryStockMinus.setWarehouse(warehouse);
//        inventoryStockMinus.setItemMaterial(itemMaterial);
//        inventoryStockMinus.setMinusQuantity(quantity);
//        
//        return inventoryStockMinus;
//    }
//    
//    public static IvtActualStock newInstance(String branchCode,  String warehouse, String itemMaterial, Date itemMaterialDate, double cogsIdr, boolean isCogsStatus) {
//        
//        IvtActualStock ivtActualStock = new IvtActualStock();
//        
//        String code = branchCode + "/" + warehouse + "-" + itemMaterial;
//
//        ivtActualStock.setCode(code);
//        ivtActualStock.setBranchCode(branchCode);
//        ivtActualStock.setWarehouseCode(warehouse);
//        ivtActualStock.setItemMaterialCode(itemMaterial);
//        ivtActualStock.setCOGSIDR(cogsIdr);
//        
//        return ivtActualStock;
//    }
    
    /* Untuk Set Decrease/Increase Stock Global */
//    public static IvtActualStock newInstance(String branchCode,String warehouseCode, String oldWarehouseCode,
//                                             double cogsIdr, String itemMaterialCode, Date itemMaterialDate, double actualStock,boolean isCogsStatus){
//        IvtActualStock ivtActualStock = new IvtActualStock();
//
//        ivtActualStock.setBranchCode(branchCode);
//        ivtActualStock.setWarehouseCode(warehouseCode);
//   //     ivtActualStock.setOldWarehouseCode(oldWarehouseCode);
//        ivtActualStock.setItemMaterialCode(itemMaterialCode);
//        ivtActualStock.setItemMaterialDate(itemMaterialDate);
//        ivtActualStock.setActualStock(actualStock);
//   //     ivtActualStock.setUsedStock(actualStock);
//        ivtActualStock.setCOGSIDR(cogsIdr);
//   //     ivtActualStock.setCogsStatus(isCogsStatus);
//   //     ivtActualStock.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//   //     ivtActualStock.setCreatedDate(new Date());
//        
//        return ivtActualStock;
//    }
    
    //Delete GoodsReceivedNote
    public static IvtActualStock newInstance(String branchCode,String warehouseCode, String itemMaterialCode, 
            BigDecimal newQuantity, String rackCode, String heatNo){
        
        IvtActualStock ivtActualStock = new IvtActualStock();
        String code = warehouseCode + "/" + itemMaterialCode + "-" + rackCode;
        ivtActualStock.setBranchCode(branchCode);
        ivtActualStock.setCode(code);
        ivtActualStock.setWarehouseCode(warehouseCode);
        ivtActualStock.setItemMaterialCode(itemMaterialCode);
        ivtActualStock.setRackCode(rackCode);
        ivtActualStock.setActualStock(newQuantity);
        ivtActualStock.setHeatNo(heatNo);
        
        return ivtActualStock;
    }
        
    /* FOR COGS DECREASE */
//    public static IvtActualStock newInstanceCOGSDecrease(String branchCode,String warehouseCode,
//        double cogsIdr, String itemMaterialCode, Date itemMaterialDate, String itemMaterialBrand, double actualStock, String lotNo, 
//        String batchNo,Date expiredDate, String inTransactionNo,String rackCode,String inDocumentType){
//        IvtActualStock ivtActualStock = new IvtActualStock();
//
//        ivtActualStock.setBranchCode(branchCode);
//        ivtActualStock.setWarehouseCode(warehouseCode);
//        ivtActualStock.setItemMaterialCode(itemMaterialCode);
//        ivtActualStock.setItemMaterialDate(itemMaterialDate);
//    //    ivtActualStock.setItemMaterialBrand(itemMaterialBrand);
//        ivtActualStock.setActualStock(actualStock);
//   //     ivtActualStock.setUsedStock(actualStock);
//        ivtActualStock.setCOGSIDR(cogsIdr);
//    //    ivtActualStock.setLotNo(lotNo);
//    //    ivtActualStock.setBatchNo(batchNo);
//    //    ivtActualStock.setExpiredDate(expiredDate);
////        ivtActualStock.setCreatedBy(BaseSession.loadProgramSession().getUserName());
////        ivtActualStock.setCreatedDate(new Date());
////        ivtActualStock.setInTransactionNo(inTransactionNo);
////        ivtActualStock.setInDocumentType(inDocumentType);
//        ivtActualStock.setRackCode(rackCode);
//        
//        return ivtActualStock;
//    }
    
    /* Untuk Set COGS IDR Global */  
    public static IvtCogsIdr newInstance(String COGSNo,String branchCode,String warehouseCode,
            String itemMaterialCode,String rackCode,Date itemMaterialDate,BigDecimal quantity,BigDecimal cogsIdr){
        
        IvtCogsIdr ivtCogsIdr = new IvtCogsIdr();
        
        ivtCogsIdr.setBranchCode(branchCode);
        ivtCogsIdr.setCOGSNo(COGSNo);
        ivtCogsIdr.setWarehouseCode(warehouseCode);
        ivtCogsIdr.setItemMaterialCode(itemMaterialCode);
        ivtCogsIdr.setRackCode(rackCode);
        ivtCogsIdr.setUsedStockDate(itemMaterialDate);
        ivtCogsIdr.setItemMaterialQuantity(quantity);
        ivtCogsIdr.setUsedStockCOGS(cogsIdr);
        
        return ivtCogsIdr;
    }
    
    
//    public static IvtActualStock newInstance(String branchCode,  String warehouse, String itemMaterial, Date itemMaterialDate, double usestock) {
//        
//        IvtActualStock ivtActualStock = new IvtActualStock();
//        
//        String code = branchCode + "/" + warehouse + "-" + itemMaterial;
//
//        ivtActualStock.setCode(code);
//        ivtActualStock.setBranchCode(branchCode);
//        ivtActualStock.setWarehouseCode(warehouse);
//        ivtActualStock.setItemMaterialCode(itemMaterial);
//    //    ivtActualStock.setUsedStock(usestock);
//        
//        return ivtActualStock;
//    }

    //ActualStockIncrease_AVG
    public static InventoryActualStock newInstance(Warehouse warehouse, ItemMaterial itemMaterial, BigDecimal itemMaterialQuantity, Rack rack, String heatNo) {
        InventoryActualStock ivtActualStock = new InventoryActualStock();
        String codew = warehouse.getCode() + "/" + itemMaterial.getCode() + "-" + rack.getCode();
        ivtActualStock.setCode(codew);
        ivtActualStock.setWarehouse(warehouse);
        ivtActualStock.setItemMaterial(itemMaterial);
        ivtActualStock.setActualStock(itemMaterialQuantity);
        ivtActualStock.setRack(rack);
        ivtActualStock.setHeatNo(heatNo);
        
        return ivtActualStock;
    }
       
    
    //: ActualStockDecrease_AVG
    //: GOodsReceivedNote
    public static IvtActualStock newInstance(String warehouseCode, String branchCode, String itemMaterialCode, BigDecimal actualStock,BigDecimal cogsIdr, String rackCode) {
             
        IvtActualStock ivtActualStock = new IvtActualStock();
        String code = warehouseCode + "/" + branchCode + "-" + itemMaterialCode;
        ivtActualStock.setCode(code);
        ivtActualStock.setWarehouseCode(warehouseCode);
        ivtActualStock.setCOGSIDR(cogsIdr);
        ivtActualStock.setBranchCode(branchCode);
        ivtActualStock.setItemMaterialCode(itemMaterialCode);
        ivtActualStock.setRackCode(rackCode);
        ivtActualStock.setActualStock(actualStock);       
        return ivtActualStock;
        
    }

//    public static IvtActualStock newInstance(String branchCode, String warehouseCode, int i, String itemMaterialCode, Date date, double doubleValue, boolean b) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }
//
//    public static IvtActualStock newInstance(String branchCode, String warehouseCode, double doubleValue, String itemMaterialCode, Date date, double doubleValue0, boolean b) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }

    
}
