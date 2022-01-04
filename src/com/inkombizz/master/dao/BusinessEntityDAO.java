
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.master.model.BusinessEntity; 
import com.inkombizz.master.model.BusinessEntityTemp;
import com.inkombizz.master.model.BusinessEntityField;
//import com.inkombizz.master.model.ExchangerateTaxTemp;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;



public class BusinessEntityDAO {
    
     private HBMSession hbmSession;
    
    public BusinessEntityDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_business_entity.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_business_entity "
                + "WHERE mst_business_entity.code LIKE '%"+code+"%' "
                + "AND mst_business_entity.name LIKE '%"+name+"%' "
                + concat_qry
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
    
  
    public BusinessEntityTemp findData(String code) {
        try {
            BusinessEntityTemp businessEntityTemp = (BusinessEntityTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_business_entity.Code, "
                + "mst_business_entity.name, "
                + "mst_business_entity.remark, "
                + "mst_business_entity.activeStatus, "
                + "mst_business_entity.createdBy, "
                + "mst_business_entity.createdDate "
                + "FROM mst_business_entity "
                + "WHERE mst_business_entity.code ='"+code+"' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(BusinessEntityTemp.class))
                .uniqueResult(); 
                 
                return businessEntityTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
     public BusinessEntity get(String code) {
        try {
            return (BusinessEntity) hbmSession.hSession.get(BusinessEntity.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BusinessEntityTemp findData(String code,boolean active) {
        try {
            BusinessEntityTemp businessEntityTemp = (BusinessEntityTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_business_entity.Code, "
                + "mst_business_entity.name "
                + "FROM mst_business_entity "
                + "WHERE mst_business_entity.code ='"+code+"' "
                + "AND mst_business_entity.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BusinessEntityTemp.class))
                .uniqueResult(); 
                 
                return businessEntityTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BusinessEntityTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_business_entity.ActiveStatus="+active+" ";
            }
            List<BusinessEntityTemp> list = (List<BusinessEntityTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_business_entity.Code AS code, "
                + "mst_business_entity.name AS name, "
                + "mst_business_entity.remark AS remark, "
                + "mst_business_entity.activeStatus "
                + "FROM "
                + "mst_business_entity "
                + "WHERE "
                + "mst_business_entity.code LIKE '%"+code+"%' "
                + "AND mst_business_entity.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(BusinessEntityTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
//     
//    public List<ExchangerateTaxTemp> getForProcessing() {
//        try {
//            return (List<ExchangerateTaxTemp>) hbmSession.hSession.createSQLQuery(
//                        "SELECT "
//                    + "sys_setup.BusinessEntityCode AS currencyCode "
//                    + "FROM sys_setup "
//                    + "UNION "
//                    + "SELECT "
//                    + "DISTINCT(sal_sales_order.currencycode) AS currencyCode "
//                    + "FROM sal_sales_order "
//                    + "WHERE currencycode NOT IN(SELECT BusinessEntityCode AS currencycode FROM sys_setup)")
//                    .addScalar("currencyCode", Hibernate.STRING)
//                    .setResultTransformer(Transformers.aliasToBean(ExchangerateTaxTemp.class))
//                    .list();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public BusinessEntityTemp findOneData(String code, boolean active) {
        try {   
            
            return (BusinessEntityTemp)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_business_entity.Code AS code, "
                + "mst_business_entity.name AS name, "
                + "mst_business_entity.ActiveStatus, "
                + "mst_business_entity.Remark AS remark, "
                + "mst_business_entity.InActiveBy AS inActiveBy, "
                + "mst_business_entity.InActiveDate AS inActiveDate "
                + "FROM mst_business_entity "
                + "WHERE mst_business_entity.code LIKE :prmCode "
                + "AND mst_business_entity.ActiveStatus = :prmActive "
                + "ORDER BY mst_business_entity.code")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", code)
                .setParameter("prmActive", active)
                .setResultTransformer(Transformers.aliasToBean(BusinessEntityTemp.class))
                .uniqueResult(); 
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(BusinessEntity businessEntity, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            businessEntity.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            businessEntity.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(businessEntity);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    businessEntity.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(BusinessEntity businessEntity, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            businessEntity.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            businessEntity.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(businessEntity);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    businessEntity.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + BusinessEntityField.BEAN_NAME + " WHERE " + BusinessEntityField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public int checkIsExistToDeleteBarcodeDetail (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN mst_barcode_detail ON mst_barcode_detail.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "mst_barcode_detail.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteExchangerateBi (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN mst_exchangerate_bi ON mst_exchangerate_bi.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "mst_exchangerate_bi.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteExchangerateTax (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN mst_exchangerate_tax ON mst_exchangerate_tax.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "mst_exchangerate_tax.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteCustomerDownPayment (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN fin_customer_down_payment ON fin_customer_down_payment.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "fin_customer_down_payment.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteSupplierDownPayment (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN fin_supplier_down_payment ON fin_supplier_down_payment.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "fin_supplier_down_payment.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteGoodsReciveNote (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN ivt_goods_invoice_note ON ivt_goods_invoice_note.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "ivt_goods_invoice_note.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteInventoryIn (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN ivt_inventory_in ON ivt_inventory_in.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "ivt_inventory_in.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteInventoryOut (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN ivt_inventory_out ON ivt_inventory_out.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "ivt_inventory_out.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeletePurchaseOrder (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN pur_purchase_order ON pur_purchase_order.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "pur_purchase_order.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteBookingOrder (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN sal_booking_order ON sal_booking_order.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "sal_booking_order.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteInvoice (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN sal_invoice ON sal_invoice.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "sal_invoice.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteSalesOrder (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN sal_sales_order ON sal_sales_order.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "sal_sales_order.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int checkIsExistToDeleteSupplierInvoice (String Code){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
            + "SELECT COUNT(mst_business_entity.code)  "
            + "FROM mst_business_entity  "
            + "INNER JOIN fin_supplier_invoice ON fin_supplier_invoice.currencycode = mst_business_entity.code  " 
            + "WHERE "       
            + "fin_supplier_invoice.currencycode = '"+Code+"'  ").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    
}
