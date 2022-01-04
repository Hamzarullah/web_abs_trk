

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.CurrencyTemp;
import com.inkombizz.master.model.CurrencyField;



public class CurrencyDAO {
    
    private HBMSession hbmSession;
    
    public CurrencyDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_currency.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_currency "
                + "WHERE mst_currency.code LIKE '%"+code+"%' "
                + "AND mst_currency.name LIKE '%"+name+"%' "
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
    
    public CurrencyTemp findData(String code) {
        try {
            CurrencyTemp currencyTemp = (CurrencyTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_currency.Code, "
                + "mst_currency.name, "
                + "mst_currency.activeStatus, "
                + "mst_currency.remark, "
                + "mst_currency.InActiveBy, "
                + "mst_currency.InActiveDate, "
                + "mst_currency.CreatedBy, "
                + "mst_currency.CreatedDate "
                + "FROM mst_currency "
                + "WHERE mst_currency.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CurrencyTemp.class))
                .uniqueResult(); 
                 
                return currencyTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CurrencyTemp findData(String code,boolean active) {
        try {
            CurrencyTemp currencyTemp = (CurrencyTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_currency.Code, "
                + "mst_currency.name, "
                + "mst_currency.remark "
                + "FROM mst_currency "
                + "WHERE mst_currency.code ='"+code+"' "
                + "AND mst_currency.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CurrencyTemp.class))
                .uniqueResult(); 
                 
                return currencyTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CurrencyTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_currency.ActiveStatus="+active+" ";
            }
            List<CurrencyTemp> list = (List<CurrencyTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_currency.Code, "
                + "mst_currency.name, "
                + "mst_currency.remark, "
                + "mst_currency.ActiveStatus "
                + "FROM mst_currency "
                + "WHERE mst_currency.code LIKE '%"+code+"%' "
                + "AND mst_currency.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CurrencyTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Currency currency, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(currency.isActiveStatus()){
                currency.setInActiveBy("");                
            }else{
                currency.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                currency.setInActiveDate(new Date());
            }
            
            currency.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            currency.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(currency);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    currency.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Currency currency, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(currency.isActiveStatus()){
                currency.setInActiveBy("");                
            }else{
                currency.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                currency.setInActiveDate(new Date());
            }
         //   currency.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
       //     currency.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(currency);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    currency.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CurrencyField.BEAN_NAME + " WHERE " + CurrencyField.CODE + " = :prmCode")
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
