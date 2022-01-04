
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
import com.inkombizz.master.model.CurrentStockCogsIdr;
import com.inkombizz.master.model.CurrentStockCogsIdrField;
import com.inkombizz.master.model.CurrentStockCogsIdrTemp;
import java.math.BigInteger;


public class CurrentStockCogsIdrDAO {
    
    private HBMSession hbmSession;

    public CurrentStockCogsIdrDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <CurrentStockCogsIdr> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                +"                 INNER JOIN mst_item ON mst_item.code=mst_item_jn_current_stock.itemCode " 
                +"                 GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode,mst_item_jn_current_stock.COGSIDR " 
                +"        ) qry ")

                .uniqueResult();
            return temp.intValue();

        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataSearch(String warehouseCode, String warehouseName, String itemCode, String itemName){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
            	"SELECT "
                +"COUNT(qry.code) "
                +"FROM "
                +"        ( "
                +"        SELECT mst_item_jn_current_stock.`Code` "
                +"                 FROM mst_item_jn_current_stock "
                +"                 INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode " 
                +"                 INNER JOIN mst_item ON mst_item.code=mst_item_jn_current_stock.itemCode " 
                +"                 WHERE mst_item_jn_current_stock.warehouseCode LIKE :prmWarehouseCode " 
                +"                 AND mst_warehouse.name LIKE :prmWarehouseName " 
                +"                 AND mst_item_jn_current_stock.itemCode LIKE :prmItemCode " 
                +"                 AND mst_item.name LIKE :prmItemName " 
                +"                 GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode,mst_item.COGSIDR " 
                +"        ) qry ")
                .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
                .setParameter("prmWarehouseName", "%"+warehouseName+"%")
                .setParameter("prmItemCode", "%"+itemCode+"%")
                .setParameter("prmItemName", "%"+itemName+"%")
                .uniqueResult();
            return temp.intValue();

        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<CurrentStockCogsIdrTemp> findData(int from, int row) {
        try {   
            
            List<CurrentStockCogsIdrTemp> list = (List<CurrentStockCogsIdrTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_jn_current_stock.code, "
                + "mst_item_jn_current_stock.warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.itemCode, "
                + "mst_item.name AS itemName, "
                + "SUM(mst_item_jn_current_stock.ActualStock) AS currentStock, "
                + "mst_item.UnitOfMeasureCode AS uom, "
                + "mst_item_jn_current_stock.COGSIDR AS cogsIdr, "
                + "(mst_item_jn_current_stock.COGSIDR*SUM(mst_item_jn_current_stock.ActualStock )) AS total "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode "
                + "INNER JOIN mst_item ON mst_item.code=mst_item_jn_current_stock.itemCode "
                + "GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode,mst_item.COGSIDR "            
                + "ORDER BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("currentStock", Hibernate.BIG_DECIMAL)
                .addScalar("uom", Hibernate.STRING)
                .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                
                .setResultTransformer(Transformers.aliasToBean(CurrentStockCogsIdrTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CurrentStockCogsIdrTemp> findDataSearch(String warehouseCode, String warehouseName, String itemCode, String itemName,int from, int row) {
        try {   
            
            List<CurrentStockCogsIdrTemp> list = (List<CurrentStockCogsIdrTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_jn_current_stock.code, "
                + "mst_item_jn_current_stock.warehouseCode, "
                + "mst_warehouse.name AS warehouseName, "
                + "mst_item_jn_current_stock.itemCode, "
                + "mst_item.name AS itemName, "
                + "SUM(mst_item_jn_current_stock.ActualStock) AS currentStock, "
                + "mst_item.UnitOfMeasureCode AS uom, "
                + "mst_item.COGSIDR, "
                + "(mst_item.COGSIDR*SUM(mst_item_jn_current_stock.ActualStock)) AS total "
                + "FROM mst_item_jn_current_stock "
                + "INNER JOIN mst_warehouse ON mst_warehouse.code=mst_item_jn_current_stock.warehouseCode "
                + "INNER JOIN mst_item ON mst_item.code=mst_item_jn_current_stock.itemCode " 
                + "WHERE mst_item_jn_current_stock.warehouseCode LIKE :prmWarehouseCode "
                + "AND mst_warehouse.name LIKE :prmWarehouseName "
                + "AND mst_item_jn_current_stock.itemCode LIKE :prmItemCode "
                + "AND mst_item.name LIKE :prmItemName "
                + "GROUP BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode,mst_item.COGSIDR " 
                + "ORDER BY mst_item_jn_current_stock.warehouseCode,mst_item_jn_current_stock.itemCode ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("currentStock", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .addScalar("uom", Hibernate.STRING)
                .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
                .setParameter("prmWarehouseName", "%"+warehouseName+"%")
                .setParameter("prmItemCode", "%"+itemCode+"%")
                .setParameter("prmItemName", "%"+itemName+"%")
                
                .setResultTransformer(Transformers.aliasToBean(CurrentStockCogsIdrTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CurrentStockCogsIdr> findByCriteria(DetachedCriteria dc) {
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
    
    public CurrentStockCogsIdr get(String id) {
        try {
            return (CurrentStockCogsIdr) hbmSession.hSession.get(CurrentStockCogsIdr.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public void save(CurrentStockCogsIdr currentStockCogsIdr, String moduleCode) {
//        try {
//            hbmSession.hSession.beginTransaction();
//            currentStockCogsIdr.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//            currentStockCogsIdr.setCreatedDate(new Date()); 
////            currentStockCogsIdr.setCurrentStockCogsIdrCode(BaseSession.loadProgramSession().getCurrentStockCogsIdrCode());
////            String Id = currentStockCogsIdr.getCode();
////            currentStockCogsIdr.setId(Id);
//            hbmSession.hSession.save(currentStockCogsIdr);
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
//                                                                    currentStockCogsIdr.getCode(), moduleCode));
//             
//            hbmSession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
//	
//    public void update(CurrentStockCogsIdr currentStockCogsIdr, String moduleCode) {
//        try {
//            hbmSession.hSession.beginTransaction();
//            hbmSession.hSession.update(currentStockCogsIdr);
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
//                                                                    currentStockCogsIdr.getCode(), moduleCode));
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
//            hbmSession.hSession.createQuery("DELETE FROM " + CurrentStockCogsIdrField.BEAN_NAME + " WHERE " + CurrentStockCogsIdrField.CODE + " = :prmCode")
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
    
    public CurrentStockCogsIdrTemp getMin() {
        try {
            
            String qry = "SELECT mst_item_jn_current_stock.code,mst_item_jn_current_stock.Name FROM mst_item_jn_current_stock ORDER BY mst_item_jn_current_stock.code LIMIT 0,1";
            CurrentStockCogsIdrTemp companyTemp =(CurrentStockCogsIdrTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CurrentStockCogsIdrTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CurrentStockCogsIdrTemp getMax() {
        try {
            
            String qry = "SELECT mst_item_jn_current_stock.code,mst_item_jn_current_stock.Name FROM mst_item_jn_current_stock ORDER BY mst_item_jn_current_stock.code DESC LIMIT 0,1";
            CurrentStockCogsIdrTemp companyTemp =(CurrentStockCogsIdrTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CurrentStockCogsIdrTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }

}
