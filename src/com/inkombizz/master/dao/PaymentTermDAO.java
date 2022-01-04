

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.master.model.PaymentTermTemp;
import com.inkombizz.master.model.PaymentTermField;
import org.hibernate.criterion.Restrictions;



public class PaymentTermDAO {
    
    private HBMSession hbmSession;
    
    public PaymentTermDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(PaymentTerm paymentTerm){   
        try{
            String acronim = "PAYTRM";
            DetachedCriteria dc = DetachedCriteria.forClass(PaymentTerm.class)
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
    
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_payment_term.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_payment_term "
                + "WHERE mst_payment_term.code LIKE '%"+code+"%' "
                + "AND mst_payment_term.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataByVendor(String vendorCode, String code,String name){
        try{
            String concat_qry="";
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + " SELECT "
                + "	COUNT(*) "
                + "FROM "
                + "	mst_vendor "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_vendor.PaymentTermCode "
                + "WHERE "
                + "	mst_vendor.Code = '"+vendorCode+"' "
                + "	AND mst_payment_term.Code LIKE '%"+code+"%' "
                + "	AND mst_payment_term.Name LIKE '%"+name+"%' "
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
    
    public PaymentTermTemp findData(String code) {
        try {
            PaymentTermTemp PaymentTermTemp = (PaymentTermTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_payment_term.Code, "
                + "mst_payment_term.name, "
                + "mst_payment_term.days, "
                + "mst_payment_term.activeStatus, "
                + "mst_payment_term.remark, "
                + "mst_payment_term.InActiveBy, "
                + "mst_payment_term.InActiveDate, "
                + "mst_payment_term.CreatedBy, "
                + "mst_payment_term.CreatedDate "
                + "FROM mst_payment_term "
                + "WHERE mst_payment_term.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("days", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(PaymentTermTemp.class))
                .uniqueResult(); 
                 
                return PaymentTermTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PaymentTermTemp findData(String code,boolean active) {
        try {
            PaymentTermTemp PaymentTermTemp = (PaymentTermTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_payment_term.Code, "
                + "mst_payment_term.name, "
                + "mst_payment_term.Days, "
                + "mst_payment_term.remark "
                + "FROM mst_payment_term "
                + "WHERE mst_payment_term.code ='"+code+"' "
                + "AND mst_payment_term.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("days", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PaymentTermTemp.class))
                .uniqueResult(); 
                 
                return PaymentTermTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PaymentTermTemp findDataByVendor(String vendorCode,String code) {
        try {
            PaymentTermTemp PaymentTermTemp = (PaymentTermTemp)hbmSession.hSession.createSQLQuery(""
                + " SELECT "
                + "	mst_vendor.Code AS vendorCode, "
                + "	mst_vendor.Name AS vendorName, "
                + "	mst_payment_term.Code AS paymentTermCode, "
                + "	mst_payment_term.Name AS paymentTermName "
                + "FROM "
                + "	mst_vendor "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_vendor.PaymentTermCode "
                + "WHERE "
                + "	mst_vendor.Code = '"+vendorCode+"' "
                + "	AND mst_payment_term.Code LIKE '%"+code+"%' "
                )
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PaymentTermTemp.class))
                .uniqueResult(); 
                 
                return PaymentTermTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<PaymentTermTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_payment_term.ActiveStatus="+active+" ";
            }
            List<PaymentTermTemp> list = (List<PaymentTermTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_payment_term.Code, "
                + "mst_payment_term.name, "
                + "mst_payment_term.Days , "
                + "mst_payment_term.remark, "
                + "mst_payment_term.ActiveStatus "
                + "FROM mst_payment_term "
                + "WHERE mst_payment_term.code LIKE '%"+code+"%' "
                + "AND mst_payment_term.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("days", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(PaymentTermTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PaymentTermTemp> findDataByVendor(String vendorCode, String code, String name,int from, int row) {
        try {
            
            List<PaymentTermTemp> list = (List<PaymentTermTemp>)hbmSession.hSession.createSQLQuery(""
                + " SELECT "
                + "	mst_vendor.Code AS vendorCode, "
                + "	mst_vendor.Name AS vendorName, "
                + "	mst_payment_term.Code AS paymentTermCode, "
                + "	mst_payment_term.Name AS paymentTermName "
                + "FROM "
                + "	mst_vendor "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_vendor.PaymentTermCode "
                + "WHERE "
                + "	mst_vendor.Code = '"+vendorCode+"' "
                + "	AND mst_payment_term.Code LIKE '%"+code+"%' "
                + "	AND mst_payment_term.Name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PaymentTermTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(PaymentTerm PaymentTerm, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            PaymentTerm.setCode(createCode(PaymentTerm));
            if(PaymentTerm.isActiveStatus()){
                PaymentTerm.setInActiveBy("");                
            }else{
                PaymentTerm.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                PaymentTerm.setInActiveDate(new Date());
            }
            
            PaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            PaymentTerm.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(PaymentTerm);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    PaymentTerm.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(PaymentTerm PaymentTerm, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(PaymentTerm.isActiveStatus()){
                PaymentTerm.setInActiveBy("");                
            }else{
                PaymentTerm.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                PaymentTerm.setInActiveDate(new Date());
            }
            PaymentTerm.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            PaymentTerm.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(PaymentTerm);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    PaymentTerm.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + PaymentTermField.BEAN_NAME + " WHERE " + PaymentTermField.CODE + " = :prmCode")
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
    
    
    
}
