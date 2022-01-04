
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemField;
import com.inkombizz.master.model.ItemTemp;
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


public class ItemDAO {
    
    private HBMSession hbmSession;
    
    public ItemDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String inventoryType,String inventoryCategory,String active, String packageStatus){
        try{
                        
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_category=" ";
            if(!inventoryCategory.equals("") && !inventoryCategory.equals("null")){
                concat_qry_category="AND mst_item.InventoryCategory='"+inventoryCategory+"' ";
            }
            
//            String concat_qry_package=" ";
//            if(!packageStatus.equals("")){
//                concat_qry_package="AND mst_item.PackageStatus="+packageStatus+"";
//            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "COUNT(*) "
                + "FROM mst_item "
//                + "INNER JOIN mst_item_product_category ON mst_item_product_category.Code = mst_item.ItemProductCategoryCode " 
                + "WHERE mst_item.code LIKE '%"+code+"%' "
                + "AND mst_item.name LIKE '%"+name+"%' "
                + concat_qry_type
                + concat_qry_active
                + concat_qry_category
//                + concat_qry_package
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
                + "FROM mst_item "
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
           
         
    public ItemTemp findData(String code) {
        try {  
            ItemTemp itemTemp = (ItemTemp)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_item.Code, "
                + "mst_item.name, "
                + "mst_item_product_category.Code AS itemProductCategoryCode, "
                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.InventoryCategory, "
                + "mst_item.MinStock, "
                + "mst_item.MaxStock, "
                + "mst_item.Size, "
                + "mst_item.StandardWeight, "
                + "mst_item.Remark, "
                + "mst_item.activeStatus, "
                + "mst_item.PackageStatus, "
                + "mst_item.InActiveBy, "
                + "mst_item.InActiveDate, "
                + "mst_item.createdBy, "
                + "mst_item.createdDate "
                + "FROM mst_item "
                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "WHERE mst_item.code ='"+code+"' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductCategoryCode", Hibernate.STRING)
                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
                .addScalar("size", Hibernate.STRING)
                .addScalar("standardWeight", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("packageStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .uniqueResult(); 
                 
                return itemTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public ItemTemp findData(String code,boolean active,String inventoryType,String inventoryCategory, boolean packageStatus) {
        try {
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item.Inventorytype="+inventoryType+" ";
            }
            
            String concat_qry_category=" ";
            if(!inventoryCategory.equals("") && !inventoryCategory.equals("null")){
                concat_qry_category="AND mst_item.InventoryCategory="+inventoryCategory+" ";
            }
           
            ItemTemp itemTemp = (ItemTemp)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_item.Code, "
                + "mst_item.name, "
                + "mst_item_product_category.Code AS itemProductCategoryCode, "
                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.InventoryCategory, "
                + "mst_item.MinStock, "
                + "mst_item.MaxStock,"
                + "mst_item.cogsIDR, "
                + "mst_item.Remark, "
                + "mst_item.activeStatus, "
                + "mst_item.PackageStatus, "
                + "mst_item.InActiveBy, "
                + "mst_item.InActiveDate, "
                + "mst_item.createdBy, "
                + "mst_item.createdDate "
                + "FROM mst_item "
                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "WHERE mst_item.code ='"+code+"' "
                + "AND mst_item.ActiveStatus ="+active+" "
                + concat_qry_type
                + concat_qry_category)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductCategoryCode", Hibernate.STRING)
                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("packageStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .uniqueResult(); 
                 
                return itemTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemTemp findData(String code,String warehouseCode) {
        try {
                        
            ItemTemp itemTemp = (ItemTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item.code, "
                + "mst_item.Name, "
                + "mst_item_product_category.Code AS itemProductCategoryCode, "
                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.InventoryCategory, "
                + "mst_item.cogsIDR, "
                + "mst_item.Remark, "
                + "mst_item.activeStatus, "
                + "mst_item.PackageStatus, "
                + "mst_item.InActiveBy, "
                + "mst_item.InActiveDate, "
                + "mst_item.createdBy, "
                + "mst_item.createdDate "                
                + "FROM mst_item "
                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
            )                
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductCategoryCode", Hibernate.STRING)
                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("packageStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .uniqueResult(); 
                 
                return itemTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemTemp> findData(String code, String name,String inventoryType,String inventoryCategory,String packageStatus,String active,int from, int row) {
        try {   
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_category=" ";
            if(!inventoryCategory.equals("") && !inventoryCategory.equals("null")){
                concat_qry_category="AND mst_item.InventoryCategory='"+inventoryCategory+"' ";
            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item.ActiveStatus="+active+" ";
            }
            
            String concat_qry_package=" ";
            if(!packageStatus.equals("")){
                concat_qry_package="AND mst_item.PackageStatus="+packageStatus+" ";
            }
            List<ItemTemp> list = (List<ItemTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " 
                + "mst_item.Code, "
                + "mst_item.Name, "
                + "mst_item_product_category.Code AS itemProductCategoryCode, "
                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.InventoryCategory, "
                + "mst_item.MinStock, " 
                + "mst_item.MaxStock, " 
                + "mst_item.cogsIDR, "                             
                + "SUM(mst_item_jn_current_stock.actualstock) AS OnHandStock, "             
                + "mst_item.Remark, " 
                + "mst_item.activeStatus, "
                + "mst_item.PackageStatus, "
                + "mst_item.InActiveBy, " 
                + "mst_item.InActiveDate, " 
                + "mst_item.createdBy, " 
                + "mst_item.createdDate " 
                + "FROM mst_item " 
                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "LEFT JOIN mst_item_jn_current_stock ON mst_item_jn_current_stock.ItemCode = mst_item.Code "
                + "WHERE mst_item.code LIKE '%"+code+"%' "
                + "AND mst_item.name LIKE '%"+name+"%' "
                + concat_qry_type
                + concat_qry_active
                + concat_qry_category
                + concat_qry_package
                + "GROUP BY mst_item.code "
                + "ORDER BY mst_item.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductCategoryCode", Hibernate.STRING)
                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL) 
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL) 
                .addScalar("onHandStock", Hibernate.BIG_DECIMAL)     
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("packageStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<ItemTemp> findDataSearch(String code, String name,String inventoryType,String inventoryCategory,String packageStatus,String active,int from, int row) {
        try {   
            
            String concat_qry_type=" ";
            if(!inventoryType.equals("") && !inventoryType.equals("null")){
                concat_qry_type="AND mst_item.Inventorytype='"+inventoryType+"' ";
            }
            
            String concat_qry_category=" ";
            if(!inventoryCategory.equals("") && !inventoryCategory.equals("null")){
                concat_qry_category="AND mst_item.InventoryCategory='"+inventoryCategory+"' ";
            }
            
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_item.ActiveStatus="+active+" ";
            }
            
//            String concat_qry_package=" ";
////            if(!packageStatus.equals("")){
//                concat_qry_package="AND mst_item.PackageStatus="+packageStatus+" ";
//            }
            List<ItemTemp> list = (List<ItemTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " 
                + "mst_item.Code, "
                + "mst_item.Name, "
                + "mst_item.`ItemProductSubCategoryCode` AS itemProductSubCategoryCode, "
//                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_item.`UnitOfMeasureCode` AS UnitOfMeasureCode, "
//                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.`ProductTypeCode`, "
                + "mst_item.MinStock, " 
                + "mst_item.MaxStock, " 
                + "mst_item.cogsIDR, "                             
                + "SUM(mst_item_jn_current_stock.actualstock) AS OnHandStock, "             
                + "mst_item.Remark " 
               
                + "FROM mst_item " 
//                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "LEFT JOIN mst_item_jn_current_stock ON mst_item_jn_current_stock.ItemCode = mst_item.Code "
                + "WHERE mst_item.code LIKE '%"+code+"%' "
                + "AND mst_item.name LIKE '%"+name+"%' "
                + concat_qry_type
                + concat_qry_active
                + concat_qry_category
//                + concat_qry_package
                + "GROUP BY mst_item.code "
                + "ORDER BY mst_item.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductSubCategoryCode", Hibernate.STRING)
//                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("UnitOfMeasureCode", Hibernate.STRING)
//                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
//                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("minStock", Hibernate.BIG_DECIMAL)
                .addScalar("maxStock", Hibernate.BIG_DECIMAL) 
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL) 
                .addScalar("onHandStock", Hibernate.BIG_DECIMAL)     
                .addScalar("remark", Hibernate.STRING)
//                .addScalar("activeStatus", Hibernate.BOOLEAN)
//                .addScalar("packageStatus", Hibernate.BOOLEAN)
//                .addScalar("inActiveBy", Hibernate.STRING)
//                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
//                .addScalar("createdBy", Hibernate.STRING)
//                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemTemp> findData(String code, String name,String warehouseCode,int from, int row) {
        try {   
            
            List<ItemTemp> list = (List<ItemTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item.Name, "
                + "mst_item_product_category.Code AS itemProductCategoryCode, "
                + "mst_item_product_category.Name AS ItemProductCategoryName, "
                + "mst_unit_of_measure.Code AS UnitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS UnitOfMeasureName, "
                + "mst_item.InventoryType, "
                + "mst_item.InventoryCategory, "            
                + "mst_item.cogsIDR, "
                + "mst_item.Remark, "
                + "mst_item.activeStatus, "
                + "mst_item.PackageStatus, "
                + "mst_item.InActiveBy, "
                + "mst_item.InActiveDate, "
                + "mst_item.createdBy, "
                + "mst_item.createdDate "                
                + "FROM mst_item "
                + "INNER JOIN mst_item_product_category ON mst_item.ItemProductCategoryCode = mst_item_product_category.code "
                + "INNER JOIN mst_unit_of_measure ON mst_item.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "WHERE mst_item.Name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemProductCategoryCode", Hibernate.STRING)
                .addScalar("itemProductCategoryName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("inventoryCategory", Hibernate.STRING)
                .addScalar("cogsIDR", Hibernate.BIG_DECIMAL) 
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("packageStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Item item, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
//            item.setCode(createCode(item));
//            item.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//            item.setCreatedDate(new Date()); 
                        
            hbmSession.hSession.save(item);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    item.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
     
    public void update(Item item, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            item.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            item.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(item);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    item.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemField.BEAN_NAME + " WHERE " + ItemField.CODE + " = :prmCode")
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
    
    public ItemTemp getMin() {
        try {
            
            String qry = "SELECT mst_item.code,mst_item.Name FROM mst_item ORDER BY mst_item.code LIMIT 0,1";
            ItemTemp itemTemp =(ItemTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                    .uniqueResult();   
            
            return itemTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemTemp getMax() {
        try {
            
            String qry = "SELECT mst_item.code,mst_item.Name FROM mst_item ORDER BY mst_item.code DESC LIMIT 0,1";
            ItemTemp itemTemp =(ItemTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemTemp.class))
                    .uniqueResult();   
            
            return itemTemp;
            
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