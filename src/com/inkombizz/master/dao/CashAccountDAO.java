

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

import com.inkombizz.master.model.CashAccount;
import com.inkombizz.master.model.CashAccountTemp;
import com.inkombizz.master.model.CashAccountField;



public class CashAccountDAO {
    
    private HBMSession hbmSession;
    
    public CashAccountDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_cash_account.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                 + "FROM mst_cash_account "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.code = mst_cash_account.chartOfAccountCode "            
                + "WHERE mst_cash_account.code LIKE '%"+code+"%' "
                + "AND mst_cash_account.name LIKE '%"+name+"%' "
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
    
    public CashAccountTemp findData(String code) {
        try {
            CashAccountTemp cashAccountTemp = (CashAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cash_account.code, "
                + "mst_cash_account.name, "
                + "mst_cash_account.chartOfAccountCode, "
                + "mst_cash_account.bkmVoucherNo, "
                + "mst_cash_account.bkkVoucherNo, "
                + "mst_cash_account.activeStatus, "
                + "mst_cash_account.remark, "
                + "mst_cash_account.InActiveBy, "
                + "mst_cash_account.InActiveDate, "
                + "mst_cash_account.CreatedBy, "
                + "mst_cash_account.CreatedDate "
                + "FROM mst_cash_account "
                + "WHERE mst_cash_account.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("bkmVoucherNo", Hibernate.STRING)
                .addScalar("bkkVoucherNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CashAccountTemp.class))
                .uniqueResult(); 
                 
                return cashAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CashAccountTemp findData(String code,boolean active) {
        try {
            CashAccountTemp cashAccountTemp = (CashAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cash_account.Code, "
                + "mst_cash_account.name, "
                + "mst_cash_account.remark "
                + "FROM mst_cash_account "
                + "WHERE mst_cash_account.code ='"+code+"' "
                + "AND mst_cash_account.ActiveStatus ="+active+" ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CashAccountTemp.class))
                .uniqueResult(); 
                 
                return cashAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CashAccountTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_cash_account.ActiveStatus="+active+" ";
            }
            List<CashAccountTemp> list = (List<CashAccountTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cash_account.Code, "
                + "mst_cash_account.name, "
                + "mst_cash_account.remark, "
                + "mst_cash_account.bkmVoucherNo, "
                + "mst_cash_account.bkkVoucherNo, "
                + "mst_cash_account.chartOfAccountCode, "
                + "mst_chart_of_account.name AS chartOfAccountName, "            
                + "mst_cash_account.ActiveStatus "
                + "FROM mst_cash_account "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.code = mst_cash_account.chartOfAccountCode "            
                + "WHERE mst_cash_account.code LIKE '%"+code+"%' "
                + "AND mst_cash_account.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("bkmVoucherNo", Hibernate.STRING)
                .addScalar("bkkVoucherNo", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CashAccountTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(CashAccount cashAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(cashAccount.isActiveStatus()){
                cashAccount.setInActiveBy("");                
            }else{
                cashAccount.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                cashAccount.setInActiveDate(new Date());
            }
            
            cashAccount.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            cashAccount.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(cashAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    cashAccount.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(CashAccount cashAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(cashAccount.isActiveStatus()){
                cashAccount.setInActiveBy("");                
            }else{
                cashAccount.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                cashAccount.setInActiveDate(new Date());
            }
            cashAccount.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cashAccount.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(cashAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    cashAccount.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CashAccountField.BEAN_NAME + " WHERE " + CashAccountField.CODE + " = :prmCode")
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
