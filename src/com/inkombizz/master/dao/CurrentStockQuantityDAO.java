
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.CurrentStockQuantity;
import com.inkombizz.master.model.CurrentStockQuantityField;
import com.inkombizz.master.model.CurrentStockQuantityTemp;
import java.math.BigInteger;


public class CurrentStockQuantityDAO {
    
    private HBMSession hbmSession;

    public CurrentStockQuantityDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <CurrentStockQuantity> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    public int countData(){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                +"COUNT(qry.code) "
                +"FROM "
                +"        ( "
                +"        SELECT mst_item_jn_current_stock.Code "
                +"                 FROM mst_item_jn_current_stock " 
                +"                 INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode " 
                +"                 INNER JOIN mst_item_material ON mst_item_material.code=mst_item_jn_current_stock.itemCode " 
                +"                 GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode " 
                +"        ) qry ")

                .uniqueResult();
            return temp.intValue();

        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataSearch(String warehouseCode, String warehouseName, String itemCode, String itemName,
            String rackCode,String rackName){
        try{
            String userCodeTemp = BaseSession.loadProgramSession().getUserCode();
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
            "SELECT " 
            +"COUNT(qry.code) "
            +"FROM "
            +"        ( "
            +"   SELECT mst_item_jn_current_stock.Code "
            +"     FROM mst_item_jn_current_stock " 
            +"        INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode " 
            +"        INNER JOIN mst_item_material ON mst_item_material.code=mst_item_jn_current_stock.itemCode " 
            +"        INNER JOIN mst_rack ON mst_rack.Code = mst_item_jn_current_stock.`RackCode` "
            +"        WHERE mst_item_jn_current_stock.warehouseCode LIKE '%"+ warehouseCode +"%' " 
            +"        AND mst_warehouse.name LIKE '%"+ warehouseName +"%' " 
            +"        AND mst_item_jn_current_stock.itemCode LIKE '%"+ itemCode +"%' " 
            +"        AND mst_item_material.name LIKE '%"+ itemName +"%' " 
            +"        AND mst_item_jn_current_stock.RackCode LIKE '%"+ rackCode +"%' " 
            +"        AND mst_rack.name LIKE '%"+ rackName +"%' " 
            +"        GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode " 
            +"        ) qry ")
         
                .uniqueResult();
            return temp.intValue();

        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<CurrentStockQuantityTemp> findData(String warehouseCode, String warehouseName, 
            String itemCode, String itemName,String rackCode, String rackName,int from, int row) {
        try {   
            String userCodeTemp=BaseSession.loadProgramSession().getUserCode();            
            List<CurrentStockQuantityTemp> list = (List<CurrentStockQuantityTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_jn_current_stock.code, "
                + "mst_item_jn_current_stock.warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.itemCode, "
                + "mst_item_material.name AS itemName, "  
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.name AS rackName "  
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode "
                + "INNER JOIN mst_item_material ON mst_item_material.code=mst_item_jn_current_stock.itemCode "
                + "INNER JOIN mst_rack ON mst_rack.Code = mst_item_jn_current_stock.`RackCode` "
                + "WHERE mst_item_jn_current_stock.warehouseCode LIKE '%"+ warehouseCode +"%' "
                + "AND mst_warehouse.name LIKE '%"+ warehouseName +"%' "
                + "AND mst_item_jn_current_stock.itemCode LIKE '%"+ itemCode +"%' "
                + "AND mst_item_material.name LIKE '%"+ itemName +"%' "
                + "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+ rackCode +"%' "
                + "AND mst_rack.name LIKE '%"+ rackName +"%' "
                + "GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode " 
                + "ORDER BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("actualStock", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CurrentStockQuantityTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CurrentStockQuantityTemp> findDataSearch(String warehouseCode, String warehouseName, 
            String itemCode, String itemName,String rackCode, String rackName,int from, int row) {
        try {   
            String userCodeTemp=BaseSession.loadProgramSession().getUserCode();
            List<CurrentStockQuantityTemp> list = (List<CurrentStockQuantityTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_jn_current_stock.code, "
                + "mst_item_jn_current_stock.warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.itemCode, "
                + "mst_item_material.name AS itemName, "
                + "mst_item_material.UnitOfMeasureCode AS uom, "
                + "mst_item_jn_current_stock.RackCode, "
                + "mst_rack.name AS rackName, " 
                + "mst_item_jn_current_stock.ActualStock "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode "
                + "INNER JOIN mst_item_material ON mst_item_material.code=mst_item_jn_current_stock.itemCode "
                + "INNER JOIN mst_rack ON mst_rack.Code = mst_item_jn_current_stock.`RackCode` "
                + "WHERE mst_item_jn_current_stock.warehouseCode LIKE '%"+ warehouseCode +"%' "
                + "AND mst_warehouse.name LIKE '%"+ warehouseName +"%' "
                + "AND mst_item_jn_current_stock.itemCode LIKE '%"+ itemCode +"%' "
                + "AND mst_item_material.name LIKE '%"+ itemName +"%' "
                + "AND mst_item_jn_current_stock.`RackCode` LIKE '%"+ rackCode +"%' "
                + "AND mst_rack.name LIKE '%"+ rackName +"%' "
                + "GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode " 
                + "ORDER BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("uom", Hibernate.STRING)
                .addScalar("actualStock", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CurrentStockQuantityTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CurrentStockQuantity> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            
            List countData = criteria.list();
            
            if (countData.isEmpty())
                return 0;
            else {
                return  ( Integer.parseInt(countData.get(0).toString()) ) ;
            }
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CurrentStockQuantity get(String id) {
        try {
            return (CurrentStockQuantity) hbmSession.hSession.get(CurrentStockQuantity.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public void save(CurrentStockQuantity currentStockQuantity, String moduleCode) {
//        try {
//            hbmSession.hSession.beginTransaction();
//            currentStockQuantity.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//            currentStockQuantity.setCreatedDate(new Date()); 
////            currentStockQuantity.setCurrentStockQuantityCode(BaseSession.loadProgramSession().getCurrentStockQuantityCode());
////            String Id = currentStockQuantity.getCode();
////            currentStockQuantity.setId(Id);
//            hbmSession.hSession.save(currentStockQuantity);
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
//                                                                    currentStockQuantity.getCode(), moduleCode));
//             
//            hbmSession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
	
//    public void update(CurrentStockQuantity currentStockQuantity, String moduleCode) {
//        try {
//            hbmSession.hSession.beginTransaction();
//            hbmSession.hSession.update(currentStockQuantity);
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
//                                                                    currentStockQuantity.getCode(), moduleCode));
//             
//            hbmSession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
//	
//    public void delete(String id, String moduleCode) {
//        try {
//            hbmSession.hSession.beginTransaction();
//            hbmSession.hSession.createQuery("DELETE FROM " + CurrentStockQuantityField.BEAN_NAME + " WHERE " + CurrentStockQuantityField.CODE + " = :prmCode")
//                    .setParameter("prmCode", id)
//                    .executeUpdate();
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
//                                                                    id, moduleCode));
//             
//            hbmSession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    } 
    
    public CurrentStockQuantityTemp getMin() {
        try {
            
            String qry = "SELECT mst_item_jn_current_stock.code,mst_item_jn_current_stock.Name FROM mst_item_jn_current_stock ORDER BY mst_item_jn_current_stock.code LIMIT 0,1";
            CurrentStockQuantityTemp companyTemp =(CurrentStockQuantityTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CurrentStockQuantityTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CurrentStockQuantityTemp getMax() {
        try {
            
            String qry = "SELECT mst_item_jn_current_stock.code,mst_item_jn_current_stock.Name FROM mst_item_jn_current_stock ORDER BY mst_item_jn_current_stock.code DESC LIMIT 0,1";
            CurrentStockQuantityTemp companyTemp =(CurrentStockQuantityTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CurrentStockQuantityTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
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
