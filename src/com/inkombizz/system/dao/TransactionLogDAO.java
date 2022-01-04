package com.inkombizz.system.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.system.model.TransactionLog;
import com.inkombizz.system.model.TransactionLogField;
import com.inkombizz.system.model.TransactionLogTemp;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class TransactionLogDAO {
    private HBMSession hbmSession;
	
    public TransactionLogDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String actionType,String moduleCode,String userCode,Date firstDate,Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concatQryActionType="";
            if(!actionType.equals("ALL")){
                concatQryActionType="AND sys_transaction_log.ActionType='"+actionType+"' ";
            }
            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "COUNT(*) "
                + "FROM sys_transaction_log "
                + "WHERE sys_transaction_log.TransactionCode LIKE '%"+code+"%' "
                + concatQryActionType
                + "AND sys_transaction_log.ModuleCode LIKE '%"+moduleCode+"%' "
                + "AND sys_transaction_log.UserCode LIKE '%"+userCode+"%' "
                + "AND DATE(sys_transaction_log.LogDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
            ).uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<TransactionLogTemp> findData(String code,String actionType,String moduleCode,String userCode,Date firstDate,Date lastDate,int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concatQryActionType="";
            if(!actionType.equals("ALL")){
                concatQryActionType="AND sys_transaction_log.ActionType='"+actionType+"' ";
            }
            
            List<TransactionLogTemp> list = (List<TransactionLogTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sys_transaction_log.Code, "
                + "sys_transaction_log.ActionType, "
                + "sys_transaction_log.Description, "
                + "sys_transaction_log.IPNo, "
                + "sys_transaction_log.LogDate, "
                + "sys_transaction_log.ModuleCode, "
                + "sys_transaction_log.TransactionCode, "
                + "sys_transaction_log.UserCode "
                + "FROM sys_transaction_log "
                + "WHERE sys_transaction_log.code LIKE '%"+code+"%' "
                + concatQryActionType
                + "AND sys_transaction_log.ModuleCode LIKE '%"+moduleCode+"%' "
                + "AND sys_transaction_log.UserCode LIKE '%"+userCode+"%' "
                + "AND DATE(sys_transaction_log.LogDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY sys_transaction_log.LogDate DESC "
                + "LIMIT "+from+","+to+"")
   
                .addScalar("code", Hibernate.STRING)
                .addScalar("actionType", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("ipNo", Hibernate.STRING)
                .addScalar("logDate", Hibernate.TIMESTAMP)
                .addScalar("moduleCode", Hibernate.STRING)
                .addScalar("transactionCode", Hibernate.STRING)
                .addScalar("userCode", Hibernate.STRING)    
                .addScalar("moduleCode", Hibernate.STRING)
          
                .setResultTransformer(Transformers.aliasToBean(TransactionLogTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<TransactionLog> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<TransactionLog> findByCriteria(DetachedCriteria dc) {
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
            if (criteria.list().isEmpty())
                return 0;
            else
                return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public TransactionLog get(String code) {
        try {
            return (TransactionLog) hbmSession.hSession.get(TransactionLog.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    private String createCode(TransactionLog transactionLog){
        String acronim = transactionLog.getModuleCode() + "/" + transactionLog.getTransactionCode() + "-";

        DetachedCriteria dc = DetachedCriteria.forClass(TransactionLog.class)
                .setProjection(Projections.max(TransactionLogField.CODE))
                .add(Restrictions.eq(TransactionLogField.MODULECODE, transactionLog.getModuleCode()))
                .add(Restrictions.eq(TransactionLogField.TRANSACTIONCODE, transactionLog.getTransactionCode()))
                .add(Restrictions.like(TransactionLogField.CODE, acronim + "%" ));

        Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
        List list = criteria.list();

        String oldID = "";
        if (list.get(0) == null)
            oldID = "";
        else
            oldID = list.get(0).toString();

        return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH);
    }
     
    private String createCodeCOA(TransactionLog transactionLog){
        String acronim = transactionLog.getModuleCode() + "/" + transactionLog.getTransactionCode() + "-";

        DetachedCriteria dc = DetachedCriteria.forClass(TransactionLog.class)
                .setProjection(Projections.max(TransactionLogField.CODE))
                .add(Restrictions.eq(TransactionLogField.MODULECODE, transactionLog.getModuleCode()))
                .add(Restrictions.eq(TransactionLogField.TRANSACTIONCODE, transactionLog.getTransactionCode()))
                .add(Restrictions.like(TransactionLogField.CODE, acronim + "%" ));

        Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
        List list = criteria.list();

        String oldID = "";
        if (list.get(0) == null)
            oldID = "";
        else
            oldID = list.get(0).toString();

        return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH);
    }
    
    public void save(TransactionLog transactionLog){
        try {
            //hbmSession.hSession.beginTransaction();
            
            String code = createCode(transactionLog);
            
            transactionLog.setCode(code);
                    
            hbmSession.hSession.save(transactionLog);
            //hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            throw e;
        }
        
        /*
        catch (Exception ex) {
            throw ex;
        }
        */
    }
    
    public void saveCOA(TransactionLog transactionLog){
        try {
            //hbmSession.hSession.beginTransaction();
            
            String code = createCodeCOA(transactionLog);
            
            transactionLog.setCode(code);
                    
            hbmSession.hSession.save(transactionLog);
            //hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            throw e;
        }
        
        /*
        catch (Exception ex) {
            throw ex;
        }
        */
    }
    /*
    public void save(TransactionLog transactionLog) {
        try {
            hbmSession.hSession.beginTransaction();
            
            String code = createCode(transactionLog);
            
            transactionLog.setCode(code);
                    
            hbmSession.hSession.save(transactionLog);
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public void update(TransactionLog transactionLog) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(transactionLog);
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    */
    
    public void delete(String code) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + TransactionLogField.BEAN_NAME + " WHERE " + TransactionLogField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
}