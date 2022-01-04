package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.InventoryInOutDAO;
import com.inkombizz.inventory.model.InventoryActualStock;
import com.inkombizz.inventory.model.InventoryActualStockTemp;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.master.model.ItemCurrentStockField;
import com.inkombizz.system.dao.TransactionLogDAO;

import com.inkombizz.master.model.ItemCurrentStock;
import com.inkombizz.master.model.ItemCurrentStockTemp;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;


public class ItemCurrentStockDAO {
    
    private HBMSession hbmSession;
    
    public ItemCurrentStockDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataByAdjustmentOut(String code,String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataBySearchAdjustmentOut(String warehouseCode,String itemCode,String itemName,String rackCode, String rackName){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(*) " +
                "FROM mst_item_jn_current_stock " +
                "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.WarehouseCode=mst_warehouse.Code " +
                "INNER JOIN mst_item_material ON mst_item_jn_current_stock.ItemCode=mst_item_material.Code " +
                "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.Code " +
                "WHERE mst_item_jn_current_stock.WarehouseCode='"+warehouseCode+"' " +
                "AND mst_item_jn_current_stock.ItemCode LIKE '%"+itemCode+"%' " +
                "AND mst_item_material.Name LIKE '%"+itemName+"%' " +
                "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+rackCode+"%' " +
                "AND mst_rack.`Name` LIKE '%"+rackName+"%' " +
                "AND mst_item_jn_current_stock.ActualStock > 0 "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataByWHM(String warehouseCode,String itemCode,String itemName,String rackCode, String rackName){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) " +
                "FROM mst_item_jn_current_stock " +
                "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.WarehouseCode=mst_warehouse.Code " +
                "INNER JOIN mst_item_material ON mst_item_jn_current_stock.ItemCode=mst_item_material.Code " +
                "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.Code " +
                "WHERE mst_item_jn_current_stock.WarehouseCode='"+warehouseCode+"' " +
                "AND mst_item_jn_current_stock.ItemCode LIKE '%"+itemCode+"%' " +
                "AND mst_item_material.Name LIKE '%"+itemName+"%' " +
                "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+rackCode+"%' " +
                "AND mst_rack.`Name` LIKE '%"+rackName+"%' " +
                "AND mst_item_jn_current_stock.ActualStock > 0 "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataByPacking(String code,String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String documentType){
        try{
            String querry = "";
            if(documentType.equals("packingRawMaterialWaste")){
                querry = "AND mst_item_material.ModuleType = 'MATERIAL' AND mst_item_material.`AfkirStatus` = 0 AND mst_item_material.`ExtraMixStatus` = 0 ";
            }else{
                querry = "AND mst_item_material.ModuleType = 'MATERIAL' OR mst_item_material.`AfkirStatus` = 1 OR mst_item_material.`ExtraMixStatus` = 1 ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "      
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "+querry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countPopulateDataByWHM(String code,String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active,String concat){
        try{
             String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "WHERE mst_item_material.code IN("+concatTemp+") "
                + "AND mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public ItemCurrentStockTemp findData(String code) {
        try {
                ItemCurrentStockTemp itemCurrentStockTemp = (ItemCurrentStockTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.COGSIDR, "
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.inDocumentType, "
                + "mst_item_jn_current_stock.createdBy, "
                + "mst_item_jn_current_stock.createdDate "
                + "FROM mst_item_jn_current_stock "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.ItemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "            
                + "WHERE mst_item_jn_current_stock.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("cogs", Hibernate.BIG_DECIMAL)
                .addScalar("itemDate", Hibernate.DATE)
                .addScalar("inTransactionNo", Hibernate.STRING)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .uniqueResult(); 
                 
                return itemCurrentStockTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemCurrentStockTemp findData(String code,boolean active) {
        try {
               ItemCurrentStockTemp itemCurrentStockTemp = (ItemCurrentStockTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_jn_current_stock.Code "
                + "FROM mst_item_jn_current_stock "
                + "WHERE mst_item_jn_current_stock.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .uniqueResult(); 
                 
                return itemCurrentStockTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemCurrentStockTemp> findData(String code, String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active,int from, int row) {
        try { 
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemCode, "
                + "mst_item_material.name AS itemName, "
                + "mst_item_material.itemalias AS itemAlias, "
                + "mst_item_material.InventoryType AS inventoryType, "         
                + "mst_unit_of_measure.code AS uomCode, "
                + "mst_unit_of_measure.name AS uomName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.lotNo, "
                + "mst_item_jn_current_stock.batchNo, "
                + "mst_item_jn_current_stock.ExpiredDate, "
                + "mst_item_jn_current_stock.cogsidr as cogs, "
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.Name AS rackName, "
                + "mst_item_jn_current_stock.inDocumentType "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode = mst_rack.code "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.itemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "          
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "ORDER BY mst_item_jn_current_stock.code ASC "
                + "LIMIT "+from+","+row+""
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("uomCode", Hibernate.STRING)
                .addScalar("uomName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("lotNo", Hibernate.STRING)
                .addScalar("batchNo", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expiredDate", Hibernate.DATE)
                .addScalar("itemDate", Hibernate.DATE)
                .addScalar("cogs", Hibernate.BIG_DECIMAL)
                .addScalar("inTransactionNo", Hibernate.STRING)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemCurrentStockTemp> findDataByAdjustmentOut(String code, String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active,int from, int row) {
        try { 
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_material.itemalias AS itemAlias, "
                + "mst_item_material.InventoryType AS inventoryType, "
                + "mst_unit_of_measure.code AS uomCode, "
                + "mst_unit_of_measure.name AS uomName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.lotNo, "
                + "mst_item_jn_current_stock.batchNo, "
                + "mst_item_jn_current_stock.ExpiredDate, "
                + "mst_item_jn_current_stock.cogsidr as cogs, "
                + "(SUM((mst_item_jn_current_stock.ActualStock-mst_item_jn_current_stock.UsedStock)-mst_item_jn_current_stock.BookedStock) / IFNULL(mst_unit_of_measure_conversion.Conversion,0)) AS quantity, "     
                + "IFNULL(mst_unit_of_measure_conversion.Conversion,0) AS conversion, "     
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.Name AS rackName, "
                + "mst_item_jn_current_stock.inDocumentType "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode = mst_rack.code "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.itemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "INNER JOIN mst_unit_of_measure ON mst_item.DefaultUnitOfMeasureCode = mst_unit_of_measure.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "          
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
                + "GROUP BY mst_item_material.code, mst_item_jn_current_stock.RackCode, mst_warehouse.Code, "
                + "mst_item_jn_current_stock.InDocumentType, mst_item_jn_current_stock.ItemDate,mst_item_jn_current_stock.COGSIDR, "
                + "mst_item_brand.Code, mst_item_jn_current_stock.LotNo, mst_item_jn_current_stock.BatchNo,mst_rack.Code,mst_item_jn_current_stock.ExpiredDate  "        
                + "ORDER BY mst_item_jn_current_stock.code ASC "
                + "LIMIT "+from+","+row+""
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("uomCode", Hibernate.STRING)
                .addScalar("uomName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("lotNo", Hibernate.STRING)
                .addScalar("batchNo", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expiredDate", Hibernate.DATE)
                .addScalar("itemDate", Hibernate.DATE)
                .addScalar("cogs", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inTransactionNo", Hibernate.STRING)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ItemCurrentStockTemp> findDataBySearchAdjustmentOut(String warehouseCode,String itemCode,String itemName,String rackCode, String rackName,int from, int row) {
        try { 
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "mst_item_jn_current_stock.Code, " +
                "mst_item_jn_current_stock.WarehouseCode, " +
                "mst_warehouse.Name AS WarehouseName, " +
                "mst_item_material.Code AS itemMaterialCode, " +
                "mst_item_material.Name AS itemMaterialName, " +
                "mst_item_material.InventoryType AS itemMaterialInventoryType, " +
                "mst_item_jn_current_stock.RackCode, " +
                "mst_rack.Name AS RackName, " +
                "mst_item_jn_current_stock.ActualStock, " +
                "mst_item_material.COGSIDR AS itemMaterialCogsIdr " +
                "FROM mst_item_jn_current_stock " +
                "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.WarehouseCode=mst_warehouse.Code " +
                "INNER JOIN mst_item_material ON mst_item_jn_current_stock.ItemCode=mst_item_material.Code " +
                "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.Code " +
                "WHERE mst_item_jn_current_stock.WarehouseCode='"+warehouseCode+"' " +
                "AND mst_item_jn_current_stock.ItemCode LIKE '%"+itemCode+"%' " +
                "AND mst_item_material.Name LIKE '%"+itemName+"%' " +
                "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+rackCode+"%' " +
                "AND mst_rack.`Name` LIKE '%"+rackName+"%' " +
                "AND mst_item_jn_current_stock.ActualStock > 0 " +
                "ORDER BY mst_item_jn_current_stock.RackCode ASC "+ 
                "LIMIT "+from+","+row+""
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemMaterialInventoryType", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("actualStock", Hibernate.BIG_DECIMAL)
                .addScalar("itemMaterialCogsIdr", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ItemCurrentStockTemp> findDataByWHM(String warehouseCode,String itemCode,String itemName,String rackCode, String rackName,int from, int row) {
        try { 
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "mst_item_jn_current_stock.Code, " +
                "mst_item_jn_current_stock.WarehouseCode, " +
                "mst_warehouse.Name AS WarehouseName, " +
                "mst_item_jn_current_stock.ItemCode AS itemMaterialCode, " +
                "mst_item_material.Name AS ItemMaterialName, " +
                "mst_item_material.COGSIDR AS ItemMaterialCogsIdr, " +
                "mst_item_material.InventoryType AS ItemMaterialInventoryType, " +
                "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, " +
                "mst_item_jn_current_stock.RackCode, " +
                "mst_rack.Name AS RackName, " +
                "mst_item_jn_current_stock.ActualStock " +
                "FROM mst_item_jn_current_stock " +
                "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.WarehouseCode=mst_warehouse.Code " +
                "INNER JOIN mst_item_material ON mst_item_jn_current_stock.ItemCode=mst_item_material.Code " +
                "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode=mst_rack.Code " +
                "WHERE mst_item_jn_current_stock.WarehouseCode='"+warehouseCode+"' " +
                "AND mst_item_jn_current_stock.ItemCode LIKE '%"+itemCode+"%' " +
                "AND mst_item_material.Name LIKE '%"+itemName+"%' " +
                "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+rackCode+"%' " +
                "AND mst_rack.`Name` LIKE '%"+rackName+"%' " +
                "AND mst_rack.`RackCategory` <> 'DOCK_DLN' " +
                "AND mst_item_jn_current_stock.ActualStock > 0 " +
                "ORDER BY mst_item_jn_current_stock.RackCode ASC "+ 
                "LIMIT "+from+","+row+""
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemMaterialInventoryType", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemMaterialCogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("actualStock", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemCurrentStockTemp> findDataByPacking(String code, String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String documentType,int from, int row) {
        try {
            String querry = "";
            if(!documentType.equals("packingRawMaterialWaste")){
                querry = " UNION "
                + "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_material.itemalias AS itemAlias, "
                + "mst_item_material.InventoryType AS itemMaterialInventoryType, "
                + "mst_unit_of_measure.code AS uomCode, "
                + "mst_unit_of_measure.name AS uomName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.lotNo, "
                + "mst_item_jn_current_stock.batchNo, "
                + "mst_item_jn_current_stock.ExpiredDate, "
                + "mst_item_jn_current_stock.cogsidr as cogs, "
                + "(SUM((mst_item_jn_current_stock.ActualStock-mst_item_jn_current_stock.UsedStock)-mst_item_jn_current_stock.BookedStock) / IFNULL(mst_unit_of_measure_conversion.Conversion,0)) AS quantity, "     
                + "IFNULL(mst_unit_of_measure_conversion.Conversion,0) AS conversion, "     
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.productionDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.Name AS rackName, "
                + "mst_item_jn_current_stock.inDocumentType "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode = mst_rack.code "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.itemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "INNER JOIN mst_unit_of_measure ON mst_item.DefaultUnitOfMeasureCode = mst_unit_of_measure.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "          
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
                + "AND mst_item_material.`AfkirStatus` = 1 OR mst_item.`ExtraMixStatus` = 1 "
                + "GROUP BY mst_item_material.code, mst_item_jn_current_stock.RackCode, mst_warehouse.Code, "
                + "mst_item_jn_current_stock.InDocumentType, mst_item_jn_current_stock.ItemDate,mst_item_jn_current_stock.COGSIDR, "
                + "mst_item_brand.Code, mst_item_jn_current_stock.LotNo, mst_item_jn_current_stock.BatchNo,mst_rack.Code,mst_item_jn_current_stock.ExpiredDate  ";
            }
            
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT * FROM( "
                + "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_material.itemalias AS itemAlias, "
                + "mst_item_material.InventoryType AS itemMaterialInventoryType, "
                + "mst_unit_of_measure.code AS itemMaterialUnitOfMeasureCode, "
                + "mst_unit_of_measure.name AS itemMaterialUnitOfMeasureName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.lotNo, "
                + "mst_item_jn_current_stock.batchNo, "
                + "mst_item_jn_current_stock.ExpiredDate, "
                + "mst_item_jn_current_stock.cogsidr as cogs, "
                + "(SUM((mst_item_jn_current_stock.ActualStock-mst_item_jn_current_stock.UsedStock)-mst_item_jn_current_stock.BookedStock) / IFNULL(mst_unit_of_measure_conversion.Conversion,0)) AS quantity, "     
                + "IFNULL(mst_unit_of_measure_conversion.Conversion,0) AS conversion, "     
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.productionDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.Name AS rackName, "
                + "mst_item_jn_current_stock.inDocumentType "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode = mst_rack.code "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.itemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "INNER JOIN mst_unit_of_measure ON mst_item.DefaultUnitOfMeasureCode = mst_unit_of_measure.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "          
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
                + "AND mst_item_material.ModuleType = 'MATERIAL' AND mst_item_material.`AfkirStatus` = 0 AND mst_item_material.`ExtraMixStatus` = 0 "
                + "GROUP BY mst_item_material.code, mst_item_jn_current_stock.RackCode, mst_warehouse.Code, "
                + "mst_item_jn_current_stock.InDocumentType, mst_item_jn_current_stock.ItemDate,mst_item_jn_current_stock.COGSIDR, "
                + "mst_item_brand.Code, mst_item_jn_current_stock.LotNo, mst_item_jn_current_stock.BatchNo,mst_rack.Code,mst_item_jn_current_stock.ExpiredDate  "        
                + " "+querry
                + " )AS qwe "
                + " ORDER BY qwe.itemcode ASC "
                + "LIMIT "+from+","+row+""
                )
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("itemMaterialInventoryType", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("lotNo", Hibernate.STRING)
                .addScalar("batchNo", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expiredDate", Hibernate.TIMESTAMP)
                .addScalar("itemDate", Hibernate.TIMESTAMP)
                .addScalar("cogs", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inTransactionNo", Hibernate.STRING)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("productionDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemCurrentStockTemp> populateDataByWHM(String code, String name,String BranchCode, String BranchName, String WarehouseCode, String WarehouseName,String active,int from, int row,String concat) {
        try { 
              
            String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_item_jn_current_stock.Code AS code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_material.itemalias AS itemAlias, "
                + "mst_item_material.InventoryType AS itemMaterialInventoryType, "
                + "mst_unit_of_measure.code AS itemMaterialUnitOfMeasureCode, "
                + "mst_unit_of_measure.name AS itemMaterialUnitOfMeasureName, "
                + "mst_item_brand.code AS itemBrandCode, "
                + "mst_item_brand.name AS itemBrandName, "
                + "mst_item_jn_current_stock.warehouseCode AS warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.lotNo, "
                + "mst_item_jn_current_stock.batchNo, "
                + "mst_item_jn_current_stock.ExpiredDate, "
                + "mst_item_jn_current_stock.cogsidr as cogs, "
                + "(SUM((mst_item_jn_current_stock.ActualStock-mst_item_jn_current_stock.UsedStock)-mst_item_jn_current_stock.BookedStock) / IFNULL(mst_unit_of_measure_conversion.Conversion,0)) AS quantity, "     
                + "IFNULL(mst_unit_of_measure_conversion.Conversion,0) AS conversion, "     
                + "mst_item_jn_current_stock.itemDate, "
                + "mst_item_jn_current_stock.productionDate, "
                + "mst_item_jn_current_stock.inTransactionNo, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.Name AS rackName, "
                + "mst_item_jn_current_stock.inDocumentType "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_rack ON mst_item_jn_current_stock.RackCode = mst_rack.code "
                + "LEFT JOIN mst_item_brand ON mst_item_jn_current_stock.itemBrandCode = mst_item_brand.code "
                + "INNER JOIN mst_item_material ON mst_item_jn_current_stock.itemCode = mst_item_material.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.DefaultUnitOfMeasureCode = mst_unit_of_measure.code "
                + "INNER JOIN mst_warehouse ON mst_item_jn_current_stock.warehouseCode = mst_warehouse.code "
                + "INNER JOIN mst_unit_of_measure_conversion ON mst_unit_of_measure_conversion.MainUnitOfMeasureCode = mst_item_material.`DefaultUnitOfMeasureCode` " 
                + "     AND mst_unit_of_measure_conversion.`SubUnitOfMeasureCode` = mst_item_material.`BasedUnitOfMeasureCode` "          
                + "WHERE mst_item_material.code IN("+concatTemp+") "
                + "AND mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_branch.name LIKE '%"+BranchName+"%' "
                + "AND mst_item_jn_current_stock.warehouseCode LIKE '%"+WarehouseCode+"%' "
                + "AND mst_warehouse.name LIKE '%"+WarehouseName+"%' "
                + "AND mst_item_jn_current_stock.ActualStock > (mst_item_jn_current_stock.BookedStock + mst_item_jn_current_stock.UsedStock) "
                + "GROUP BY mst_item_material.code, mst_item_jn_current_stock.RackCode, mst_warehouse.Code, "
                + "mst_item_jn_current_stock.InDocumentType, mst_item_jn_current_stock.ItemDate,mst_item_jn_current_stock.COGSIDR, "
                + "mst_item_brand.Code, mst_item_jn_current_stock.LotNo, mst_item_jn_current_stock.BatchNo,mst_rack.Code,mst_item_jn_current_stock.ExpiredDate  "        
                + "ORDER BY mst_item_jn_current_stock.code ASC "
                + "LIMIT "+from+","+row+""
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("itemMaterialInventoryType", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("lotNo", Hibernate.STRING)
                .addScalar("batchNo", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expiredDate", Hibernate.TIMESTAMP)
                .addScalar("itemDate", Hibernate.TIMESTAMP)
                .addScalar("cogs", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inTransactionNo", Hibernate.STRING)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("productionDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemCurrentStock itemLocation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            String code = itemLocation.getName()+itemLocation.getWarehouse().getCode();
            itemLocation.setCode(code);
            itemLocation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemLocation.setCreatedDate(new Date()); 
            hbmSession.hSession.save(itemLocation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemLocation.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemCurrentStock itemLocation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemLocation.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemLocation.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemLocation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemLocation.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + ItemCurrentStockField.BEAN_NAME + " WHERE " + ItemCurrentStockField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
                    
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
//    public int checkIsExistToDeleteCustomer (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_customer ON mst_customer.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE mst_customer.itemLocationcode = '"+Code+"'  "      ).uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteCustomerDestination (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_customer_destination ON mst_customer_destination.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "        
//            + "mst_customer_destination.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteDriver (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_driver ON mst_driver.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "            
//            + "mst_driver.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteBranch (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_branch ON mst_branch.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "    
//            + "mst_branch.itemLocationcode = '"+Code+"' ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteExpedition (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_expedition ON mst_expedition.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "          
//            + "mst_expedition.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteFeeReceiver (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_fee_receiver ON mst_fee_receiver.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "       
//            + "mst_fee_receiver.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteGoodsInvoiceDestination (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_goods_invoice_destination ON mst_goods_invoice_destination.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "       
//            + "mst_goods_invoice_destination.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteHoldingCompany (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_holding_company ON mst_holding_company.itemLocationcode = mst_item_jn_current_stock.code  "
//            + "WHERE "      
//            + "mst_holding_company.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteSupplier (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_supplier ON mst_supplier.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "   
//            + "mst_supplier.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteSalesman (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_item_jn_current_stock.code)  "
//            + "FROM mst_item_jn_current_stock  "
//            + "INNER JOIN mst_salesman ON mst_salesman.itemLocationcode = mst_item_jn_current_stock.code  " 
//            + "WHERE "       
//            + "mst_salesman.itemLocationcode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//    }
    
//    public List<IvtActualStock> findDataByPickingListSOItem(List<InventoryActualStockTemp> lstInventoryActualStockTemp) throws Exception {
//        try {
//            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
//            List<IvtActualStock> listInventoryActualStock = inventoryInOutDAO.findDataByPickingListSOItem(lstInventoryActualStockTemp);
//                        
//            return listInventoryActualStock;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
//    public List<IvtActualStock> findDataByPickingListBOItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
//            List<IvtActualStock> listInventoryActualStock = inventoryInOutDAO.findDataByPickingListBOItem(lstInventoryActualStock);
//                        
//            return listInventoryActualStock;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
     public List<IvtActualStock> findDataByAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
        try {
            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
            List<IvtActualStock> listInventoryActualStock = inventoryInOutDAO.findDataByAssemblyRealization(lstInventoryActualStock);
                        
            return listInventoryActualStock;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public List<IvtActualStock> findDataByPickingListWHMItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
//            List<IvtActualStock> listInventoryActualStock = inventoryInOutDAO.findDataByPickingListWHMItem(lstInventoryActualStock);
//                        
//            return listInventoryActualStock;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
//    public List<IvtActualStock> findDataByPromoOutItem(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try {
//            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
//            List<IvtActualStock> listInventoryActualStock = inventoryInOutDAO.findDataByPromoOutItem(lstInventoryActualStock);
//                        
//            return listInventoryActualStock;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    public int countDataByPLTSOSPV(String ItemCode, String BranchCode, String WarehouseCode, String DocumentNo,
            String LotNo, String BatchNo, String RackCode, String RackName){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_master_item_current_stock_for_plt_so_spv_list_count(:prmItemCode, :prmBranchCode, "
                    + ":prmWarehouseCode, :prmDocumentNo, :prmLotNo, :prmBatchNo, :prmRackCode, :prmRackName)")
                    .setParameter("prmItemCode", ItemCode)
                    .setParameter("prmBranchCode", BranchCode)
                    .setParameter("prmWarehouseCode", WarehouseCode)
                    .setParameter("prmDocumentNo", DocumentNo)
                    .setParameter("prmLotNo", "%" + LotNo + "%")
                    .setParameter("prmBatchNo", "%" + BatchNo + "%")
                    .setParameter("prmRackCode", "%" + RackCode + "%")
                    .setParameter("prmRackName", "%" + RackName + "%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemCurrentStockTemp> findDataByPLTSOSPV(String ItemCode, String BranchCode, String WarehouseCode, String DocumentNo,
            String LotNo, String BatchNo, String RackCode, String RackName,int from, int row) {
        try { 
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_master_item_current_stock_for_plt_so_spv_list(:prmItemCode, :prmBranchCode, "
                    + ":prmWarehouseCode, :prmDocumentNo, :prmLotNo, :prmBatchNo, :prmRackCode, :prmRackName, "
                    + ":prmLimitFrom, :prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("uomCode", Hibernate.STRING)
                    .addScalar("uomName", Hibernate.STRING)
                    .addScalar("cogs", Hibernate.BIG_DECIMAL)
                    .addScalar("itemBrandCode", Hibernate.STRING)
                    .addScalar("itemBrandName", Hibernate.STRING)
                    .addScalar("lotNo", Hibernate.STRING)
                    .addScalar("batchNo", Hibernate.STRING)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("itemDate", Hibernate.TIMESTAMP)
                    .addScalar("expiredDate", Hibernate.TIMESTAMP)
                    .addScalar("productionDate", Hibernate.TIMESTAMP)
                    .addScalar("inDocumentType", Hibernate.STRING)
                    .addScalar("inTransactionNo", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("warehouseName", Hibernate.STRING)
                    .addScalar("inventoryType", Hibernate.STRING)
                    .setParameter("prmItemCode", ItemCode)
                    .setParameter("prmBranchCode", BranchCode)
                    .setParameter("prmWarehouseCode", WarehouseCode)
                    .setParameter("prmDocumentNo", DocumentNo)
                    .setParameter("prmLotNo", "%" + LotNo + "%")
                    .setParameter("prmBatchNo", "%" + BatchNo + "%")
                    .setParameter("prmRackCode", "%" + RackCode + "%")
                    .setParameter("prmRackName", "%" + RackName + "%")
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", row)
                    .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemCurrentStockTemp findDataValidForPLTSOSPV(ItemCurrentStockTemp itemCurrentStockTemp) {
        try { 
            ItemCurrentStockTemp dat = (ItemCurrentStockTemp) hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_master_item_current_stock_validity_for_plt_so_spv_list(:prmItemCode, :prmCogs, :prmItemBrandCode, "
                    + ":prmLotNo, :prmBatchNo, :prmRackCode, :prmItemDate, :prmExpiredDate, :prmInDocumentType, :prmInTransactionNo, "
                    + ":prmWarehouseCode, :prmBranchCode, :prmDocumentNo)")
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("cogs", Hibernate.BIG_DECIMAL)
                    .addScalar("itemBrandCode", Hibernate.STRING)
                    .addScalar("lotNo", Hibernate.STRING)
                    .addScalar("batchNo", Hibernate.STRING)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("itemDate", Hibernate.TIMESTAMP)
                    .addScalar("expiredDate", Hibernate.TIMESTAMP)
                    .addScalar("inDocumentType", Hibernate.STRING)
                    .addScalar("inTransactionNo", Hibernate.STRING)
                    .setParameter("prmItemCode", itemCurrentStockTemp.getItemMaterialCode())
//                    .setParameter("prmCogs", itemCurrentStockTemp.getCogs())
//                    .setParameter("prmItemBrandCode", itemCurrentStockTemp.getItemBrandCode())
//                    .setParameter("prmLotNo", itemCurrentStockTemp.getLotNo())
//                    .setParameter("prmBatchNo", itemCurrentStockTemp.getBatchNo())
//                    .setParameter("prmRackCode", itemCurrentStockTemp.getRackCode())
//                    .setParameter("prmItemDate", itemCurrentStockTemp.getItemDate())
//                    .setParameter("prmExpiredDate", itemCurrentStockTemp.getExpiredDate())
//                    .setParameter("prmInDocumentType", itemCurrentStockTemp.getInDocumentType())
//                    .setParameter("prmInTransactionNo", itemCurrentStockTemp.getInTransactionNo())
                    .setParameter("prmWarehouseCode", itemCurrentStockTemp.getWarehouseCode())
//                    .setParameter("prmBranchCode", itemCurrentStockTemp.getBranchCode())
//                    .setParameter("prmDocumentNo", itemCurrentStockTemp.getDocumentNo())
                    .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                    .uniqueResult(); 
            return dat;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}