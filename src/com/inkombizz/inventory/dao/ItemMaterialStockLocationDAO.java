/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemSerialNoDetail;
import com.inkombizz.inventory.model.ItemMaterialStockLocation;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class ItemMaterialStockLocationDAO {
    
    private HBMSession hbmSession;
    
    public ItemMaterialStockLocationDAO (HBMSession session) {
        this.hbmSession = session;
    } 
    
    public int countData(ItemMaterialStockLocation itemMaterialStockLocation){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	COUNT(item_stock_location.SerialNo) " +
                "FROM( " +
                "	SELECT " +
                "		ivt_item_material_stock_location.SerialNo " +
                "	FROM ivt_item_material_stock_location " +
                "       INNER JOIN `mst_item_material` ON ivt_item_material_stock_location.`ItemMaterialCode`=mst_item_material.`Code` " +
                "       INNER JOIN `mst_warehouse`ON ivt_item_material_stock_location.`WarehouseCode`=mst_warehouse.`Code` " +
                "       INNER JOIN `mst_rack` ON ivt_item_material_stock_location.`RackCode`=mst_rack.`Code` " +
                "	WHERE ivt_item_material_stock_location.SerialNo LIKE '%"+itemMaterialStockLocation.getSerialNo()+"%' " +
                "		AND ivt_item_material_stock_location.ItemMaterialCode LIKE '%"+itemMaterialStockLocation.getItemMaterial()+"%' " +
                "		AND ivt_item_material_stock_location.WarehouseCode LIKE '%"+itemMaterialStockLocation.getWarehouse().getCode()+"%' " +
                "		AND ivt_item_material_stock_location.RackCode LIKE '%"+itemMaterialStockLocation.getRack().getCode()+"%' " +
                "	GROUP BY ivt_item_material_stock_location.SerialNo " +
                ")AS item_stock_location"
            ).uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialStockLocation> findData(ItemMaterialStockLocation itemMaterialStockLocation,int from,int to) {
        try {
            
            List<ItemMaterialStockLocation> list = (List<ItemMaterialStockLocation>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	ivt_item_material_stock_location.`ItemMaterialCode`, " +
                "       mst_item_material.`Name` AS ItemMaterialName, " +
                "	ivt_item_material_stock_location.`WarehouseCode`, " +
                "       mst_warehouse.`Name` AS WarehouseName, " +
                "	ivt_item_material_stock_location.`RackCode`, " +
                "       mst_rack.`Name` AS RackName, " +
                "	ivt_item_material_stock_location.`SerialNo`, " +
                "	SUM(ivt_item_material_stock_location.`Capacity`)AS Capacity " +
                "FROM `ivt_item_material_stock_location` " +
                "INNER JOIN `mst_item_material` ON ivt_item_material_stock_location.`ItemMaterialCode`=mst_item_material.`Code` " +
                "INNER JOIN `mst_warehouse`ON ivt_item_material_stock_location.`WarehouseCode`=mst_warehouse.`Code` " +
                "INNER JOIN `mst_rack` ON ivt_item_material_stock_location.`RackCode`=mst_rack.`Code` " +
                "WHERE ivt_item_material_stock_location.SerialNo LIKE '%"+itemMaterialStockLocation.getSerialNo()+"%' " +
                "   AND ivt_item_material_stock_location.ItemMaterialCode LIKE '%"+itemMaterialStockLocation.getItemMaterial()+"%' " +
                "   AND ivt_item_material_stock_location.WarehouseCode LIKE '%"+itemMaterialStockLocation.getWarehouse().getCode()+"%' " +
                "   AND ivt_item_material_stock_location.RackCode LIKE '%"+itemMaterialStockLocation.getRack().getCode()+"%' " +
                "GROUP BY ivt_item_material_stock_location.`SerialNo` " +
                "ORDER BY ivt_item_material_stock_location.`ItemMaterialCode` ASC,ivt_item_material_stock_location.`SerialNo` ASC " +
                "LIMIT "+from+","+to+"")
                
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("capacity", Hibernate.BIG_DECIMAL)
                
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialStockLocation.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countSearchData(ItemMaterialStockLocation itemMaterialStockLocation){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	COUNT(item_stock_location.Code) " +
                "FROM( " +
                "	SELECT " +
                "		ivt_item_material_stock_location.Code, " +
                "		ivt_item_material_stock_location.TransactionCode, " +
                "		ivt_item_material_stock_location.ItemMaterialCode, " +
                "		ivt_item_material_stock_location.WarehouseCode, " +
                "		ivt_item_material_stock_location.RackCode, " +
                "		ivt_item_material_stock_location.SerialNo, " +
                "		ivt_item_material_stock_location.Capacity  " +
                "	FROM ivt_item_material_stock_location " +
                "	WHERE ivt_item_material_stock_location.SerialNo LIKE '%"+itemMaterialStockLocation.getSerialNo()+"%'     " +
                "		AND ivt_item_material_stock_location.ItemMaterialCode LIKE '%"+itemMaterialStockLocation.getItemMaterialCode()+"%' " +
                "		AND ivt_item_material_stock_location.WarehouseCode='"+itemMaterialStockLocation.getWarehouseCode()+"' " +
                "		AND ivt_item_material_stock_location.RackCode='"+itemMaterialStockLocation.getRackCode()+"'  " +
                "		AND ivt_item_material_stock_location.Capacity>0 " +
                "	GROUP BY ivt_item_material_stock_location.SerialNo " +
                ")AS item_stock_location " +
                "INNER JOIN mst_item_material ON item_stock_location.ItemMaterialCode=mst_item_material.Code  " +
                "INNER JOIN mst_warehouse ON item_stock_location.WarehouseCode=mst_warehouse.Code  " +
                "INNER JOIN mst_rack ON item_stock_location.RackCode=mst_rack.Code  " +
                "LEFT JOIN( " +
                "	SELECT " +
                "		ivt_item_material_stock_location.Code, " +
                "		ivt_item_material_stock_location.ItemMaterialCode, " +
                "		ivt_item_material_stock_location.WarehouseCode, " +
                "		ivt_item_material_stock_location.RackCode, " +
                "		ivt_item_material_stock_location.SerialNo, " +
                "		ABS(SUM(ivt_item_material_stock_location.Capacity)) AS Capacity " +
                "	FROM ivt_item_material_stock_location " +
                "	WHERE ivt_item_material_stock_location.WarehouseCode='"+itemMaterialStockLocation.getWarehouseCode()+"' " +
                "	AND ivt_item_material_stock_location.RackCode='"+itemMaterialStockLocation.getRackCode()+"'  " +
                "	AND ivt_item_material_stock_location.Capacity<0 " +
                "	GROUP BY ivt_item_material_stock_location.SerialNo " +
                ")AS item_stock_location_used ON item_stock_location.SerialNo=item_stock_location_used.SerialNo " +
                "WHERE mst_item_material.Name LIKE '%"+itemMaterialStockLocation.getItemMaterialName()+"%'"
            ).uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialStockLocation> findSearchData(ItemMaterialStockLocation itemMaterialStockLocation,int from,int to) {
        try {
            
            List<ItemMaterialStockLocation> list = (List<ItemMaterialStockLocation>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	item_stock_location.Code, " +
                "	item_stock_location.TransactionCode, " +
                "	item_stock_location.ItemMaterialCode, " +
                "	mst_item_material.Name AS ItemMaterialName, " +
                "	item_stock_location.WarehouseCode, " +
                "	mst_warehouse.Name AS WarehouseName, " +
                "	item_stock_location.RackCode, " +
                "	mst_rack.Name AS RackName, " +
                "	item_stock_location.SerialNo, " +
                "	item_stock_location.Capacity, " +
                "	IFNULL(item_stock_location_used.Capacity,0)AS UsedCapacity, " +
                "	item_stock_location.Capacity - IFNULL(item_stock_location_used.Capacity,0) AS BalanceCapacity " +
                "FROM( " +
                "	SELECT " +
                "		ivt_item_material_stock_location.Code, " +
                "		ivt_item_material_stock_location.TransactionCode, " +
                "		ivt_item_material_stock_location.ItemMaterialCode, " +
                "		ivt_item_material_stock_location.WarehouseCode, " +
                "		ivt_item_material_stock_location.RackCode, " +
                "		ivt_item_material_stock_location.SerialNo, " +
                "		ivt_item_material_stock_location.Capacity  " +
                "	FROM ivt_item_material_stock_location " +
                "	WHERE ivt_item_material_stock_location.SerialNo LIKE '%"+itemMaterialStockLocation.getSerialNo()+"%'     " +
                "		AND ivt_item_material_stock_location.ItemMaterialCode LIKE '%"+itemMaterialStockLocation.getItemMaterialCode()+"%' " +
                "		AND ivt_item_material_stock_location.WarehouseCode='"+itemMaterialStockLocation.getWarehouseCode()+"' " +
                "		AND ivt_item_material_stock_location.RackCode='"+itemMaterialStockLocation.getRackCode()+"'  " +
                "		AND ivt_item_material_stock_location.Capacity>0 " +
                "	GROUP BY ivt_item_material_stock_location.SerialNo " +
                ")AS item_stock_location " +
                "INNER JOIN mst_item_material ON item_stock_location.ItemMaterialCode=mst_item_material.Code  " +
                "INNER JOIN mst_warehouse ON item_stock_location.WarehouseCode=mst_warehouse.Code  " +
                "INNER JOIN mst_rack ON item_stock_location.RackCode=mst_rack.Code  " +
                "LEFT JOIN( " +
                "	SELECT " +
                "		ivt_item_material_stock_location.Code, " +
                "		ivt_item_material_stock_location.ItemMaterialCode, " +
                "		ivt_item_material_stock_location.WarehouseCode, " +
                "		ivt_item_material_stock_location.RackCode, " +
                "		ivt_item_material_stock_location.SerialNo, " +
                "		ABS(SUM(ivt_item_material_stock_location.Capacity)) AS Capacity " +
                "	FROM ivt_item_material_stock_location " +
                "	WHERE ivt_item_material_stock_location.WarehouseCode='"+itemMaterialStockLocation.getWarehouseCode()+"' " +
                "	AND ivt_item_material_stock_location.RackCode='"+itemMaterialStockLocation.getRackCode()+"'  " +
                "	AND ivt_item_material_stock_location.Capacity<0 " +
                "	GROUP BY ivt_item_material_stock_location.SerialNo " +
                ")AS item_stock_location_used ON item_stock_location.SerialNo=item_stock_location_used.SerialNo " +
                "WHERE mst_item_material.Name LIKE '%"+itemMaterialStockLocation.getItemMaterialName()+"%' " +
                "ORDER BY item_stock_location.ItemMaterialCode ASC,item_stock_location.SerialNo ASC " +
                "LIMIT "+from+","+to+"")
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionCode", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("capacity", Hibernate.BIG_DECIMAL)
                .addScalar("usedCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("balanceCapacity", Hibernate.BIG_DECIMAL)
                
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialStockLocation.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String generateSerialNo(ItemMaterialStockLocation itemMaterialStockLocation){
        try{
            
            String acronim = itemMaterialStockLocation.getItemMaterial().getCode();

            DetachedCriteria dc = DetachedCriteria.forClass(ItemMaterialStockLocation.class)
                    .setProjection(Projections.max("serialNo"))
                    .add(Restrictions.like("serialNo", acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null)
                            oldID = list.get(0).toString();
                }
            return AutoNumber.generate_serial(acronim, oldID, AutoNumber.DEFAULT_STOCK_LENGTH);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public boolean save(ItemMaterialStockLocation itemMaterialStockLocation, String MODULECODE) throws Exception {
        try {
            String serialNo="";
            if(!itemMaterialStockLocation.isIsOut()){
               serialNo =generateSerialNo(itemMaterialStockLocation);
            }else{
                serialNo=itemMaterialStockLocation.getSerialNo();
            }
            
            
            itemMaterialStockLocation.setCustomerVendorCode(null);
            itemMaterialStockLocation.setCustomerVendorStatus("OTHER");
            itemMaterialStockLocation.setSerialNo(serialNo);
            itemMaterialStockLocation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemMaterialStockLocation.setCreatedDate(new Date());
            
            hbmSession.hSession.save(itemMaterialStockLocation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    itemMaterialStockLocation.getCode(), ""));            
            return Boolean.TRUE;
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
}
