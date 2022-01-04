

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

import com.inkombizz.master.model.Bank;
import com.inkombizz.master.model.BankTemp;
import com.inkombizz.master.model.BankField;



public class BankDAO {
    
    private HBMSession hbmSession;
    
    public BankDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_bank.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_bank "
                + "WHERE mst_bank.code LIKE '%"+code+"%' "
                + "AND mst_bank.name LIKE '%"+name+"%' "
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
    
    public BankTemp findData(String code) {
        try {
            BankTemp bankTemp = (BankTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank.Code, "
                + "mst_bank.name, "
                + "mst_bank.activeStatus, "
                + "mst_bank.remark, "
                + "mst_bank.InActiveBy, "
                + "mst_bank.InActiveDate, "
                + "mst_bank.CreatedBy, "
                + "mst_bank.CreatedDate "
                + "FROM mst_bank "
                + "WHERE mst_bank.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(BankTemp.class))
                .uniqueResult(); 
                 
                return bankTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BankTemp findData(String code,boolean active) {
        try {
            BankTemp bankTemp = (BankTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank.Code, "
                + "mst_bank.name, "
                + "mst_bank.remark "
                + "FROM mst_bank "
                + "WHERE mst_bank.code ='"+code+"' "
                + "AND mst_bank.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankTemp.class))
                .uniqueResult(); 
                 
                return bankTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<BankTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_bank.ActiveStatus="+active+" ";
            }
            List<BankTemp> list = (List<BankTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank.Code, "
                + "mst_bank.name, "
                + "mst_bank.remark, "
                + "mst_bank.ActiveStatus "
                + "FROM mst_bank "
                + "WHERE mst_bank.code LIKE '%"+code+"%' "
                + "AND mst_bank.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(BankTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Bank bank, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(bank.isActiveStatus()){
                bank.setInActiveBy("");                
            }else{
                bank.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                bank.setInActiveDate(new Date());
            }
            
            bank.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            bank.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(bank);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    bank.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Bank bank, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(bank.isActiveStatus()){
                bank.setInActiveBy("");                
            }else{
                bank.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                bank.setInActiveDate(new Date());
            }
            bank.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bank.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(bank);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    bank.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + BankField.BEAN_NAME + " WHERE " + BankField.CODE + " = :prmCode")
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
