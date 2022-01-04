
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.BankAccount;
import com.inkombizz.master.model.BankAccountField;
import com.inkombizz.master.model.BankAccountTemp;


public class BankAccountDAO {
    
    private HBMSession hbmSession;
    
    public BankAccountDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_bank_account.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_bank_account "
                + "WHERE mst_bank_account.code LIKE '%"+code+"%' "
                + "AND mst_bank_account.name LIKE '%"+name+"%' "
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
    
 
    public List<BankAccountTemp> findData(String code, String name,String bbmVoucherNo, String ChartOfAccountCode, String ChartOfAccountName,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_bank_account.ActiveStatus="+active+" ";
            }
            List<BankAccountTemp> list = (List<BankAccountTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank_account.Code, "
                + "mst_bank_account.name, "
                + "mst_bank_account.ACNo, "
                + "mst_bank_account.ACName, "
                + "mst_bank_account.BankCode AS bankCode, "
                + "mst_bank.name AS bankName, "
                + "mst_bank_account.bankBranch AS bankBranch, "
                + "mst_bank_account.bbmVoucherNo AS bbmVoucherNo, "
                + "mst_bank_account.bbkVoucherNo AS bbkVoucherNo, "
                + "mst_bank_account.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS ChartOfAccountName, "
//                + "mst_bank_account.BBMGiroChartOfAccountCode, "
//                + "mst_chart_of_account_bbm.name AS BBMGiroChartOfAccountName, "
//                + "mst_bank_account.BBKGiroChartOfAccountCode, "
//                + "mst_chart_of_account_bbk.name AS BBKGiroChartOfAccountName,"
                + "mst_bank_account.ActiveStatus "
                + "FROM mst_bank_account "
                + "INNER JOIN mst_bank ON mst_bank_account.BankCode=mst_bank.code "
                + "INNER JOIN mst_chart_of_account ON mst_bank_account.ChartOfAccountCode=mst_chart_of_account.code "
//                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbm ON mst_bank_account.BBMGiroChartOfAccountCode=mst_chart_of_account_bbm.code "
//                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbk ON mst_bank_account.BBKGiroChartOfAccountCode=mst_chart_of_account_bbk.code "
                + "WHERE mst_bank_account.code LIKE '%"+code+"%' "
                + "AND mst_bank_account.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("bbmVoucherNo", Hibernate.STRING)
                .addScalar("bbkVoucherNo", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
//                .addScalar("bbmGiroChartOfAccountCode", Hibernate.STRING)
//                .addScalar("bbmGiroChartOfAccountName", Hibernate.STRING)
//                .addScalar("bbkGiroChartOfAccountCode", Hibernate.STRING)
//                .addScalar("bbkGiroChartOfAccountName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
        
    public BankAccountTemp findData(String code){
        try {
            BankAccountTemp bankAccountTemp = (BankAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank_account.code, "
                + "mst_bank_account.name, "
                + "mst_bank_account.ACNo, "
                + "mst_bank_account.ACName, "
                + "mst_bank_account.BankCode AS bankCode, "
                + "mst_bank.Name AS bankName, "
                + "mst_bank_account.bankBranch AS bankBranch, "
                + "mst_bank_account.bbmVoucherNo AS bbmVoucherNo, "
                + "mst_bank_account.bbkVoucherNo AS bbkVoucherNo, "
                + "mst_bank_account.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS ChartOfAccountName, "
//                + "mst_bank_account.BBMGiroChartOfAccountCode, "
//                + "mst_chart_of_account_bbm.name AS BBMGiroChartOfAccountName, "
//                + "mst_bank_account.BBKGiroChartOfAccountCode, "
//                + "mst_chart_of_account_bbk.name AS BBKGiroChartOfAccountName,"
                + "mst_bank_account.ActiveStatus, "
                + "mst_bank_account.Remark, "
                + "mst_bank_account.InActiveBy, "
                + "mst_bank_account.InActiveDate, "
                + "mst_bank_account.CreatedBy, "
                + "mst_bank_account.CreatedDate "
                + "FROM mst_bank_account "
                + "INNER JOIN mst_bank ON mst_bank_account.BankCode=mst_bank.code "
                + "INNER JOIN mst_chart_of_account ON mst_bank_account.ChartOfAccountCode=mst_chart_of_account.code "
//                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbm ON mst_bank_account.BBMGiroChartOfAccountCode=mst_chart_of_account_bbm.code "
//                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbk ON mst_bank_account.BBKGiroChartOfAccountCode=mst_chart_of_account_bbk.code "
                + "WHERE mst_bank_account.code='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("bbmVoucherNo", Hibernate.STRING)
                .addScalar("bbkVoucherNo", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
//                .addScalar("bbmGiroChartOfAccountCode", Hibernate.STRING)
//                .addScalar("bbmGiroChartOfAccountName", Hibernate.STRING)
//                .addScalar("bbkGiroChartOfAccountCode", Hibernate.STRING)
//                .addScalar("bbkGiroChartOfAccountName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
                .uniqueResult(); 
                 
                return bankAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public BankAccountTemp findData(String code,boolean active){
        try {
            BankAccountTemp bankAccountTemp = (BankAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank_account.Code, "
                + "mst_bank_account.name, "
                + "mst_bank_account.ACNo, "
                + "mst_bank_account.ACName, "
                + "mst_bank_account.BankName, "
                + "mst_bank_account.bankBranch, "
                + "mst_bank_account.bbmVoucherNo, "
                + "mst_bank_account.bbkVoucherNo, "
                + "mst_bank_account.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS ChartOfAccountName, "
                + "mst_bank_account.BBMGiroChartOfAccountCode, "
                + "mst_chart_of_account_bbm.name AS BBMGiroChartOfAccountName, "
                + "mst_bank_account.BBKGiroChartOfAccountCode, "
                + "mst_chart_of_account_bbk.name AS BBKGiroChartOfAccountName,"
                + "mst_bank_account.ActiveStatus "
                + "FROM mst_bank_account "
                + "INNER JOIN mst_chart_of_account ON mst_bank_account.ChartOfAccountCode=mst_chart_of_account.code "
                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbm ON mst_bank_account.BBMGiroChartOfAccountCode=mst_chart_of_account_bbm.code "
                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbk ON mst_bank_account.BBKGiroChartOfAccountCode=mst_chart_of_account_bbk.code "
                + "WHERE mst_bank_account.code='"+code+"' "
                + "AND mst_bank_account.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("bbmVoucherNo", Hibernate.STRING)
                .addScalar("bbkVoucherNo", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("bbmGiroChartOfAccountCode", Hibernate.STRING)
                .addScalar("bbmGiroChartOfAccountName", Hibernate.STRING)
                .addScalar("bbkGiroChartOfAccountCode", Hibernate.STRING)
                .addScalar("bbkGiroChartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
                .uniqueResult(); 
                 
                return bankAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BankAccountTemp findData2(String code,String active){
        try {
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_bank_account.ActiveStatus="+active+" ";
            }
            BankAccountTemp bankAccountTemp = (BankAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_bank_account.Code, "
                + "mst_bank_account.name, "
                + "mst_bank_account.ACNo, "
                + "mst_bank_account.ACName, "
                + "mst_bank_account.BankName, "
                + "mst_bank_account.bankBranch, "
                + "mst_bank_account.bbmVoucherNo, "
                + "mst_bank_account.bbkVoucherNo, "
                + "mst_bank_account.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS ChartOfAccountName, "
                + "mst_bank_account.BBMGiroChartOfAccountCode, "
                + "mst_chart_of_account_bbm.name AS BBMGiroChartOfAccountName, "
                + "mst_bank_account.BBKGiroChartOfAccountCode, "
                + "mst_chart_of_account_bbk.name AS BBKGiroChartOfAccountName,"
                + "mst_bank_account.ActiveStatus "
                + "FROM mst_bank_account "
                + "INNER JOIN mst_chart_of_account ON mst_bank_account.ChartOfAccountCode=mst_chart_of_account.code "
                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbm ON mst_bank_account.BBMGiroChartOfAccountCode=mst_chart_of_account_bbm.code "
                + "INNER JOIN mst_chart_of_account mst_chart_of_account_bbk ON mst_bank_account.BBKGiroChartOfAccountCode=mst_chart_of_account_bbk.code "
                + "WHERE mst_bank_account.code='"+code+"' "
                + concat_qry_active)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("bbmVoucherNo", Hibernate.STRING)
                .addScalar("bbkVoucherNo", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("bbmGiroChartOfAccountCode", Hibernate.STRING)
                .addScalar("bbmGiroChartOfAccountName", Hibernate.STRING)
                .addScalar("bbkGiroChartOfAccountCode", Hibernate.STRING)
                .addScalar("bbkGiroChartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
                .uniqueResult(); 
                 
                return bankAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(BankAccount bankAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            bankAccount.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            bankAccount.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(bankAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
            EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
            bankAccount.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(BankAccount bankAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            bankAccount.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bankAccount.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(bankAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
            EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
            bankAccount.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + BankAccountField.BEAN_NAME + " WHERE " + BankAccountField.CODE + " = :prmCode")
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
    
    public BankAccountTemp min() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_bank_account.Code, "
                    + "mst_bank_account.Name "
                    + "FROM mst_bank_account "
                    + "ORDER BY mst_bank_account.Code "
                    + "LIMIT 0,1";
            BankAccountTemp bankAccountTemp =(BankAccountTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
            .uniqueResult();   
            
            return bankAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BankAccountTemp max() {
        try {
            
            String qry =
                        "SELECT "
                    + "mst_bank_account.Code, "
                    + "mst_bank_account.Name "
                    + "FROM mst_bank_account "
                    + "ORDER BY mst_bank_account.Code DESC "
                    + "LIMIT 0,1";
            BankAccountTemp bankAccountTemp =(BankAccountTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(BankAccountTemp.class))
            .uniqueResult();   
            
            return bankAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }       
}
