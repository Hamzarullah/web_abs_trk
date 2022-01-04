
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.ItemMaterialField;
import com.inkombizz.master.model.ItemMaterialTemp;
import com.inkombizz.master.model.ItemMaterialVendor;
import com.inkombizz.master.model.ItemMaterialVendorField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class ItemMaterialDAO {
    
    private HBMSession hbmSession;
    
    public ItemMaterialDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(ItemMaterial itemMaterial){   
        try{
            String acronim = "ITMMTR";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemMaterial.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public int countData(String code,String name,String inventoryType,String active){
        try{
                        
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item_material_material.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item_material.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "COUNT(*) "
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + concat_qry_type
                + concat_qry_active
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countData(String code,String name,String warehouseCode){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT COUNT(*) FROM "
                + "FROM mst_item_material "
                + "WHERE 1=1 "
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
           
    public List <ItemMaterial> findByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }   
    
    public ItemMaterialTemp findData(String code) {
        try {  
            ItemMaterialTemp itemMaterialTemp = (ItemMaterialTemp)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.tolerance, "
//                + "mst_item_material.conversionStatus, "
//                + "mst_item_material.serialNoStatus, "
//                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.cogsIDR, "
//                + "mst_item_material.Remark, "
                + "mst_item_material.activeStatus, "
                + "mst_item_material.InActiveBy, "
                + "mst_item_material.InActiveDate, "
                + "mst_item_material.createdBy, "
                + "mst_item_material.createdDate "
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "
                + "WHERE mst_item_material.code ='"+code+"' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
//                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
//                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
//                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
//                .addScalar("conversionStatus", Hibernate.BOOLEAN)
//                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
//                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)
//                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .uniqueResult(); 
                 
                return itemMaterialTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataSearch(String code, String name,String active) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_material.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT  COUNT(*)"
                + "FROM "
                + "mst_item_material "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemMaterialTemp> search(String code, String name,String active, int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_material.ActiveStatus="+active+" ";
            }
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "mst_item_material.Code, "
                + "mst_item_material.Name, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_material.ItemBrandCode, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.Tolerance, "
//                + "CASE "
//                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
//                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
//                + "END AS serialNoStatusInOut, "
//                + "mst_item_material.ConversionStatus, "
//                + "mst_item_material.Conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.COGSIDR AS cogsIDR, "
                + "mst_item_material.ActiveStatus, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, "
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock "
                + "FROM "
                + "mst_item_material "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+""    
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
//                .addScalar("serialNoStatusInOut", Hibernate.STRING)
                .addScalar("onHandStock", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataSearchBooked(String code, String name, String wareHouseCode) {
        try {   
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT  COUNT(*)"
                + "FROM "
                + "mst_item_material "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "INNER JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode "
                + "INNER JOIN mst_warehouse ON mst_warehouse.Code = mst_item_material_jn_current_stock.WarehouseCode "
                + "LEFT JOIN ppic_item_material_request_item_booking_detail ON ppic_item_material_request_item_booking_detail.ItemMaterialCode = mst_item_material.Code "            
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_warehouse.code LIKE '%"+wareHouseCode+"%' "
            ).uniqueResult();
            return temp.intValue();
        }
        catch (HibernateException e) {  
            throw e;
        }
    }
    
    public List<ItemMaterialTemp> findDataSearchBooked(String code, String name, String wareHouseCode, int from, int row) {
        try {   
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "mst_item_material.Code, "
                + "mst_item_material.Name, "
                + "mst_item_material.unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_material_jn_current_stock.WarehouseCode, "
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock,"
                + "ppic_item_material_request_item_booking_detail.BookingQuantity "
                + "FROM mst_item_material "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "INNER JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode "
                + "INNER JOIN mst_warehouse ON mst_warehouse.Code = mst_item_material_jn_current_stock.WarehouseCode "
                + "LEFT JOIN ppic_item_material_request_item_booking_detail ON ppic_item_material_request_item_booking_detail.ItemMaterialCode = mst_item_material.Code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_warehouse.code LIKE '%"+wareHouseCode+"%' "        
                + "LIMIT "+from+","+row+""    
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("onHandStock", Hibernate.BIG_DECIMAL)
                .addScalar("bookingQuantity", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public ItemMaterialTemp findData(String code,boolean active,String inventoryType) {
        try {
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item_material.Inventorytype="+inventoryType+" ";
            }
            
            ItemMaterialTemp itemMaterialTemp = (ItemMaterialTemp)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.tolerance, "
//                + "mst_item_material.conversionStatus, "
//                + "mst_item_material.serialNoStatus, "
//                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.cogsIDR, "
                + "mst_item_material.Remark, "
                + "mst_item_material.activeStatus, "
                + "mst_item_material.InActiveBy, "
                + "mst_item_material.InActiveDate, "
                + "mst_item_material.createdBy, "
                + "mst_item_material.createdDate "
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "
                + "WHERE mst_item_material.code ='"+code+"' "
                + "AND mst_item_material.ActiveStatus ="+active+" "
                + concat_qry_type)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
//                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
//                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
//                .addScalar("conversionStatus", Hibernate.BOOLEAN)
//                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
//                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
//                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .uniqueResult(); 
                 
                return itemMaterialTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemMaterialTemp findData(String code,String warehouseCode) {
        try {
                        
            ItemMaterialTemp itemMaterialTemp = (ItemMaterialTemp)hbmSession.hSession.createSQLQuery(
                   "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.tolerance, "
//                + "mst_item_material.conversionStatus, "
//                + "mst_item_material.serialNoStatus, "
//                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.cogsIDR, "
                + "mst_item_material.Remark, "
                + "mst_item_material.activeStatus, "
                + "mst_item_material.InActiveBy, "
                + "mst_item_material.InActiveDate, "
                + "mst_item_material.createdBy, "
                + "mst_item_material.createdDate "
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "
            )                
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
//                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
//                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
//                .addScalar("conversionStatus", Hibernate.BOOLEAN)
//                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
//                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
//                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .uniqueResult(); 
                 
                return itemMaterialTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemMaterialTemp> findData(String code, String name,String inventoryType,String active,int from, int row) {
        try {   
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item_material.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item_material.ActiveStatus="+active+" ";
            }
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(
                     "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.tolerance, "
//                + "mst_item_material.conversionStatus, "
//                + "mst_item_material.serialNoStatus, "
//                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.cogsIDR, "                             
                + "SUM(mst_item_material_jn_current_stock.actualstock) AS OnHandStock, "             
                + "mst_item_material.Remark, " 
                + "mst_item_material.activeStatus, " 
                + "mst_item_material.InActiveBy, " 
                + "mst_item_material.InActiveDate, " 
                + "mst_item_material.createdBy, " 
                + "mst_item_material.createdDate " 
                + "FROM mst_item_material " 
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "           
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material_jn_current_stock.ItemMaterialCode = mst_item_material.Code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + concat_qry_type
                + concat_qry_active
                + "GROUP BY mst_item_material.code "
                + "ORDER BY mst_item_material.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
//                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
//                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
//                .addScalar("conversionStatus", Hibernate.BOOLEAN)
//                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
//                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
//                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)    
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ItemMaterialTemp> findDataSo(String code, String name,String inventoryType,String active,int from, int row) {
        try {   
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item_material.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item_material.ActiveStatus="+active+" ";
            }
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "uom1.Code AS UnitOfMeasureCode, "
                + "uom1.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
                + "mst_item_material.PartConversion, "
                + "mst_item_material.tolerance, "
                + "mst_item_material.conversionStatus, "
                + "mst_item_material.serialNoStatus, "
                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
                + "mst_item.cogsIDR, "                             
                + "SUM(mst_item_material_jn_current_stock.actualstock) AS OnHandStock, "             
                + "mst_item_material.Remark, " 
                + "mst_item_material.activeStatus, " 
                + "mst_item_material.InActiveBy, " 
                + "mst_item_material.InActiveDate, " 
                + "mst_item_material.createdBy, " 
                + "mst_item_material.createdDate " 
                + "FROM mst_item_material " 
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure uom1 ON mst_item_material.unitOfMeasureCode = uom1.code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "            
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material_jn_current_stock.ItemMaterialCode = mst_item_material.Code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + "AND mst_item_material.`InventoryCategory` = 'FINISH_GOODS' "
                + concat_qry_type
                + concat_qry_active
                + "GROUP BY mst_item_material.code "
                + "ORDER BY mst_item_material.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
                .addScalar("conversionStatus", Hibernate.BOOLEAN)
                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)    
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemMaterialTemp> findData(String code, String name,String warehouseCode,int from, int row) {
        try {   
            
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(
                     "SELECT "
                + "mst_item_material.Code, "
                + "mst_item_material.name, "
                + "mst_item_sub_category.Code AS itemSubCategoryCode, "
                + "mst_item_sub_category.Name AS itemSubCategoryName, "
                + "mst_item_category.Code AS itemCategoryCode, "
                + "mst_item_category.Name AS itemCategoryName, "           
                + "mst_item_division.Code AS ItemDivisionCode, "
                + "mst_item_division.Name AS ItemDivisionName, "
                + "uom1.Code AS UnitOfMeasureCode, "
                + "uom1.Name AS UnitOfMeasureName, "
                + "mst_item_brand.Code AS itemBrandCode, "
                + "mst_item_brand.Name AS itemBrandName, "
//                + "mst_item_material.PartConversion, "
//                + "mst_item_material.tolerance, "
//                + "mst_item_material.conversionStatus, "
//                + "mst_item_material.serialNoStatus, "
//                + "mst_item_material.conversion, "
                + "mst_item_material.InventoryType, "
                + "mst_item_material.MinStock, "
                + "mst_item_material.MaxStock, "
//                + "mst_item_material.cogsIDR, "
                + "mst_item_material.Remark, "
                + "mst_item_material.activeStatus, "
                + "mst_item_material.InActiveBy, "
                + "mst_item_material.InActiveDate, "
                + "mst_item_material.createdBy, "
                + "mst_item_material.createdDate "                
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_sub_category.Code =  mst_item_material.itemSubCategoryCode " 
                + "INNER JOIN mst_item_category ON mst_item_category.Code = mst_item_sub_category.ItemCategoryCode " 
                + "INNER JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_item_brand ON mst_item_material.ItemBrandCode=mst_item_brand.Code "
                + "WHERE mst_item_material.Name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
//                .addScalar("partConversion", Hibernate.BIG_DECIMAL)
//                .addScalar("tolerance", Hibernate.BIG_DECIMAL)
//                .addScalar("conversionStatus", Hibernate.BOOLEAN)
//                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
//                .addScalar("conversion", Hibernate.BIG_DECIMAL)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
//                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL) 
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataItemMaterialVendor(String code, String vendorCode){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "COUNT(*) "
                + "FROM mst_item_material_jn_vendor "
                + "INNER JOIN mst_item_material ON mst_item_material.code = mst_item_material_jn_vendor.itemMaterialCode " 
                + "INNER JOIN mst_vendor ON mst_vendor.code = mst_item_material_jn_vendor.vendorCode " 
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_item_material.unitOfMeasureCode "          
                + "WHERE mst_item_material_jn_vendor.code LIKE '%"+code+"%' "
                + "AND mst_vendor.code = '"+vendorCode+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialVendor> findDataDetailMaterialVendor(String code,String vendorCode,int from, int row) {
        try {
            List<ItemMaterialVendor> list = (List<ItemMaterialVendor>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                + "mst_item_material_jn_vendor.code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_item_material.unitOfMeasureCode AS itemMaterialUnitOfMeasureCode, "
                + "mst_unit_of_measure.name AS itemMaterialUnitOfMeasureName, "
                + "mst_vendor.code AS vendorCode, "
                + "mst_vendor.name AS vendorName, "
                + "mst_vendor.address AS vendorAddress "
                + "FROM mst_item_material_jn_vendor "
                + "INNER JOIN mst_item_material ON mst_item_material.code = mst_item_material_jn_vendor.itemMaterialCode "
                + "INNER JOIN mst_vendor ON mst_vendor.code = mst_item_material_jn_vendor.vendorCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_item_material.unitOfMeasureCode "
                + "WHERE mst_item_material_jn_vendor.code LIKE '%"+code+"%' "
                + "AND mst_vendor.code = '"+vendorCode+"' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("vendorAddress", Hibernate.STRING)
                
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialVendor.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataCheckSN(String code,String name,String active,String checkSerialNoStatus){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_material.ActiveStatus="+active+" ";
            }
            
            String concat_qry_sn="";
            if(!checkSerialNoStatus.equals("")){
                concat_qry_sn="AND mst_item_material.SerialNoStatus="+checkSerialNoStatus+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_material "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' "
                + concat_qry
                + concat_qry_sn
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialTemp> findDataCheckSN(String code, String name,String active, String checkSerialNoStatus,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_material.ActiveStatus="+active+" ";
            }
            
            String concat_qry_sn="";
            if(!checkSerialNoStatus.equals("")){
                concat_qry_sn="AND mst_item_material.SerialNoStatus="+checkSerialNoStatus+" ";
            }
            List<ItemMaterialTemp> list = (List<ItemMaterialTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +"mst_item_material.code, "
                +"mst_item_material.name, "
                +"mst_item_material.conversionStatus, "
                +"mst_item_material.serialNoStatus, "
                + "CASE "
                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
                + "END AS serialNoStatusInOut, "
                +"mst_item_sub_category.code AS itemSubCategoryCode, "
                +"mst_item_sub_category.name AS itemSubCategoryName, "
                +"mst_item_category.code AS itemCategoryCode, "
                +"mst_item_category.name AS itemCategoryName, "
                +"mst_item_division.code AS itemDivisionCode, "
                +"mst_item_division.name AS itemDivisionName, "
                +"uom1.code AS unitOfMeasureCode, "
                +"uom1.name AS unitOfMeasureName, "
                +"mst_item_material.inventoryType, "
                +"IFNULL(podetail.`Quantity`, 0) AS podQuantity, "
                +"IFNULL(grndetail.`Quantity`, 0) AS receivedQuantity, "
                +"mst_item_material.activeStatus, "
                +"mst_item_material.createdBy, "
                +"mst_item_material.createdDate, "
                +"mst_item_material.updatedBy, "
                +"mst_item_material.updatedDate, "
                +"mst_item_material.inActiveBy, "
                +"mst_item_material.inActiveDate, "
                +"mst_item_material.remark "
                + "FROM mst_item_material "
                + "INNER JOIN mst_item_sub_category ON mst_item_material.itemSubCategoryCode=mst_item_sub_category.Code "
                + "INNER JOIN mst_item_category ON mst_item_sub_category.itemCategoryCode=mst_item_category.Code "
                + "INNER JOIN mst_item_division ON mst_item_category.itemDivisionCode=mst_item_division.Code "
                + "INNER JOIN mst_unit_of_measure uom1 ON mst_item_material.unitOfMeasureCode=uom1.Code "
                + "LEFT JOIN pur_purchase_order_detail podetail ON mst_item_material.Code=podetail.ItemMaterialCode "
                + "LEFT JOIN ivt_goods_received_note_item_detail grndetail  ON mst_item_material.Code=grndetail.Code "
                + "WHERE mst_item_material.code LIKE '%"+code+"%' "
                + "AND mst_item_material.name LIKE '%"+name+"%' " 
                + concat_qry
                + concat_qry_sn
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("conversionStatus", Hibernate.BOOLEAN)
                .addScalar("serialNoStatus", Hibernate.BOOLEAN)
                .addScalar("serialNoStatusInOut", Hibernate.STRING)
                .addScalar("itemSubCategoryCode", Hibernate.STRING)
                .addScalar("itemSubCategoryName", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("podQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("receivedQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemMaterialVendor> findDataDetailExisting(String code) {
        try {
            List<ItemMaterialVendor> list = (List<ItemMaterialVendor>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                + "mst_item_material_jn_vendor.code, "
                + "mst_item_material.code AS itemMaterialCode, "
                + "mst_item_material.name AS itemMaterialName, "
                + "mst_vendor.code AS vendorCode, "
                + "mst_vendor.name AS vendorName, "
                + "mst_vendor.address AS vendorAddress "
                + "FROM mst_item_material_jn_vendor "
                + "INNER JOIN mst_item_material ON mst_item_material.code = mst_item_material_jn_vendor.itemMaterialCode "
                + "INNER JOIN mst_vendor ON mst_vendor.code = mst_item_material_jn_vendor.vendorCode "
                + "WHERE mst_item_material_jn_vendor.code LIKE '%"+code+"%' "
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("vendorAddress", Hibernate.STRING)
                
                .setResultTransformer(Transformers.aliasToBean(ItemMaterialVendor.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemMaterial itemMaterial, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemMaterial.setCode(createCode(itemMaterial));
            String headerCode=createCode(itemMaterial);
            
            itemMaterial.setCode(headerCode);
            itemMaterial.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemMaterial.setCreatedDate(new Date()); 
                        
            hbmSession.hSession.save(itemMaterial);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemMaterial.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void vendorSave(List<ItemMaterialVendor> listItemMaterialVendorDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            String code = "";
            
            int n = 1;
            for (ItemMaterialVendor itemMaterialVendorDetail : listItemMaterialVendorDetail) {
                String detailCode = itemMaterialVendorDetail.getItemMaterial().getCode()+"/"+ itemMaterialVendorDetail.getVendor().getCode();
                
                 if(isExist(detailCode)){
               
                }else{
                    itemMaterialVendorDetail.setCode(detailCode);
                    hbmSession.hSession.save(itemMaterialVendorDetail);
                    hbmSession.hSession.flush();
                }
                
                n++;

            }
                    
//            for (ItemMaterialVendor itemMaterialVendorDetail : listItemMaterialVendorDetail) {
//                String detailCode = itemMaterialVendorDetail.getItemMaterial().getCode()+"/"+ itemMaterialVendorDetail.getVendor().getCode();
////                itemMaterialVendorDetail.setCode(detailCode);
//                code = itemMaterialVendorDetail.getItemMaterial().getCode();
////                hbmSession.hSession.save(itemMaterialVendorDetail);
////                hbmSession.hSession.flush();
////                n++;
//                
////                hbmSession.hSession.createQuery("INSERT INTO "  + ItemMaterialVendorField.BEAN_NAME 
////                        + " (code, itemMaterialCode, vendorCode)"
////                        + " select prm1, prm2, prm3"
////                        + " WHERE " + ItemMaterialVendorField.CODE + " != :prmCode"
////                        + "WHERE NOT EXISTS ( "
////                        + "SELECT code FROM "+ ItemMaterialVendorField.BEAN_NAME + " WHERE code = :prmConcatCode) ")
////
////                .setParameter("prmCode", itemMaterialVendorDetail.getItemMaterial().getCode())
////                .setParameter("prmConcatCode", itemMaterialVendorDetail.getItemMaterial().getCode() + "" + itemMaterialVendorDetail.getVendor().getCode())
////                .setParameter("prm1", itemMaterialVendorDetail.getItemMaterial().getCode()+"/"+ itemMaterialVendorDetail.getVendor().getCode())
////                .setParameter("prm2", itemMaterialVendorDetail.getItemMaterial().getCode())
////                .setParameter("prm3", itemMaterialVendorDetail.getVendor().getCode())
////                .executeUpdate();
//                hbmSession.hSession.flush();
//            }
            
           
            
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
     
     public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterialVendor.class)
                            .add(Restrictions.eq(ItemMaterialVendorField.CODE, code));
            
              if(countByCriteria(criteria) > 0)
                 exist = true;
             
            return exist;

        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void update(ItemMaterial itemMaterial, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
//            itemMaterial.setCode(createCode(itemMaterial));
            itemMaterial.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemMaterial.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemMaterial);
            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
//                                                                    itemMaterial.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemMaterialField.BEAN_NAME + " WHERE " + ItemMaterialField.CODE + " = :prmCode")
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
    
    public ItemMaterialTemp getMin() {
        try {
            
            String qry = "SELECT mst_item_material.code,mst_item_material.Name FROM mst_item_material ORDER BY mst_item_material.code LIMIT 0,1";
            ItemMaterialTemp itemMaterialTemp =(ItemMaterialTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                    .uniqueResult();   
            
            return itemMaterialTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemMaterialTemp getMax() {
        try {
            
            String qry = "SELECT mst_item_material.code,mst_item_material.Name FROM mst_item_material ORDER BY mst_item_material.code DESC LIMIT 0,1";
            ItemMaterialTemp itemMaterialTemp =(ItemMaterialTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemMaterialTemp.class))
                    .uniqueResult();   
            
            return itemMaterialTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }    

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
}