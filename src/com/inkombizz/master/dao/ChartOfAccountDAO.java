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

import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.ChartOfAccountField;
import com.inkombizz.master.model.ChartOfAccountTemp;


public class ChartOfAccountDAO {
    
    private HBMSession hbmSession;
	
    public ChartOfAccountDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(String code,String name,String Type,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_chart_of_account.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) "
                + "FROM mst_chart_of_account "
                + "WHERE mst_chart_of_account.code LIKE '%"+code+"%' "
                + "AND mst_chart_of_account.name LIKE '%"+name+"%' "
                + "AND mst_chart_of_account.AccountType LIKE '%"+Type+"%' "
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
            if (criteria.list().isEmpty())
                return 0;
            else
                return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    

    public List<ChartOfAccountTemp> findData(String code, String name,String Type,String active,int from, int row) {
        try {   
            
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_chart_of_account.ActiveStatus="+active+" ";
            }
            
            List<ChartOfAccountTemp> list = (List<ChartOfAccountTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_chart_of_account.Code, "
                + "mst_chart_of_account.name, "
                + "CASE "
                + "WHEN mst_chart_of_account.Accounttype='H' THEN 'Heading' "
                + "WHEN mst_chart_of_account.Accounttype='G' THEN 'Group' "
                + "WHEN mst_chart_of_account.Accounttype='S' THEN 'Sub' "
                + "END AS accounttype, "
                + "mst_chart_of_account.activeStatus "
                + "FROM mst_chart_of_account "
                + "WHERE mst_chart_of_account.code LIKE '%"+code+"%' "
                + "AND mst_chart_of_account.name LIKE '%"+name+"%' "
                + "AND mst_chart_of_account.AccountType LIKE '%"+Type+"%' "
                + concat_qry
                + "ORDER BY mst_chart_of_account.code "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("accountType", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    /* 
        *UPDATE DATA 
    */
    public ChartOfAccountTemp findData(String code) {
        try {
            ChartOfAccountTemp chartOfAccountTemp = (ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_chart_of_account.Code, "
                + "mst_chart_of_account.name, "
                + "mst_chart_of_account.Accounttype, "
                + "mst_chart_of_account.activeStatus,"
                + "mst_chart_of_account.BBMStatus, "
//                + "mst_chart_of_account.BBKStatus, "
                + "mst_chart_of_account.BKMStatus, "
//                + "mst_chart_of_account.BKKStatus, "
                + "mst_chart_of_account.CreatedBy, "
                + "mst_chart_of_account.CreatedDate "
                + "FROM mst_chart_of_account "
                + "WHERE mst_chart_of_account.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("accountType", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("bbmStatus", Hibernate.BOOLEAN)
                .addScalar("bbkStatus", Hibernate.BOOLEAN)
//                .addScalar("bbkStatus", Hibernate.BOOLEAN)
                .addScalar("bkmStatus", Hibernate.BOOLEAN)
//                .addScalar("bkkStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                .uniqueResult(); 
                 
                return chartOfAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    /* 
        *TAB SEARCH DATA 
    */
    public ChartOfAccountTemp findData(String code,String type,boolean active) {
        try {
            ChartOfAccountTemp chartOfAccountTemp = (ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_chart_of_account.Code, "
                + "mst_chart_of_account.name "
                + "FROM mst_chart_of_account "
                + "WHERE mst_chart_of_account.code ='"+code+"' "
                + "AND mst_chart_of_account.Accounttype ='"+type+"' "
                + "AND mst_chart_of_account.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                .uniqueResult(); 
                 
                return chartOfAccountTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public void save(ChartOfAccount chartOfAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            chartOfAccount.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            chartOfAccount.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(chartOfAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    chartOfAccount.getCode(), ""));
             
            hbmSession.hTransaction.commit();
            
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            //System.out.println("Error DAO : " + e.getMessage());
            throw e;
        }
    }

    public void update(ChartOfAccount chartOfAccount, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            chartOfAccount.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            chartOfAccount.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(chartOfAccount);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.saveCOA(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    chartOfAccount.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ChartOfAccountField.BEAN_NAME + " WHERE " + ChartOfAccountField.CODE + " = :prmCode")
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
    
    public ChartOfAccountTemp min() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_chart_of_account.Code, "
                    + "mst_chart_of_account.Name "
                    + "FROM mst_chart_of_account "
                    + "ORDER BY mst_chart_of_account.Code "
                    + "LIMIT 0,1";
            ChartOfAccountTemp chartofAccountTemp =(ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                    .uniqueResult();   
            
            return chartofAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp max() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_chart_of_account.Code, "
                    + "mst_chart_of_account.Name "
                    + "FROM mst_chart_of_account "
                    + "ORDER BY mst_chart_of_account.Code DESC "
                    + "LIMIT 0,1";
            ChartOfAccountTemp chartofAccountTemp =(ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                    .uniqueResult();   
            
            return chartofAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp minSub() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_chart_of_account.Code, "
                    + "mst_chart_of_account.Name "
                    + "FROM mst_chart_of_account "
                    + "WHERE mst_chart_of_account.AccountType = 'S' "
                    + "ORDER BY mst_chart_of_account.Code "
                    + "LIMIT 0,1";
            ChartOfAccountTemp chartofAccountTemp =(ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                    .uniqueResult();   
            
            return chartofAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    
    public ChartOfAccountTemp maxSub() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_chart_of_account.Code, "
                    + "mst_chart_of_account.Name "
                    + "FROM mst_chart_of_account "
                    + "WHERE mst_chart_of_account.AccountType = 'S' "
                    + "ORDER BY mst_chart_of_account.Code DESC "
                    + "LIMIT 0,1";
            ChartOfAccountTemp chartofAccountTemp =(ChartOfAccountTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                    .uniqueResult();   
            
            return chartofAccountTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataHeaderCode(String code,String name,String Type,String headerCode){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(mst_chart_of_account.Code) "
                + "FROM mst_chart_of_account "
                + "WHERE mst_chart_of_account.code LIKE '"+code+"%' "
                + "AND mst_chart_of_account.name LIKE '%"+name+"%' "
                + "AND mst_chart_of_account.AccountType='"+Type+"' "
                + "AND LEFT(mst_chart_of_account.code,2)='"+headerCode+"'"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ChartOfAccountTemp> findDataLookUpHeader(String code, String name,String Type,String headerCode,int from, int row) {
        try {   
            List<ChartOfAccountTemp> list = (List<ChartOfAccountTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_chart_of_account.Code AS code, "
                + "mst_chart_of_account.name AS name, "
                + "mst_chart_of_account.Accounttype AS accountType "
                + "FROM "
                + "mst_chart_of_account "
                + "WHERE "
                + "mst_chart_of_account.code LIKE '"+code+"%' "
                + "AND mst_chart_of_account.name LIKE '%"+name+"%' "
                + "AND mst_chart_of_account.Accounttype = '"+Type+"' "
                + "AND LEFT(mst_chart_of_account.code,2)='"+headerCode+"'"
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("accountType", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ChartOfAccountTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
}